import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

class CourseController extends GetxController {
  TextEditingController coursenameController = TextEditingController();
  TextEditingController tutornameController = TextEditingController();
  TextEditingController courseDurationController = TextEditingController();
  TextEditingController courseFeeController = TextEditingController();
  TextEditingController courseDesController = TextEditingController();

  RxInt totalStudents = 0.obs;

  Rx<ButtonState> buttonstate = ButtonState.idle.obs;

  final formKey = GlobalKey<FormState>();

  void clearFields() {
    coursenameController.clear();
    tutornameController.clear();
    courseDurationController.clear();
    courseFeeController.clear();
    courseDesController.clear();
  }

  Future<void> createCourses() async {
    log("Creating Course .....");
    final uuid = const Uuid().v1();
    final courseDetails = CourseModel(
        courseName: coursenameController.text,
        courseDes: courseDesController.text,
        duration: courseDurationController.text,
        rate: courseFeeController.text,
        courseId: uuid);

    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Courses')
          .doc(courseDetails.courseId)
          .set(courseDetails.toMap())
          .then((value) async {
        clearFields();
        buttonstate.value = ButtonState.success;
        showToast(msg: "Courses Created Successfully");
        await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
          buttonstate.value = ButtonState.idle;
        });
      });
    } catch (e) {
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      log("Courses Creation Error .... $e");
    }
  }

  Future<void> deleteCourse(String courseId) async {
    log("courseId -----------$courseId");
    try {
      server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Courses')
          .doc(courseId)
          .delete()
          .then((value) {
        showToast(msg: "Courses deleted Successfully");
      });
    } catch (e) {
      log("Courses delete$e");
    }
  }

  Stream<int> fetchTotalStudents(String courseId) {
    CollectionReference coursesRef = server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Courses')
        .doc(courseId)
        .collection('Students');

    return coursesRef.snapshots().map((snapshot) => snapshot.docs.length);
  }
}
