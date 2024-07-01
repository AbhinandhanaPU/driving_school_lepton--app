import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';

class CourseController extends GetxController {
  TextEditingController coursenameController = TextEditingController();
  TextEditingController tutornameController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  RxInt totalStudents = 0.obs;

  final formKey = GlobalKey<FormState>();

  void clearTextFields() {
    coursenameController.clear();
    tutornameController.clear();
    durationController.clear();
    feeController.clear();
    descriptionController.clear();
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
