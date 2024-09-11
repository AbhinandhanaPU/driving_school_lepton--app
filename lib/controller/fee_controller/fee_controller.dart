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

  RxBool onTapBtach = false.obs;
  RxString batchId = ''.obs;

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

  Future<Map<String, Map<String, dynamic>>> fetchUnpaidStudents() async {
    final unpaidStudentsWithFeeData = <String, Map<String, dynamic>>{};

    try {
      final batches = await _fbServer.collection('FeesCollection').get();

      for (var batchDoc in batches.docs) {
        final batchId = batchDoc.id;

        final courses = await _fbServer
            .collection('FeesCollection')
            .doc(batchId)
            .collection('Courses')
            .get();

        for (var courseDoc in courses.docs) {
          final courseId = courseDoc.id;

          final students = await _fbServer
              .collection('FeesCollection')
              .doc(batchId)
              .collection('Courses')
              .doc(courseId)
              .collection('Students')
              .where('paidStatus', isEqualTo: false)
              .get();

          for (var studentDoc in students.docs) {
            final studentId = studentDoc.data()['studentID'];

            final studentData = await server
                .collection('DrivingSchoolCollection')
                .doc(UserCredentialsController.schoolId)
                .collection('Students')
                .doc(studentId)
                .get();

            if (studentData.exists) {
              final studentModel = StudentModel.fromMap(studentData.data()!);

              if (unpaidStudentsWithFeeData.containsKey(studentId)) {
                final existingData = unpaidStudentsWithFeeData[studentId];
                existingData!['amountPaid'] += studentDoc.data()['amountPaid'];
                existingData['totalAmount'] += studentDoc.data()['totalAmount'];
              } else {
                unpaidStudentsWithFeeData[studentId] = {
                  'studentModel': studentModel,
                  'amountPaid': studentDoc.data()['amountPaid'],
                  'totalAmount': studentDoc.data()['totalAmount'],
                };
              }
            }
          }
        }
      }
    } catch (e) {
      log("Error fetching unpaid students: $e");
    }

    return unpaidStudentsWithFeeData;
  }

  Future<Map<String, Map<String, dynamic>>> fetchBatchStudents() async {
    final studentFeeData = <String, Map<String, dynamic>>{};

    try {
      if (batchId.value.isEmpty) {
        throw Exception("Batch ID is not selected.");
      }

      final courses = await _fbServer
          .collection('FeesCollection')
          .doc(batchId.value)
          .collection('Courses')
          .get();

      for (var courseDoc in courses.docs) {
        final courseId = courseDoc.id;

        final students = await _fbServer
            .collection('FeesCollection')
            .doc(batchId.value)
            .collection('Courses')
            .doc(courseId)
            .collection('Students')
            .get();

        for (var studentDoc in students.docs) {
          final studentId = studentDoc.data()['studentID'];

          final studentData = await server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection('Students')
              .doc(studentId)
              .get();

          if (studentData.exists) {
            final studentModel = StudentModel.fromMap(studentData.data()!);

            final amountPaid = studentDoc.data()['amountPaid'];
            final totalAmount = studentDoc.data()['totalAmount'];
            final pendingAmount = totalAmount - amountPaid;

            studentFeeData[studentId] = {
              'studentModel': studentModel,
              'amountPaid': amountPaid,
              'totalAmount': totalAmount,
              'pendingAmount': pendingAmount,
            };
          }
        }
      }

      final sortedStudentFeeData = Map.fromEntries(
        studentFeeData.entries.toList()
          ..sort((a, b) {
            final pendingAmountA = a.value['pendingAmount'];
            final pendingAmountB = b.value['pendingAmount'];
            return pendingAmountB.compareTo(pendingAmountA);
          }),
      );

      return sortedStudentFeeData;
    } catch (e) {
      log("Error fetching batch students: $e");
      return studentFeeData;
    }
  }
}
