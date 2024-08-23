import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/image_picker_controlller/image_picker_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/teacher_model/teacher_model.dart';

class TeacherProfileEditController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController editteacherController = TextEditingController();
  RxBool isLoading = RxBool(false);
  Future<void> updateTeacherprofile(context,
      {required String updateValue, required String valuee}) async {
    try {
      isLoading.value = true;
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Teachers')
          .doc(UserCredentialsController.teacherModel?.docid)
          .update({updateValue: valuee})
          .then((value) => showToast(msg: 'Teacher Profile Updated!'))
          .then((value) async {
            final tutorData = await server
                .collection("DrivingSchoolCollection")
                .doc(UserCredentialsController.schoolId)
                .collection('Teachers')
                .doc(UserCredentialsController.teacherModel!.docid)
                .get();

            if (tutorData.data() != null) {
              UserCredentialsController.teacherModel = TeacherModel.fromMap(tutorData.data()!);
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

  Future<void> updateTeacherProfilePicture() async {
    try {
      if (Get.find<GetImage>().pickedImage.value.isNotEmpty) {
        isLoading.value = true;
        final result = await serverStorage
            .ref(
                "files/teacherPhotos/${UserCredentialsController.teacherModel?.docid}/${UserCredentialsController.teacherModel?.profileImageId}")
            .putFile(File(Get.find<GetImage>().pickedImage.value));
        final imageUrl = await result.ref.getDownloadURL();
        await server
            .collection("DrivingSchoolCollection")
            .doc(UserCredentialsController.schoolId)
            .collection('Teachers')
            .doc(UserCredentialsController.teacherModel!.docid)
            .update({"profileImageUrl": imageUrl}).then((value) async {
          isLoading.value = false;
          Get.find<GetImage>().pickedImage.value = "";
          Get.back();
          Get.back();
          final tutorData = await server
              .collection("DrivingSchoolCollection")
              .doc(UserCredentialsController.schoolId)
              .collection('Teachers')
              .doc(UserCredentialsController.teacherModel!.docid)
              .get();
          showToast(msg: 'profile pic Updated Successfully');
          if (tutorData.data() != null) {
            UserCredentialsController.teacherModel = TeacherModel.fromMap(tutorData.data()!);
          }
        });
      }
    } catch (e) {
      isLoading.value = false;
      showToast(msg: "Something Went Wrong");
    }
  }
}
