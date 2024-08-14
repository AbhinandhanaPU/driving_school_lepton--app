import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';

class StudentProfileEditController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController editvalueController = TextEditingController();
  RxBool isLoading = RxBool(false);

  Future<void> updateStudentprofile(context,
      {required String updateValue, required String valuee}) async {
    try {
      isLoading.value = true;
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .doc(UserCredentialsController.studentModel!.docid)
          .update({updateValue: valuee})
          .then((value) => showToast(msg: 'Student Profile Updated!'))
          .then((value) async {
            final user = await server
                .collection('DrivingSchoolCollection')
                .doc(UserCredentialsController.schoolId)
                .collection('Students')
                .doc(UserCredentialsController.studentModel!.docid)
                .get();

            if (user.data() != null) {
              UserCredentialsController.studentModel = StudentModel.fromMap(user.data()!);
              log(UserCredentialsController.studentModel.toString());
            }
            isLoading.value = false;
            showToast(msg: 'Updated Successfully');
          });
    } catch (e) {
      showToast(msg: "Something went wrong");
      log(e.toString());
      isLoading.value = false;
    }
  }
}
