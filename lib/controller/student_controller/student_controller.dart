import 'dart:developer';

import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';

class StudentController extends GetxController {
  List<StudentModel> studentProfileList = [];

  final _fbServer =
      server.collection('DrivingSchoolCollection').doc(UserCredentialsController.schoolId);

  Future<void> fetchAllStudents() async {
    try {
      log("fetchAllStudents......................");
      final data = await _fbServer.collection('Students').get();
      studentProfileList = data.docs.map((e) => StudentModel.fromMap(e.data())).toList();
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

  Future<void> updateStudentStatus(StudentModel studentModel, String newStatus) async {
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

  Future<void> addStudentToCourse(String courseID) async {
    try {
      log("UserCredentialsController.studentModel!.docid ${UserCredentialsController.studentModel!.docid}");
      log("std course id $courseID");
      final courseStd = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Courses')
          .doc(courseID)
          .collection('Students')
          .doc(UserCredentialsController.studentModel!.docid)
          .get();
      if (!courseStd.exists) {
        final studentResult = await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Students')
            .doc(UserCredentialsController.studentModel!.docid)
            .get();
        final data = StudentModel.fromMap(studentResult.data()!);
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Courses')
            .doc(courseID)
            .collection('Students')
            .doc(UserCredentialsController.studentModel!.docid)
            .set(data.toMap())
            .then((value) async {
          showToast1(msg: 'You are successfully entered');
        });
      } else {
        showToast2(msg: 'You are already added');
      }
    } catch (e) {
      log(e.toString(), name: 'StudentController');
      showToast(msg: 'Somthing went wrong please try again');
    }
  }
}
