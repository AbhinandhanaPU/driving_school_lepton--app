import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/teacher_model/teacher_model.dart';
import 'package:progress_state_button/progress_button.dart';

class TeacherController extends GetxController {
  TextEditingController teacherNameController = TextEditingController();
  TextEditingController teacherPhoneNumeber = TextEditingController();
  TextEditingController teacherEmailController = TextEditingController();
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;
  final Rx<String> dateofbithController = ''.obs;
  final Rx<String> gender = ''.obs;
  final Rx<String> subject = ''.obs;
  final Rxn<DateTime> selectedDOB = Rxn<DateTime>();
  RxBool ontapTeacher = false.obs;
  RxString dobSelectedDate = ''.obs;
  RxString joiningSelectedDate = ''.obs;
  RxBool ontapviewteacher = false.obs;

  RxBool teacherEditDetail = false.obs;
  Rxn<TeacherModel> teacherModelData = Rxn<TeacherModel>();
  final formKey = GlobalKey<FormState>();

//......................  Add teacher Section

  RxBool automaticmail = false.obs;

  final _firebase = server
      .collection('DrivingSchoolCollection')
      .doc(UserCredentialsController.schoolId);

  Future<void> createNewTeacher(TeacherModel teacherModel) async {
    buttonstate.value = ButtonState.loading;
    try {
      await _firebase
          .collection('TempTeacherList')
          .add(teacherModel.toMap())
          .then((value) async {
        await _firebase
            .collection('TempTeacherList')
            .doc(value.id)
            .update({"docid": value.id}).then(
          (value) {
            showToast(msg: "Successfully Created");
            clearFields();
          },
        );
      });
      buttonstate.value = ButtonState.success;
      await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
        buttonstate.value = ButtonState.idle;
      });
    } catch (e) {
      showToast(msg: "Teacher Creation Failed");
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      log("Error .... $e");
    }
  }

  void clearFields() {
    teacherNameController.clear();
    teacherPhoneNumeber.clear();
    teacherEmailController.clear();
  }
}
