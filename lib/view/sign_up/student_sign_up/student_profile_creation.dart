import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/image_picker_controlller/image_picker_controller.dart';
import 'package:new_project_app/controller/user_signup_controller/student_signup_controller.dart';
import 'package:new_project_app/view/widgets/image_picker_container_widget/progile_image_picker_container_widget.dart';
import 'package:new_project_app/view/widgets/login_button/login_button.dart';
import 'package:new_project_app/view/widgets/signup_text_formfield/signup_text_formfield.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class StudentProfileCreationScreen extends StatelessWidget {
  StudentProfileCreationScreen({super.key});

  final studentSignUpController = Get.put(StudentSignUpController());
  final GetImage getImageController = Get.put(GetImage());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        getImageController.pickedImage.value = "";
        studentSignUpController.clearFields();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: cWhite,
          backgroundColor: themeColor,
          title: const Text("Sign Up"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: ListView(
            children: [
              Center(
                child: GooglePoppinsWidgets(
                  fontsize: 20,
                  fontWeight: FontWeight.w300,
                  text: 'Personal Data'.tr,
                ),
              ),
              kHeight10,
              SingleChildScrollView(
                child: Form(
                  key: studentSignUpController.formKey1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Obx(
                        () => CircleAvatar(
                          backgroundImage: getImageController
                                  .pickedImage.value.isEmpty
                              ? const AssetImage('assets/images/profilebg.png')
                              : FileImage(
                                  File(getImageController.pickedImage.value),
                                ) as ImageProvider,
                          radius: 60,
                          child: Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  _getCameraAndGallery(context);
                                },
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor:
                                        const Color.fromARGB(255, 95, 92, 92),
                                    child: IconButton(
                                      icon: const Icon(Icons.camera_alt),
                                      color: Colors.white,
                                      onPressed: () {
                                        _getCameraAndGallery(context);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      kHeight30,
                      SignUpTextFromFiled(
                        text: "Name *",
                        hintText: "Name",
                        keyboardType: TextInputType.text,
                        textfromController:
                            studentSignUpController.nameController,
                        validator: checkFieldEmpty,
                      ),
                      SignUpTextFromFiled(
                        text: "Phone Number *",
                        hintText: "Phone Number",
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        textfromController:
                            studentSignUpController.phoneController,
                        validator: checkFieldPhoneNumberIsValid,
                      ),
                      SignUpTextFromFiled(
                        text: 'Date of birth'.tr,
                        hintText: 'DOB'.tr,
                        keyboardType: TextInputType.none,
                        textfromController:
                            studentSignUpController.dateOfBirthController,
                        validator: checkFieldEmpty,
                        onTapFunction: () async {
                          studentSignUpController.dateOfBirthController.text =
                              await dateTimePicker(context);
                        },
                      ),
                      SignUpTextFromFiled(
                        text: "Father/Spouse Name *",
                        hintText: "name",
                        keyboardType: TextInputType.text,
                        textfromController:
                            studentSignUpController.fatherSpouseController,
                        validator: checkFieldEmpty,
                      ),
                      SignUpTextFromFiled(
                        text: "Place *",
                        hintText: "Place",
                        keyboardType: TextInputType.text,
                        textfromController:
                            studentSignUpController.placeController,
                        validator: checkFieldEmpty,
                      ),
                      SignUpTextFromFiled(
                        text: "Address *",
                        hintText: "address",
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        textfromController:
                            studentSignUpController.addressController,
                        validator: checkFieldEmpty,
                      ),
                      SignUpTextFromFiled(
                        text: "RTO Name *",
                        hintText: "Name",
                        keyboardType: TextInputType.text,
                        textfromController:
                            studentSignUpController.rtoNameController,
                        validator: checkFieldEmpty,
                      ),
                      SignUpTextFromFiled(
                        text: "Licence Number (Not Mandatory)",
                        hintText: "number",
                        keyboardType: TextInputType.text,
                        textfromController:
                            studentSignUpController.licenceController,
                      ),
                      kHeight20,
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            if (studentSignUpController.formKey1.currentState!
                                .validate()) {}
                          },
                          child: loginButtonWidget(
                              height: 60, width: 180, text: 'Submit'.tr),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _getCameraAndGallery(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomProfileImageContainerWidget(
              getImageController: getImageController);
        });
  }
}
