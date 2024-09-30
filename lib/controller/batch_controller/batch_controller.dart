import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/course_controller/course_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/batch_model/batch_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

class BatchController extends GetxController {
  final courseCtrl = Get.put(CourseController());

  final formKey = GlobalKey<FormState>();

  Rx<ButtonState> buttonstate = ButtonState.idle.obs;

  TextEditingController batchNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  RxList<BatchModel> batches = RxList<BatchModel>();
  Rxn<BatchModel> batchModelData = Rxn<BatchModel>();
  RxString batchId = ''.obs;
  List<StudentModel> studentList = [];

  Rx<bool> onBatchWiseView = Rx<bool>(false);
  RxString batchView = ''.obs;

  Future<void> createBatch() async {
    final uuid = const Uuid().v1();
    final batchDetails = BatchModel(
        batchName: batchNameController.text,
        date: dateController.text,
        batchId: uuid);
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Batch')
          .doc(batchDetails.batchId)
          .set(batchDetails.toMap())
          .then((value) async {
        batchNameController.clear();
        dateController.clear();
        buttonstate.value = ButtonState.success;

        showToast(msg: "Batch Created Successfully");
        await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
          buttonstate.value = ButtonState.idle;
        });
      });
    } catch (e) {
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      log("Error .... $e", name: "Batch");
    }
  }

  Future<void> updateBatch(String batchId, BuildContext context) async {
    try {
      final updatedData = {
        'batchName': batchNameController.text,
        'date': dateController.text,
      };
      log("Updating batch with data: $updatedData", name: "Batch upda");
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Batch')
          .doc(batchId)
          .update(updatedData)
          .then((value) {
            batchNameController.clear();
            dateController.clear();
          })
          .then((value) => Navigator.pop(context))
          .then((value) => showToast(msg: 'Batch Updated!'));
    } catch (e) {
      showToast(msg: 'Batch  Updation failed.Try Again');
      log("Batch Updation failed $e");
    }
  }

  Future<void> deleteBatch(String batchId, BuildContext context) async {
    log("BatchId -----------$batchId");
    server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Batch')
        .doc(batchId)
        .delete();
  }

  Future<void> addStudent() async {
    try {
      final studentDocID = courseCtrl.studentDocID.value;

      if (studentDocID != '') {
        final studentResult = await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Students')
            .doc(studentDocID)
            .get();

        if (studentResult.exists) {
          final studentData = studentResult.data()!;
          final currentBatchId = studentData['batchId'];
          if (currentBatchId != '' && currentBatchId != batchId.value) {
            buttonstate.value = ButtonState.fail;
            showToast(msg: "Student is already enrolled in another batch.");
            return;
          }

          await server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection('Students')
              .doc(studentDocID)
              .update({"batchId": batchId.value});
          final updatedStudentResult = await server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection('Students')
              .doc(studentDocID)
              .get();

          final data = StudentModel.fromMap(updatedStudentResult.data()!);

          await server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection('Batch')
              .doc(batchId.value)
              .collection('Students')
              .doc(studentDocID)
              .set(data.toMap())
              .then((value) async {
            buttonstate.value = ButtonState.success;
            showToast(msg: "Student added successfully.");
            await Future.delayed(const Duration(seconds: 2)).then((value) {
              buttonstate.value = ButtonState.idle;
            });
          });
        } else {
          log("Student document not found", name: "Batch");
          buttonstate.value = ButtonState.fail;
          showToast(msg: "Student not found. Please try again.");
        }
      } else {
        log("Student document ID is empty", name: "Batch");
        buttonstate.value = ButtonState.fail;
        showToast(msg: "Student document ID is empty.");
      }
    } catch (e) {
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      log("Error: $e");
    }
  }

  Future<void> deleteStudent({required String docId}) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Batch')
          .doc(batchId.value)
          .collection('Students')
          .doc(docId)
          .delete()
          .then((value) {
        showToast(msg: "Deleted Successfully");
        log("Deleted Successfully");
        Get.back();
      });
    } catch (e) {
      log(e.toString(), name: "Batch");
    }
  }

  Stream<List<StudentModel>> fetchFilteredStudents(String batchId) {
    CollectionReference batchStudentsRef = server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Batch')
        .doc(batchId)
        .collection('Students');

    CollectionReference allStudentsRef = server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Students');

    return batchStudentsRef.snapshots().asyncMap((batchSnapshot) async {
      List<String> batchStudentIds =
          batchSnapshot.docs.map((doc) => doc.id).toList();

      if (batchStudentIds.isEmpty) {
        return [];
      }

      QuerySnapshot filteredStudentsSnapshot = await allStudentsRef
          .where('docid', whereIn: batchStudentIds)
          .where('status', isEqualTo: true)
          .get();

      List<StudentModel> filteredStudents = filteredStudentsSnapshot.docs
          .map(
              (doc) => StudentModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return filteredStudents;
    });
  }

  Future<void> shiftStudentToAnotherBatch({
    required String studentDocId,
    required String oldBatchId,
    required String newBatchId,
  }) async {
    try {
      // Fetch the student data from the old batch
      final studentSnapshot = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Batch')
          .doc(oldBatchId)
          .collection('Students')
          .doc(studentDocId)
          .get();

      if (studentSnapshot.exists) {
        final studentData = StudentModel.fromMap(studentSnapshot.data()!);

        // Add the student to the new batch
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Batch')
            .doc(newBatchId)
            .collection('Students')
            .doc(studentDocId)
            .set(studentData.toMap());

        // Remove the student from the old batch
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Batch')
            .doc(oldBatchId)
            .collection('Students')
            .doc(studentDocId)
            .delete();

        showToast(msg: "Student shifted successfully");
      } else {
        showToast(msg: "Student not found in the old batch");
      }
    } catch (e) {
      showToast(msg: "Error shifting student. Please try again.");
      log("Error shifting student: $e", name: "Batch");
    }
  }

  Future<void> fetchBatches() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Batch')
          .get();

      batches.value =
          snapshot.docs.map((doc) => BatchModel.fromMap(doc.data())).toList();
    } catch (e) {
      log("Error fetching batches: $e");
    }
  }
}
