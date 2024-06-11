import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/model/schools_to_be_verified_create_list.dart';
 

class AddNewSchoolController extends GetxController {
  TextEditingController schoolNameController = TextEditingController();

  TextEditingController schoolIDController = TextEditingController();

  TextEditingController placeController = TextEditingController();

  TextEditingController adminUserNameController = TextEditingController();

  TextEditingController adminPasswordController = TextEditingController();
  TextEditingController conformpassController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController designationController = TextEditingController();
  TextEditingController schoolCodeController = TextEditingController();
  RxString countryValue = ''.obs;
  RxString stateValue = ''.obs;
  RxString cityValue = ''.obs;
  RxString schoolID = ''.obs;
  Future<void> addNewSchool(
    BuildContext context,
      String imageurl

  ) async {
    log(cityValue.value);
    String uUID = schoolNameController.text.substring(0, 5) +
        cityValue.value.substring(0, 5) +
        uuid.v1();

    try {
      if (conformpassController.text == adminPasswordController.text) {
        final schoolDetails = SchoolsToBeVerified(
          //batch year changed to empty strign because null is created
          batchYear: "",
                schoolCode: schoolCodeController.text.trim(),
            schoolName: schoolNameController.text,
            docid: uUID,
            district: cityValue.toString(),
            place: placeController.text.trim(),
            adminUserName: adminUserNameController.text.trim(),
            password: adminPasswordController.text.trim(),
            phoneNumber: phoneNumberController.text,
            email: emailController.text,
            postedDate: DateTime.now().toString(),
            verified: false);

        if (await AddRequestedSchoolsToFirebase().checkSchoolIsCreated(
            schoolNameController.text, placeController.text)) {
          showToast(msg: 'School Is Already Created');
        } else {
          if (context.mounted) {}
          AddRequestedSchoolsToFirebase()
              .addRequestedSchools(schoolDetails, context,imageurl)
              .then((value) {
            clearFunction();
          });
        }
      } else {
        log("something error");
      }
    } catch (e) {
      showToast(msg: "Something Went Wrong");
    }
  }

  void clearFunction() {
    schoolNameController.clear();
    designationController.clear();
    schoolCodeController.clear();
    schoolIDController.clear();
    placeController.clear();
    adminUserNameController.clear();
    adminPasswordController.clear();
    phoneNumberController.clear();
    emailController.clear();
    conformpassController.clear();
    countryValue.value = '';
    stateValue.value = '';
    cityValue.value = '';
    schoolID.value = '';
  }
}
