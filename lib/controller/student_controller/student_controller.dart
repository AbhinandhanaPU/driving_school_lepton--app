import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/widgets/custom_show_dialogbox/message_show_dialog.dart';

class StudentController extends GetxController {
  List<StudentModel> studentProfileList = [];
  TextEditingController amountController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxInt totalStudentsCount = 0.obs;
  RxString batchId = ''.obs;
  RxString batchName = ''.obs;

  final _fbServer = server
      .collection('DrivingSchoolCollection')
      .doc(UserCredentialsController.schoolId);

  Future<void> fetchAllStudents() async {
    try {
      log("fetchAllStudents......................");
      final data = await _fbServer
          .collection('Students')
          .where('status', isEqualTo: true)
          .get();
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
      final data = await _fbServer
          .collection('Students')
          .where('status', isEqualTo: false)
          .get();
      studentProfileList =
          data.docs.map((e) => StudentModel.fromMap(e.data())).toList();
      log(studentProfileList[0].toString());
    } catch (e) {
      showToast(msg: "User Data Error");
    }
  }

  Future<void> deleteStudentsFromCourse(
    StudentModel studentModel,
    String courseDocid,
  ) async {
    try {
      if (courseDocid != '') {
        await _fbServer
            .collection("Courses")
            .doc(courseDocid)
            .collection('Students')
            .doc(studentModel.docid)
            .delete()
            .then((value) {
          log("Student deleted from course: ${courseDocid}");
          Get.back();
        });
      } else {
        log("No courses found");
      }
    } catch (e) {
      log("Student deletion error:$e");
    }
  }

  Future<void> updateStudentStatus(
      StudentModel studentModel, bool newStatus) async {
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

  Future<List<String>> fetchStudentsCourse(StudentModel studentModel) async {
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
                // log("courseNames : $courseNames");
              }
            }
          }
        }
      }
    } catch (e) {
      log("Student course fetching error: $e");
    }
    return courseNames;
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
        customMessageDialogBox(
          context: context,
          message: 'Your payment request sent Successfully',
          onPressed: () {
            Get.back();
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
        customMessageDialogBox(
          context: context,
          message: 'Your Successfully added to course',
          onPressed: () {
            Get.back();
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
      final docOfFee = await _fbServer
          .collection('FeesCollection')
          .doc(UserCredentialsController.studentModel!.batchId)
          .collection('Courses')
          .get();

      if (docOfFee.docs.isNotEmpty) {
        for (var courseDoc in docOfFee.docs) {
          final courseDocId = courseDoc.id;
          final studentDocSnapshot = await _fbServer
              .collection("FeesCollection")
              .doc(UserCredentialsController.studentModel!.batchId)
              .collection('Courses')
              .doc(courseDocId)
              .collection('Students')
              .doc(UserCredentialsController.studentModel!.docid)
              .get();

          if (studentDocSnapshot.exists) {
            yield* _fbServer
                .collection("FeesCollection")
                .doc(UserCredentialsController.studentModel!.batchId)
                .collection('Courses')
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
        int totalCount = 0;

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
            totalCount++;
          }
        }
        totalStudentsCount.value = totalCount;
        yield results;
      }
    } catch (e) {
      log("Error fetching students: $e");
      yield [];
    }
  }

  Future<void> updateStudentBatch(StudentModel studentModel) async {
    try {
      await _fbServer.collection('Students').doc(studentModel.docid).update({
        'batchId': batchId.value,
      }).then((value) {
        studentModel.batchId = batchId.value;
        update();
        log("Student batch updated to $batchId");
      });
      // await addStudentToBatch(studentModel);
      // await checkStudentInBatches(studentModel);
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
            await _fbServer
                .collection("Courses")
                .doc(courseDocid)
                .collection('Students')
                .doc(studentModel.docid)
                .update({
              'batchId': batchId.value,
            });
          }
        }
      }
    } catch (e) {
      log('student batch update error $e');
    }
  }

  Future<void> deleteStudents(StudentModel studentModel) async {
    try {
      await _fbServer
          .collection('Students')
          .doc(studentModel.docid)
          .delete()
          .then((value) async {
        await deleteStudentFromAllStudents(studentModel);
        await deleteStudentFromCourse(studentModel);
        await deleteStudentFromBatch(studentModel);
        await deleteStudentFromDrivingTest(studentModel);
        await deleteStudentFromPracticeSchedule(studentModel);
        log("Student deleted");
      });
    } catch (e) {
      log("Student deletion error:$e");
    }
  }

  Future<void> deleteStudentFromAllStudents(StudentModel studentModel) async {
    try {
      final documents = await _fbServer
          .collection('Students')
          .doc(studentModel.docid)
          .collection('Documents')
          .get();

      for (var doc in documents.docs) {
        await _fbServer
            .collection('Students')
            .doc(studentModel.docid)
            .collection('Documents')
            .doc(doc.id)
            .delete();
        log('documents removed');
      }
      await _deleteAllSubcollections(studentModel.docid, 'AdminChatCounter');
      await _deleteAllSubcollections(studentModel.docid, 'AdminChats');
      await _deleteAllSubcollections(studentModel.docid, 'TeacherChats');
      await _deleteAllSubcollections(studentModel.docid, 'TutorChatCounter');
      await _fbServer.collection('Students').doc(studentModel.docid).delete();
      log('Student removed');
    } catch (e) {
      log('deleteStudentFromAllStudents error: $e');
    }
  }

  Future<void> _deleteAllSubcollections(
    String parentId,
    String subcollection,
  ) async {
    final documents = await _fbServer
        .collection('Students')
        .doc(parentId)
        .collection('Documents')
        .get();
    for (var doc in documents.docs) {
      await _fbServer
          .collection('Students')
          .doc(parentId)
          .collection(subcollection)
          .doc(doc.id)
          .delete();
      log('$subcollection removed');
    }
  }

  Future<void> deleteStudentFromCourse(StudentModel studentModel) async {
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

  Future<void> deleteStudentFromBatch(StudentModel studentModel) async {
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

  Future<void> deleteStudentFromDrivingTest(StudentModel studentModel) async {
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

  Future<void> deleteStudentFromFee(StudentModel studentModel) async {
    try {
      final feeCollectionSnapshot = await _fbServer
          .collection("FeesCollection")
          .doc(studentModel.batchId)
          .collection('Courses')
          .get();

      if (feeCollectionSnapshot.docs.isNotEmpty) {
        for (var feeDoc in feeCollectionSnapshot.docs) {
          final feeDocid = feeDoc.id;

          final studentDoc = await _fbServer
              .collection("FeesCollection")
              .doc(studentModel.batchId)
              .collection('Courses')
              .doc(feeDocid)
              .collection('Students')
              .doc(studentModel.docid)
              .get();

          if (studentDoc.exists) {
            await _fbServer
                .collection("FeesCollection")
                .doc(studentModel.batchId)
                .collection('Courses')
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

  Future<void> deleteStudentFromPracticeSchedule(
      StudentModel studentModel) async {
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
            await _fbServer
                .collection("PracticeSchedule")
                .doc(practiceDocid)
                .collection('Students')
                .doc(studentModel.docid)
                .delete()
                .then((value) {
              log('Student deleted from practice schedule');
            });
          }
          log('Student not added to any practice schedule to delete');
        }
      }
    } catch (e) {
      log('deleteStudentFromPracticeSchedule error: $e');
    }
  }

  Stream<List<String>> fetchStudentsCourseChat(String stdocid) async* {
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
              .doc(stdocid)
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
}
