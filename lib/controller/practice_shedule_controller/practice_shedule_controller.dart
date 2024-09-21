import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/course_controller/course_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/practice_shedule_model/practice_shedule_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

class PracticeSheduleController extends GetxController {
  final courseCtrl = Get.put(CourseController());

  final formKey = GlobalKey<FormState>();
  RxList<PracticeSheduleModel> allScheduleList = RxList<PracticeSheduleModel>();
  RxList<PracticeSheduleModel> selectedScheduleList =
      RxList<PracticeSheduleModel>();
  RxBool selectAllSchedule = false.obs;

  Rx<ButtonState> buttonstate = ButtonState.idle.obs;

  TextEditingController practiceNameController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  RxString scheduleId = ''.obs;
  List<StudentModel> studentList = [];

  Future<RxList<PracticeSheduleModel>> fetchPracticeSchdule() async {
    allScheduleList.clear();
    selectedScheduleList.clear();

    final firebase = await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('PracticeSchedule')
        .get();

    for (var i = 0; i < firebase.docs.length; i++) {
      final list = firebase.docs
          .map((e) => PracticeSheduleModel.fromMap(e.data()))
          .toList();
      allScheduleList.add(list[i]);
    }
    return allScheduleList;
  }

  Future<void> createPracticeShedule() async {
    final uuid = const Uuid().v1();
    final practicesheduleDetails = PracticeSheduleModel(
        practiceName: practiceNameController.text,
        startTime: startTimeController.text,
        endTime: endTimeController.text,
        practiceId: uuid);
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('PracticeSchedule')
          .doc(practicesheduleDetails.practiceId)
          .set(practicesheduleDetails.toMap())
          .then((value) async {
        practiceNameController.clear();
        startTimeController.clear();
        endTimeController.clear();
        buttonstate.value = ButtonState.success;

        showToast(msg: "PracticeSchedule Created Successfully");
        await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
          buttonstate.value = ButtonState.idle;
        });
      });
    } catch (e) {
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      log("Error .... $e", name: "PracticeSchedule");
    }
  }

  Future<void> updatePractice(String practiceId, BuildContext context) async {
    try {
      server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('PracticeSchedule')
          .doc(practiceId)
          .update({
            'practiceName': practiceNameController.text,
            'startTime': startTimeController.text,
            'endTime': endTimeController.text,
          })
          .then((value) {
            practiceNameController.clear();
            startTimeController.clear();
            endTimeController.clear();
          })
          .then((value) => Navigator.pop(context))
          .then((value) => showToast(msg: 'Practice Updated!'));
    } catch (e) {
      showToast(msg: 'Practice  Updation failed.Try Again');
      log("Practice Updation failed $e");
    }
  }

  Future<void> deletePractice(String practiceId, BuildContext context) async {
    log("noticeId -----------$practiceId");
    server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('PracticeSchedule')
        .doc(practiceId)
        .delete();
  }

  Future<void> addStudent() async {
    try {
      final studentResult = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .doc(courseCtrl.studentDocID.value)
          .get();
      if (courseCtrl.studentDocID.value != '') {
        final data = StudentModel.fromMap(studentResult.data()!);
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('PracticeSchedule')
            .doc(scheduleId.value)
            .collection('Students')
            .doc(courseCtrl.studentDocID.value)
            .set(data.toMap())
            .then((value) async {
          buttonstate.value = ButtonState.success;
          showToast(msg: "Student added Successfully");
          await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
            buttonstate.value = ButtonState.idle;
          });
        });
      }
    } catch (e) {
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      log("Error .... $e");
    }
  }

  Future<void> deleteStudent({required String docId}) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('PracticeSchedule')
          .doc(scheduleId.value)
          .collection('Students')
          .doc(docId)
          .delete()
          .then((value) {
        showToast(msg: "Deleted Successfully");
        log("Deleted Successfully");
        Get.back();
      });
    } catch (e) {
      log(e.toString(), name: "PracticeSchedule");
    }
  }

  Stream<int> fetchTotalStudents(String courseId) {
    CollectionReference coursesRef = server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('PracticeSchedule')
        .doc(courseId)
        .collection('Students');

    return coursesRef.snapshots().map((snapshot) => snapshot.docs.length);
  }

  Stream<List<StudentModel>> fetchStudentsWithStatusTrue(String practiseId) {
    return server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('PracticeSchedule')
        .doc(practiseId)
        .collection('Students')
        .snapshots()
        .asyncMap((snapshot) async {
      List<String> studentIds = snapshot.docs.map((doc) => doc.id).toList();

      if (studentIds.isEmpty) return [];

      QuerySnapshot studentSnapshot = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .where('status', isEqualTo: true)
          .where('docid', whereIn: studentIds)
          .get();

      studentList = studentSnapshot.docs
          .map(
              (doc) => StudentModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return studentList;
    });
  }

  Future<List<PracticeSheduleModel>> fetchStudentPracticeSchedules() async {
    final schedulesSnapshot = await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('PracticeSchedule')
        .get();

    List<PracticeSheduleModel> studentSchedules = [];
    for (var scheduleDoc in schedulesSnapshot.docs) {
      final studentDoc = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('PracticeSchedule')
          .doc(scheduleDoc.id)
          .collection('Students')
          .doc(UserCredentialsController.studentModel!.docid)
          .get();

      if (studentDoc.exists) {
        studentSchedules.add(PracticeSheduleModel.fromMap(scheduleDoc.data()));
      }
    }

    return studentSchedules;
  }
}
