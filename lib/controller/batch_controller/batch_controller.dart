import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/course_controller/course_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/model/batch_model/batch_model.dart';

class BatchController extends GetxController {
  final courseCtrl = Get.put(CourseController());

  final formKey = GlobalKey<FormState>();

  Rx<ButtonState> buttonstate = ButtonState.idle.obs;

  TextEditingController batchNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  

  Rxn<BatchModel> batchModelData = Rxn<BatchModel>();
    RxString ontapBatchName= 'dd'.obs;
  RxBool onTapBtach = false.obs;
  RxString batchId = ''.obs;

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
          .update(updatedData )
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
      final studentResult = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .doc(courseCtrl.studentDocID.value)
          .get();
      if (courseCtrl.studentDocID.value != '') {
        final data = StudentModel.fromMap(studentResult.data()!);
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Batch')
            .doc(batchId.value)
            .collection('Students')
            .doc(courseCtrl.studentDocID.value)
            .set(data.toMap())
            .then((value) async {
          buttonstate.value = ButtonState.success;
          showToast(msg: "Student added Successfully");
          await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
            buttonstate.value = ButtonState.idle;
          });
        });
  //    }
    // } catch (e) {
    //   buttonstate.value = ButtonState.fail;
    //   await Future.delayed(const Duration(seconds: 2)).then((value) {
    //     buttonstate.value = ButtonState.idle;
    //   });
       } else {
      log("Student document not found", name: "Batch");
      buttonstate.value = ButtonState.fail;
      showToast(msg: "Student not found. Please try again.");
    }
  } catch (e) {
    buttonstate.value = ButtonState.fail;
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      buttonstate.value = ButtonState.idle;
    });
      log("Error .... $e");
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

  Stream<int> fetchTotalStudents(String batchId) {
    CollectionReference coursesRef = server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Batch')
        .doc(batchId)
        .collection('Students');

    return coursesRef.snapshots().map((snapshot) => snapshot.docs.length);
  }
}
