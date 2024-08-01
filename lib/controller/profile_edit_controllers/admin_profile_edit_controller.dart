import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/image_picker_controlller/image_picker_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/admin_model/admin_model.dart';

class AdminProfileEditController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  RxBool isLoading = RxBool(false);

  Future<void> updateprofile(context, {required String updateValue, required String valuee}) async {
    try {
      isLoading.value = true;
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .update({updateValue: valuee})
          .then((value) => showToast(msg: 'AdminProfile Updated!'))
          .then((value) async {
            final user = await server
                .collection('DrivingSchoolCollection')
                .doc(UserCredentialsController.schoolId)
                .get();

            if (user.data() != null) {
              UserCredentialsController.adminModel = AdminModel.fromMap(user.data()!);
              log(UserCredentialsController.adminModel.toString());
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

  Future<void> updateStudentProfilePicture() async {
    try {
      if (Get.find<GetImage>().pickedImage.value.isNotEmpty) {
        isLoading.value = true;
        final result = await serverStorage
            .ref(
                "files/adminProfilePhotos/${UserCredentialsController.schoolId}/${UserCredentialsController.adminModel?.profileImageId}")
            .putFile(File(Get.find<GetImage>().pickedImage.value));
        final imageUrl = await result.ref.getDownloadURL();
        await server
            .collection("DrivingSchoolCollection")
            .doc(UserCredentialsController.schoolId)
            .update({"profileImageUrl": imageUrl});

        FirebaseFirestore.instance
            .collection("DrivingSchoolCollection")
            .doc(UserCredentialsController.schoolId)
            .update({"profileImageUrl": imageUrl});
        showToast(msg: "Update successfully");
        isLoading.value = false;
        Get.find<GetImage>().pickedImage.value = "";
        final studentData = await server
            .collection("DrivingSchoolCollection")
            .doc(UserCredentialsController.schoolId)
            .get();

        if (studentData.data() != null) {
          UserCredentialsController.adminModel = AdminModel.fromMap(studentData.data()!);
        }
      }
    } catch (e) {
      isLoading.value = false;
      showToast(msg: "Something Went Wrong");
    }
  }
}
