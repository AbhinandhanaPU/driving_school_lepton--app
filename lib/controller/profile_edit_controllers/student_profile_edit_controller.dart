import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/image_picker_controlller/image_picker_controller.dart';
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

  Future<void> updateStudentProfilePicture() async {
    try {
      if (Get.find<GetImage>().pickedImage.value.isNotEmpty) {
        isLoading.value = true;
        final result = await serverStorage
            .ref(
                "files/studentPhotos/${UserCredentialsController.studentModel?.docid}/${UserCredentialsController.studentModel?.profileImageId}")
            .putFile(File(Get.find<GetImage>().pickedImage.value));
        final imageUrl = await result.ref.getDownloadURL();
        await server
            .collection("DrivingSchoolCollection")
            .doc(UserCredentialsController.schoolId)
            .collection('Students')
            .doc(UserCredentialsController.studentModel!.docid)
            .update({"profileImageUrl": imageUrl}).then((value) async {
          isLoading.value = false;
          Get.find<GetImage>().pickedImage.value = "";
          Get.back();
          Get.back();
          final tutorData = await server
              .collection("DrivingSchoolCollection")
              .doc(UserCredentialsController.schoolId)
              .collection('Students')
              .doc(UserCredentialsController.studentModel!.docid)
              .get();
          showToast(msg: 'profile pic Updated Successfully');
          if (tutorData.data() != null) {
            UserCredentialsController.studentModel = StudentModel.fromMap(tutorData.data()!);
          }
        });
      }
    } catch (e) {
      isLoading.value = false;
      showToast(msg: "Something Went Wrong");
    }
  }
}
