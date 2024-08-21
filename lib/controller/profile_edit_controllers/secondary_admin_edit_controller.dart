import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';

class SecondaryAdminProfileEditController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  RxBool isLoading = RxBool(false);

  Future<void> updateprofile() async {
    try {
      isLoading.value = true;
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Admins')
          .doc(serverAuth.currentUser!.uid)
          .update({
        'username': nameEditingController.text,
        'phoneNumber': phoneEditingController.text
      }).then((value) async {
        isLoading.value = false;
        Get.back();
        phoneEditingController.clear();
        nameEditingController.clear();
        showToast(msg: 'Updated Successfully');
      });
    } catch (e) {
      showToast(msg: "Something went wrong");
      log(e.toString());
      isLoading.value = false;
    }
  }
}
