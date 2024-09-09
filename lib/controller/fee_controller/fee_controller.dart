import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';

class FeeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();

  final _fbServer = server
      .collection('DrivingSchoolCollection')
      .doc(UserCredentialsController.schoolId);

  addStudentfeeFullyPaid(
    StudentModel studentModel,
    String status,
    CourseModel course,
  ) async {
    DocumentSnapshot batchDoc = await _fbServer
        .collection('FeesCollection')
        .doc(studentModel.batchId)
        .get();

    if (!batchDoc.exists) {
      await _fbServer
          .collection('FeesCollection')
          .doc(studentModel.batchId)
          .set({
        'batchId': studentModel.batchId,
      });
    }
    DocumentSnapshot courseDoc = await _fbServer
        .collection('FeesCollection')
        .doc(studentModel.batchId)
        .collection('Courses')
        .doc(course.courseId)
        .get();

    if (!courseDoc.exists) {
      await _fbServer
          .collection('FeesCollection')
          .doc(studentModel.batchId)
          .collection('Courses')
          .doc(course.courseId)
          .set({
        'courseId': course.courseId,
      });
    }
    await _fbServer
        .collection('FeesCollection')
        .doc(studentModel.batchId)
        .collection('Courses')
        .doc(course.courseId)
        .collection('Students')
        .doc(studentModel.docid)
        .set({
      'studentName': studentModel.studentName,
      'studentID': studentModel.docid,
      'feeStatus': status,
      'amountPaid': course.rate,
      'totalAmount': course.rate,
      'paidStatus': true
    }).then((value) async {
      await acceptStudentToCourse(studentModel, status, course.courseId);
      showToast(msg: 'Student fees updated');
      log("Fees Status Updated");
    });
  }

  Future<void> addStudentFeeColl(
    StudentModel studentModel,
    String status,
    CourseModel course,
  ) async {
    try {
      int amountPaid = int.tryParse(amountController.text) ?? 0;
      DocumentSnapshot batchDoc = await _fbServer
          .collection('FeesCollection')
          .doc(studentModel.batchId)
          .get();

      if (!batchDoc.exists) {
        await _fbServer
            .collection('FeesCollection')
            .doc(studentModel.batchId)
            .set({
          'batchId': studentModel.batchId,
        });
      }
      DocumentSnapshot courseDoc = await _fbServer
          .collection('FeesCollection')
          .doc(studentModel.batchId)
          .collection('Courses')
          .doc(course.courseId)
          .get();

      if (!courseDoc.exists) {
        await _fbServer
            .collection('FeesCollection')
            .doc(studentModel.batchId)
            .collection('Courses')
            .doc(course.courseId)
            .set({
          'courseId': course.courseId,
        });
      }
      DocumentSnapshot studentDoc = await _fbServer
          .collection('FeesCollection')
          .doc(studentModel.batchId)
          .collection('Courses')
          .doc(course.courseId)
          .collection('Students')
          .doc(studentModel.docid)
          .get();

      if (studentDoc.exists && studentDoc['amountPaid'] != course.rate) {
        await _fbServer
            .collection('FeesCollection')
            .doc(studentModel.batchId)
            .collection('Courses')
            .doc(course.courseId)
            .collection('Students')
            .doc(studentModel.docid)
            .update({
          'feeStatus': status,
          'amountPaid':
              status == 'not paid' ? 0 : FieldValue.increment(amountPaid),
          'paidStatus': false
        });
      } else {
        await _fbServer
            .collection('FeesCollection')
            .doc(studentModel.batchId)
            .collection('Courses')
            .doc(course.courseId)
            .collection('Students')
            .doc(studentModel.docid)
            .set({
          'studentName': studentModel.studentName,
          'studentID': studentModel.docid,
          'feeStatus': status,
          'amountPaid': amountPaid,
          'totalAmount': course.rate,
          'paidStatus': false,
        });
      }
      await acceptStudentToCourse(studentModel, status, course.courseId);

      amountController.clear();
      update();
      showToast(msg: 'Student fees updated');
      log("Fees Status Updated");
    } catch (e) {
      log("FeesCollection error: $e");
    }
  }

  Future<void> acceptStudentToCourse(
    StudentModel studentModel,
    String status,
    String courseID,
  ) async {
    try {
      final reqStudentDoc = await _fbServer
          .collection('Courses')
          .doc(courseID)
          .collection("RequestedStudents")
          .doc(studentModel.docid)
          .get();

      if (reqStudentDoc.exists) {
        await reqStudentDoc.reference.delete();
        await _fbServer
            .collection('Courses')
            .doc(courseID)
            .collection("Students")
            .doc(studentModel.docid)
            .set(studentModel.toMap());
        showToast(msg: 'Student Added to Course');
        log("Student accepted and Added to the course.");
      } else {
        log("Student not found in RequestedStudents collection.");
      }
    } catch (e) {
      log("Students approval error: $e");
    }
  }
}
