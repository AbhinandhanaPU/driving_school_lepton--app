import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

class CourseController extends GetxController {
  TextEditingController coursenameController = TextEditingController();
  TextEditingController courseDurationController = TextEditingController();
  TextEditingController courseFeeController = TextEditingController();
  TextEditingController courseDesController = TextEditingController();

  TextEditingController editcourseNameController = TextEditingController();
  TextEditingController editcourseDesController = TextEditingController();
  TextEditingController editcourseDurationController = TextEditingController();
  TextEditingController editcourseRateController = TextEditingController();

  RxInt totalStudents = 0.obs;
  List<StudentModel> studentList = [];

  Rx<ButtonState> buttonstate = ButtonState.idle.obs;

  final formKey = GlobalKey<FormState>();

  RxBool ontapStudentDetail = false.obs;
  RxString studentDocID = ''.obs;
  RxString studentName = ''.obs;
  RxString courseName = ''.obs;
  RxString courseId = ''.obs;
  RxString courseDocID = 'dd'.obs;
  List<StudentModel> allstudentList = [];
  List<CourseModel> allcourseList = [];
  Rxn<CourseModel> courseModelData = Rxn<CourseModel>();

  void setCourseData(CourseModel course) {
    courseModelData.value = course;
  }

  void clearFields() {
    coursenameController.clear();
    courseDurationController.clear();
    courseFeeController.clear();
    courseDesController.clear();

    editcourseNameController.clear();
    editcourseDesController.clear();
    editcourseDurationController.clear();
    editcourseRateController.clear();
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

  Future<void> updateCourse(String courseId, BuildContext context) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Courses')
          .doc(courseId)
          .update({
        'courseName': editcourseNameController.text,
        'courseDes': editcourseDesController.text,
        'duration': editcourseDurationController.text,
        'rate': editcourseRateController.text,
      }).then((value) {
        clearFields();
        Navigator.pop(context);
      }).then((value) => showToast(msg: 'Course Updated!'));
    } catch (e) {
      log("Course Updation failed");
    }
  }

  Future<List<StudentModel>> fetchAllStudents() async {
    final firebase = await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Students')
        .get();

    for (var i = 0; i < firebase.docs.length; i++) {
      final list =
          firebase.docs.map((e) => StudentModel.fromMap(e.data())).toList();
      allstudentList.add(list[i]);
    }
    return allstudentList;
  }

  Future<void> addStudentToCourseController(String courseID) async {
    try {
      log("studentDocID.value ${studentDocID.value}");
      log("scourseID $courseID");
      final studentResult = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .doc(studentDocID.value)
          .get();
      if (studentDocID.value != '') {
        final data = StudentModel.fromMap(studentResult.data()!);
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Courses')
            .doc(courseID)
            .collection('Students')
            .doc(studentDocID.value)
            .set(data.toMap())
            .then((value) async {
          showToast(msg: 'Added');
          allstudentList.clear();
        });
      }
    } catch (e) {
      log(e.toString());
      showToast(msg: 'Somthing went wrong please try again');
      allstudentList.clear();
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

  Future<void> deleteStudentsFromCourse(StudentModel studentModel) async {
    try {
      final data = courseModelData.value;
      if (data!.courseId != '') {
        // Delete the student from each course
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection("Courses")
            .doc(data.courseId)
            .collection('Students')
            .doc(studentModel.docid)
            .delete()
            .then((value) {
          log("Student deleted from course: ${data.courseId}");
          Get.back();
        });
      } else {
        log("No courses found");
      }
    } catch (e) {
      log("Student deletion error:$e");
    }
  }

  Future<void> fetchStudentsCourse(String courseId) async {
    try {
      log("fetchStudents......................");
      final data = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Courses')
          .doc(courseId)
          .collection('Students')
          .get();
      studentList =
          data.docs.map((e) => StudentModel.fromMap(e.data())).toList();
      log(studentList[0].toString());
    } catch (e) {
      showToast(msg: "User Data Error");
    }
  }
}
