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
      await _fbServer
          .collection('Students')
          .doc(studentModel.docid)
          .delete()
          .then((value) async {
        await deleteStudentFromAllStudents(studentModel, isArchiving: false);
        await deleteStudentFromCourse(studentModel, isArchiving: false);
        await deleteStudentFromBatch(studentModel, isArchiving: false);
        await deleteStudentFromDrivingTest(studentModel, isArchiving: false);
        await deleteStudentFromPracticeSchedule(studentModel,
            isArchiving: false);
        await deleteStudentFromFee(studentModel, isArchiving: false);
        log("Student deleted");
      });
    } catch (e) {
      log("Student deletion error:$e");
    }
  }

  Future<void> deleteStudentsFromCourse(
    StudentModel studentModel,
    String courseDocid,
  ) async {
    try {
      await _fbServer
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
      await _fbServer
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
      final docidofcourse = await _fbServer.collection("Courses").get();

      if (docidofcourse.docs.isNotEmpty) {
        for (var courseDoc in docidofcourse.docs) {
          final courseDocid = courseDoc.id;

          final std = await _fbServer
              .collection("Courses")
              .doc(courseDocid)
              .collection('Students')
              .doc(studentModel.docid)
              .get();

          if (std.exists) {
            final courseDocument =
                await _fbServer.collection("Courses").doc(courseDocid).get();

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
      final studentResult = await _fbServer
          .collection('Students')
          .doc(UserCredentialsController.studentModel!.docid)
          .get();
      final stdData = StudentModel.fromMap(studentResult.data()!);
      await _fbServer
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
      final studentResult = await _fbServer
          .collection('Students')
          .doc(UserCredentialsController.studentModel!.docid)
          .get();
      final stdData = StudentModel.fromMap(studentResult.data()!);
      await _fbServer
          .collection('Courses')
          .doc(courseID)
          .collection('Students')
          .doc(UserCredentialsController.studentModel!.docid)
          .set(stdData.toMap())
          .then((value) async {
        final reqCourseStd = await _fbServer
            .collection('Courses')
            .doc(courseID)
            .collection('RequestedStudents')
            .doc(UserCredentialsController.studentModel!.docid)
            .get();
        if (reqCourseStd.exists) {
          await _fbServer
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
      final docOfFee = await _fbServer.collection('FeeCollection').get();

      if (docOfFee.docs.isNotEmpty) {
        for (var courseDoc in docOfFee.docs) {
          final courseDocId = courseDoc.id;
          final studentDocSnapshot = await _fbServer
              .collection("FeeCollection")
              .doc(courseDocId)
              .collection('Students')
              .doc(UserCredentialsController.studentModel!.docid)
              .get();

          if (studentDocSnapshot.exists) {
            yield* _fbServer
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
      await _fbServer
          .collection('FeeCollection')
          .doc(courseID)
          .set({'docId': courseID}).then((value) async {
        await _fbServer
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

  Future<void> declineStudentToCourse(
    StudentModel studentModel,
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
            .collection("RequestedStudents")
            .doc(studentModel.docid)
            .delete();
        showToast(msg: 'Student request declined');
        log("Student request declined");
      } else {
        log("Student not found in RequestedStudents collection.");
      }
    } catch (e) {
      log("Students approval error: $e");
    }
  }

  Stream<List<Map<String, dynamic>>> streamStudentsFromAllCourses() async* {
    try {
      final coursesStream = _fbServer.collection("Courses").snapshots();

      await for (var coursesSnapshot in coursesStream) {
        List<Map<String, dynamic>> results = [];

        for (var courseDoc in coursesSnapshot.docs) {
          CourseModel course = CourseModel.fromMap(courseDoc.data());
          String courseDocId = courseDoc.id;

          final requestedStudentsSnapshot = await _fbServer
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

  Future<void> addStudentsToArchive(StudentModel studentModel) async {
    try {
      await _fbServer
          .collection('Archives')
          .doc(studentModel.docid)
          .set(studentModel.toMap())
          .then((value) async {
        log('Student Archived');
        await deleteStudentFromAllStudents(studentModel, isArchiving: true);
        await deleteStudentFromCourse(studentModel, isArchiving: true);
        await deleteStudentFromBatch(studentModel, isArchiving: true);
        await deleteStudentFromDrivingTest(studentModel, isArchiving: true);
        await deleteStudentFromPracticeSchedule(studentModel,
            isArchiving: true);
        await deleteStudentFromFee(studentModel, isArchiving: true);
        showToast(msg: 'Student Archived');
        Get.back();
      });
    } catch (e) {
      log('Students archive error $e', name: 'StudentController');
    }
  }

  Future<void> deleteStudentFromAllStudents(StudentModel studentModel,
      {bool isArchiving = false}) async {
    try {
      final documents = await _fbServer
          .collection('Students')
          .doc(studentModel.docid)
          .collection('Documents')
          .get();
      if (isArchiving) {
        for (var doc in documents.docs) {
          await _fbServer
              .collection('Archives')
              .doc(studentModel.docid)
              .collection('Documents')
              .doc(doc.id)
              .set(doc.data());
        }
      }

      for (var doc in documents.docs) {
        await _fbServer
            .collection('Students')
            .doc(studentModel.docid)
            .collection('Documents')
            .doc(doc.id)
            .delete();
        log('documents removed');
      }

      await _fbServer.collection('Students').doc(studentModel.docid).delete();
      log('Student removed');
    } catch (e) {
      log('deleteStudentFromAllStudents error: $e');
    }
  }

  Future<void> deleteStudentFromCourse(StudentModel studentModel,
      {bool isArchiving = false}) async {
    try {
      final coursesSnapshot = await _fbServer.collection("Courses").get();

      if (coursesSnapshot.docs.isNotEmpty) {
        for (var courseDoc in coursesSnapshot.docs) {
          final courseDocid = courseDoc.id;

          final studentDoc = await _fbServer
              .collection("Courses")
              .doc(courseDocid)
              .collection('Students')
              .doc(studentModel.docid)
              .get();

          if (studentDoc.exists) {
            if (isArchiving) {
              final courseName = courseDoc.data()['courseName'];
              await _fbServer
                  .collection('Archives')
                  .doc(studentModel.docid)
                  .collection('CoursesDetails')
                  .doc(studentModel.docid)
                  .set({
                'courseName': courseName,
                'courseId': courseDocid,
              }, SetOptions(merge: true));
            }

            await _fbServer
                .collection("Courses")
                .doc(courseDocid)
                .collection('Students')
                .doc(studentModel.docid)
                .delete()
                .then((value) {
              log('Student deleted from course');
            });
          }
          log('Student not added to any course to delete');
        }
      }
    } catch (e) {
      log('deleteStudentFromCourse error: $e');
    }
  }

  Future<void> deleteStudentFromBatch(StudentModel studentModel,
      {bool isArchiving = false}) async {
    try {
      final batchesSnapshot = await _fbServer.collection("Batch").get();

      if (batchesSnapshot.docs.isNotEmpty) {
        for (var batchDoc in batchesSnapshot.docs) {
          final batchDocid = batchDoc.id;

          final studentDoc = await _fbServer
              .collection("Batch")
              .doc(batchDocid)
              .collection('Students')
              .doc(studentModel.docid)
              .get();

          if (studentDoc.exists) {
            final batchName = batchDoc.data()['batchName'];
            if (isArchiving) {
              await _fbServer
                  .collection('Archives')
                  .doc(studentModel.docid)
                  .collection('CoursesDetails')
                  .doc(studentModel.docid)
                  .set({
                'batchName': batchName,
                'batchId': batchDocid,
              }, SetOptions(merge: true));
            }
            await _fbServer
                .collection("Batch")
                .doc(batchDocid)
                .collection('Students')
                .doc(studentModel.docid)
                .delete()
                .then((value) {
              log('Student deleted from batch: $batchName');
            });
          }
          log('Student not added to any batch to delete');
        }
      }
    } catch (e) {
      log('deleteStudentFromBatch error: $e');
    }
  }

  Future<void> deleteStudentFromDrivingTest(StudentModel studentModel,
      {bool isArchiving = false}) async {
    try {
      final drivingTestsSnapshot =
          await _fbServer.collection("DrivingTest").get();

      if (drivingTestsSnapshot.docs.isNotEmpty) {
        for (var drivingTestDoc in drivingTestsSnapshot.docs) {
          final drivingTestDocid = drivingTestDoc.id;

          final studentDoc = await _fbServer
              .collection("DrivingTest")
              .doc(drivingTestDocid)
              .collection('Students')
              .doc(studentModel.docid)
              .get();

          if (studentDoc.exists) {
            final testDate = drivingTestDoc.data()['testDate'];
            if (isArchiving) {
              await _fbServer
                  .collection('Archives')
                  .doc(studentModel.docid)
                  .collection('CoursesDetails')
                  .doc(studentModel.docid)
                  .set({
                'testId': drivingTestDocid,
                'testDate': testDate,
              }, SetOptions(merge: true));
            }
            await _fbServer
                .collection("DrivingTest")
                .doc(drivingTestDocid)
                .collection('Students')
                .doc(studentModel.docid)
                .delete()
                .then((value) {
              log('Student deleted from driving test');
            });
          }
          log('Student not added to any driving test to delete');
        }
      }
    } catch (e) {
      log('deleteStudentFromDrivingTest error: $e');
    }
  }

  Future<void> deleteStudentFromFee(StudentModel studentModel,
      {bool isArchiving = false}) async {
    try {
      final feeCollectionSnapshot =
          await _fbServer.collection("FeeCollection").get();

      if (feeCollectionSnapshot.docs.isNotEmpty) {
        for (var feeDoc in feeCollectionSnapshot.docs) {
          final feeDocid = feeDoc.id;

          final studentDoc = await _fbServer
              .collection("FeeCollection")
              .doc(feeDocid)
              .collection('Students')
              .doc(studentModel.docid)
              .get();

          if (studentDoc.exists) {
            final feeStatus = studentDoc.data()!['feeStatus'];
            final pendingAmount = studentDoc.data()!['pendingAmount'];

            if (isArchiving) {
              await _fbServer
                  .collection('Archives')
                  .doc(studentModel.docid)
                  .collection('CoursesDetails')
                  .doc(studentModel.docid)
                  .set({
                'feeStatus': feeStatus,
                'pendingAmount': pendingAmount,
              }, SetOptions(merge: true));
            }
            await _fbServer
                .collection("FeeCollection")
                .doc(feeDocid)
                .collection('Students')
                .doc(studentModel.docid)
                .delete()
                .then((value) {
              log('Student deleted from fee collection');
            });
          }
        }
        log('Student not added to any feescollection to delete');
      }
    } catch (e) {
      log('deleteStudentFromFee error: $e');
    }
  }

  Future<void> deleteStudentFromPracticeSchedule(StudentModel studentModel,
      {bool isArchiving = false}) async {
    try {
      final practiceScheduleSnapshot =
          await _fbServer.collection("PracticeSchedule").get();

      if (practiceScheduleSnapshot.docs.isNotEmpty) {
        for (var practiceDoc in practiceScheduleSnapshot.docs) {
          final practiceDocid = practiceDoc.id;

          final studentDoc = await _fbServer
              .collection("PracticeSchedule")
              .doc(practiceDocid)
              .collection('Students')
              .doc(studentModel.docid)
              .get();

          if (studentDoc.exists) {
            final practiceName = practiceDoc.data()['practiceName'];
            if (isArchiving) {
              await _fbServer
                  .collection('Archives')
                  .doc(studentModel.docid)
                  .collection('CoursesDetails')
                  .doc(studentModel.docid)
                  .set({
                'practiceName': practiceName,
                'practiceId': practiceDocid,
              }, SetOptions(merge: true));
            }
            await _fbServer
                .collection("PracticeSchedule")
                .doc(practiceDocid)
                .collection('Students')
                .doc(studentModel.docid)
                .delete()
                .then((value) {
              log('Student deleted from practice schedule: $practiceName');
            });
          }
          log('Student not added to any practice schedule to delete');
        }
      }
    } catch (e) {
      log('deleteStudentFromPracticeSchedule error: $e');
    }
  }
}
