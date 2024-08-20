import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';

class StudentController extends GetxController {
  List<StudentModel> studentProfileList = [];
  TextEditingController amountController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final _fbServer = server
      .collection('DrivingSchoolCollection')
      .doc(UserCredentialsController.schoolId);

  Future<void> fetchAllStudents() async {
    try {
      log("fetchAllStudents......................");
      final data = await _fbServer.collection('Students').get();
      studentProfileList =
          data.docs.map((e) => StudentModel.fromMap(e.data())).toList();
      log(studentProfileList[0].toString());
    } catch (e) {
      showToast(msg: "User Data Error");
    }
  }

  Future<void> fetchAllArchivesStudents() async {
    try {
      log("fetchAllArchivesStudents......................");
      studentProfileList = [];
      final data = await _fbServer.collection('Archives').get();
      studentProfileList =
          data.docs.map((e) => StudentModel.fromMap(e.data())).toList();
      log(studentProfileList[0].toString());
    } catch (e) {
      showToast(msg: "User Data Error");
    }
  }

  Future<void> deleteStudents(StudentModel studentModel) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .doc(studentModel.docid)
          .delete()
          .then((value) => log("Student deleted"));
    } catch (e) {
      log("Student deletion error:$e");
    }
  }

  Future<void> deleteStudentsFromCourse(
    StudentModel studentModel,
    String courseDocid,
  ) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection("Courses")
          .doc(courseDocid)
          .collection('Students')
          .doc(studentModel.docid)
          .delete()
          .then((value) => log("Student deleted from course: $courseDocid"));
    } catch (e) {
      log("Student deletion error:$e");
    }
  }

  Future<void> updateStudentStatus(
      StudentModel studentModel, String newStatus) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .doc(studentModel.docid)
          .update({'status': newStatus}).then((value) {
        studentModel.status = newStatus;
        update();
        log("Student status updated to $newStatus");
      });
    } catch (e) {
      log("Student status update error: $e");
    }
  }

  Stream<List<String>> fetchStudentsCourse(StudentModel studentModel) async* {
    List<String> courseNames = [];

    try {
      final docidofcourse = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection("Courses")
          .get();

      if (docidofcourse.docs.isNotEmpty) {
        for (var courseDoc in docidofcourse.docs) {
          final courseDocid = courseDoc.id;

          // fetch the student from each course
          final std = await server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection("Courses")
              .doc(courseDocid)
              .collection('Students')
              .doc(studentModel.docid)
              .get();

          if (std.exists) {
            // fetch the course document to get the course name
            final courseDocument = await server
                .collection('DrivingSchoolCollection')
                .doc(UserCredentialsController.schoolId)
                .collection("Courses")
                .doc(courseDocid)
                .get();

            if (courseDocument.exists) {
              final courseName = courseDocument.data()?['courseName'];
              if (courseName != null) {
                courseNames.add(courseName);
                log("courseNames : $courseNames");
                yield courseNames;
              }
            }
          }
        }
      }
    } catch (e) {
      log("Student course fetching error: $e");
    }
  }

  Future<void> addStudentReqToCourse(
    String courseID,
    BuildContext context,
  ) async {
    try {
      log("UserCredentialsController.studentModel!.docid ${UserCredentialsController.studentModel!.docid}");
      log("std course id $courseID");
      final studentResult = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .doc(UserCredentialsController.studentModel!.docid)
          .get();
      final stdData = StudentModel.fromMap(studentResult.data()!);
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Courses')
          .doc(courseID)
          .collection('RequestedStudents')
          .doc(UserCredentialsController.studentModel!.docid)
          .set(stdData.toMap())
          .then((value) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Message'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Your payment request sent Successfully ')
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            );
          },
        );
      });
    } catch (e) {
      log(e.toString(), name: 'StudentController');
      showToast(msg: 'Somthing went wrong please try again');
    }
  }

  Future<void> addStudentToCourseOnline(
      String courseID, BuildContext context) async {
    try {
      log("UserCredentialsController.studentModel!.docid ${UserCredentialsController.studentModel!.docid}");
      log("std course id $courseID");
      final studentResult = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .doc(UserCredentialsController.studentModel!.docid)
          .get();
      final stdData = StudentModel.fromMap(studentResult.data()!);
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Courses')
          .doc(courseID)
          .collection('Students')
          .doc(UserCredentialsController.studentModel!.docid)
          .set(stdData.toMap())
          .then((value) async {
        final reqCourseStd = await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Courses')
            .doc(courseID)
            .collection('RequestedStudents')
            .doc(UserCredentialsController.studentModel!.docid)
            .get();
        if (reqCourseStd.exists) {
          await server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection('Courses')
              .doc(courseID)
              .collection('RequestedStudents')
              .doc(UserCredentialsController.studentModel!.docid)
              .delete();
        }
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Message'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[Text('Your Successfully added to course')],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            );
          },
        );
      });
    } catch (e) {
      log(e.toString(), name: 'StudentController');
      showToast(msg: 'Somthing went wrong please try again');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchStdFeeStatus() async* {
    try {
      final docOfFee = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('FeeCollection')
          .get();

      if (docOfFee.docs.isNotEmpty) {
        for (var courseDoc in docOfFee.docs) {
          final courseDocId = courseDoc.id;
          final studentDocSnapshot = await server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection("FeeCollection")
              .doc(courseDocId)
              .collection('Students')
              .doc(UserCredentialsController.studentModel!.docid)
              .get();

          if (studentDocSnapshot.exists) {
            yield* server
                .collection('DrivingSchoolCollection')
                .doc(UserCredentialsController.schoolId)
                .collection("FeeCollection")
                .doc(courseDocId)
                .collection('Students')
                .where(UserCredentialsController.studentModel!.docid)
                .snapshots();
          }
        }
      } else {
        log('No fee data available');
      }
    } catch (error) {
      log('Student fee fetching error $error');
    }
  }

  Future<void> addStudentFeeColl(
    StudentModel studentModel,
    String status,
    String courseID,
  ) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('FeeCollection')
          .doc(courseID)
          .set({'docId': courseID}).then((value) async {
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('FeeCollection')
            .doc(courseID)
            .collection('Students')
            .doc(studentModel.docid)
            .set({
          'studentName': studentModel.studentName,
          'studentID': studentModel.docid,
          'feeStatus': status,
          'pendingAmount':
              amountController.text == "" ? 0 : amountController.text,
          'courseID': courseID
        }).then((value) async {
          await acceptStudentToCourse(studentModel, status, courseID);
          amountController.clear();
          update();
          showToast(msg: 'student fees updated');
          log("Fees Status Updated");
        });
      });
    } catch (e) {
      log(" FeeCollection error: $e");
    }
  }

  Future<void> acceptStudentToCourse(
    StudentModel studentModel,
    String status,
    String courseID,
  ) async {
    try {
      final reqStudentDoc = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Courses')
          .doc(courseID)
          .collection("RequestedStudents")
          .doc(studentModel.docid)
          .get();

      if (reqStudentDoc.exists) {
        await reqStudentDoc.reference.delete();
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
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

  addStudentsToArchive(StudentModel studentModel) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Archives')
          .doc(studentModel.docid)
          .set(studentModel.toMap())
          .then((value) async {
        log('Student Archieved');
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Students')
            .doc(studentModel.docid)
            .delete();
        log('Student removed');
        showToast(msg: 'Student Archieved');
        Get.back();
      });
    } catch (e) {
      log('Students archieve error $e', name: 'StudentController');
    }
  }

  Stream<List<Map<String, dynamic>>> streamStudentsFromAllCourses() async* {
    try {
      final coursesStream = server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection("Courses")
          .snapshots();

      await for (var coursesSnapshot in coursesStream) {
        List<Map<String, dynamic>> results = [];

        for (var courseDoc in coursesSnapshot.docs) {
          CourseModel course = CourseModel.fromMap(courseDoc.data());
          String courseDocId = courseDoc.id;

          final requestedStudentsSnapshot = await server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection("Courses")
              .doc(courseDocId)
              .collection('RequestedStudents')
              .get();

          for (var studentDoc in requestedStudentsSnapshot.docs) {
            StudentModel student = StudentModel.fromMap(studentDoc.data());
            results.add({
              "course": course,
              "student": student,
            });
          }
        }
        yield results;
      }
    } catch (e) {
      log("Error fetching students: $e");
      yield [];
    }
  }
}
