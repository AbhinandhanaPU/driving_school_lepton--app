import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/course_controller/course_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/model/test_model/test_model.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

class TestController extends GetxController {
  final courseCtrl = Get.put(CourseController());
  RxBool onTapTest = false.obs;
  final formKey = GlobalKey<FormState>();
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;

  TextEditingController testDateController = TextEditingController();
  TextEditingController testTimeController = TextEditingController();
  TextEditingController testLocationController = TextEditingController();

  TextEditingController testDateEditController = TextEditingController();
  TextEditingController testTimeEditController = TextEditingController();
  TextEditingController testLocationEditController = TextEditingController();

  Rxn<TestModel> testModelData = Rxn<TestModel>();
  RxString docId = ''.obs;

  clearFields() {
    testDateController.clear();
    testTimeController.clear();
    testLocationController.clear();

    testDateEditController.clear();
    testTimeEditController.clear();
    testLocationEditController.clear();
  }

  Future<void> addTestDate() async {
    final uuid = const Uuid().v1();
    final testDetails = TestModel(
        testDate: testDateController.text,
        testTime: testTimeController.text,
        location: testLocationController.text,
        docId: uuid);

    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('DrivingTest')
          .doc(testDetails.docId)
          .set(testDetails.toMap())
          .then((value) async {
        clearFields();
        buttonstate.value = ButtonState.success;

        showToast(msg: "Driving Created Successfully");
        await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
          buttonstate.value = ButtonState.idle;
        });
      });
    } catch (e) {
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      log("Error .... $e");
    }
  }

  Future<void> editTest(String docId, BuildContext context) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('DrivingTest')
          .doc(docId)
          .update({
            'testDate': testDateEditController.text,
            'testTime': testTimeEditController.text,
            'location': testLocationEditController.text,
          })
          .then((value) {
            clearFields();
          })
          .then((value) => Navigator.pop(context))
          .then((value) => showToast(msg: 'test details Updated!'));
    } catch (e) {
      showToast(msg: 'test details  Updation failed.Try Again');
      log("test details Updation failed $e");
    }
  }

  Future<void> deleteTest({required String docId}) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('DrivingTest')
          .doc(docId)
          .delete()
          .then((value) {
        showToast(msg: "Deleted Successfully");
        log("Deleted Successfully");
        Get.back();
      });
    } catch (e) {
      log(e.toString(), name: "TestController");
    }
  }

  Future<void> addStudent(String testID) async {
    try {
      if (courseCtrl.studentDocID.value != '') {
        final studentResult = await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Students')
            .doc(courseCtrl.studentDocID.value)
            .get();
        final data = StudentModel.fromMap(studentResult.data()!);
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('DrivingTest')
            .doc(testID)
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
      final docidoftest = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection("DrivingTest")
          .get();

      if (docidoftest.docs.isNotEmpty) {
        for (var testDoc in docidoftest.docs) {
          final testDocid = testDoc.id;
          await server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection('DrivingTest')
              .doc(testDocid)
              .collection('Students')
              .doc(docId)
              .delete()
              .then((value) {
            showToast(msg: "Deleted Successfully");
            log("Deleted Successfully");
            Get.back();
          });
        }
      } else {
        log("No Test found");
      }
    } catch (e) {
      log("Student deletion error:$e");
    }
  }

  Stream<List<StudentModel>> fetchStudentsWithStatusTrue(String testId) {
    return server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('DrivingTest')
        .doc(testId)
        .collection('Students')
        .snapshots()
        .asyncMap((snapshot) async {
      List<String> studentIds = snapshot.docs.map((doc) => doc.id).toList();

      if (studentIds.isEmpty) return [];

      QuerySnapshot studentSnapshot = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .where('status', isEqualTo: true)
          .where('docid', whereIn: studentIds)
          .get();

      return studentSnapshot.docs
          .map(
              (doc) => StudentModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Future<List<Map<String, dynamic>>> fetchOrderedDrivingTests() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('DrivingTest')
          .get();

      List<Map<String, dynamic>> tests = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        try {
          DateTime parsedDate =
              DateFormat('dd-MM-yyyy').parse(data['testDate']);
          data['parsedTestDate'] = parsedDate;
        } catch (e) {
          log('Error parsing date: ${data['testDate']}, Error: $e');
          data['parsedTestDate'] = DateTime(1970, 1, 1);
        }
        return data;
      }).toList();

      tests.sort((a, b) => b['parsedTestDate'].compareTo(a['parsedTestDate']));

      return tests;
    } catch (e) {
      log('Error fetching driving tests: $e');
      return [];
    }
  }

  Future<List<TestModel>> fetchStudentDrivingTests() async {
    final drivingTestsSnapshot = await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('DrivingTest')
        .get();

    List<TestModel> studentDrivingTests = [];
    for (var testDoc in drivingTestsSnapshot.docs) {
      final studentDoc = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('DrivingTest')
          .doc(testDoc.id)
          .collection('Students')
          .doc(UserCredentialsController.studentModel!.docid)
          .get();

      if (studentDoc.exists) {
        studentDrivingTests.add(TestModel.fromMap(testDoc.data()));
      }
    }

    return studentDrivingTests;
  }
}
