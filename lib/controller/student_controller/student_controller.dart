import 'dart:developer';

import 'package:get/get.dart';

import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';



class StudentController extends GetxController {
  List<StudentModel> studentProfileList = [];
  Rxn<StudentModel> studentModelData = Rxn<StudentModel>();
  RxBool ontapStudent = false.obs;

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

   Future<void> deleteStudentsFromCourse(StudentModel studentModel) async {
    try {
     final docidofcourse= await server
           .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection("Courses")
          .get();

  if (docidofcourse.docs.isNotEmpty) {
      for (var courseDoc in docidofcourse.docs) {
        final courseDocid = courseDoc.id;

        // Delete the student from each course
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection("Courses")
            .doc(courseDocid)
            .collection('Students')
            .doc(studentModel.docid)
            .delete()
            .then((value) => log("Student deleted from course: $courseDocid"));
      }
    } else {
      log("No courses found");
    }
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

  //   Future<void> updateStudentCourse(StudentModel student, String newCourseId) async {
  //   try {
  //     await server
  //         .collection('DrivingSchoolCollection')
  //         .doc(UserCredentialsController.schoolId)
  //         .collection('Students')
  //         .doc(student.docid)
  //         .update({'courseId': newCourseId});
  //     showToast(msg: 'Course Updated Successfully');
  //   } catch (e) {
  //     log("Error updating course: $e");
  //     showToast(msg: 'Failed to update course');
  //   }
  // }

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
}
