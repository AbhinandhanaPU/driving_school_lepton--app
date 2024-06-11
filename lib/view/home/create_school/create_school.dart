// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/create_school_controller/create_school_controller.dart';
import 'package:new_project_app/controller/image_picker_controlller/image_picker_controller.dart';
import 'package:new_project_app/view/widgets/image_picker_container_widget/progile_image_picker_container_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class SchoolProfile extends StatefulWidget {
  const SchoolProfile({super.key});

  @override
  State<SchoolProfile> createState() => _SchoolProfileState();
}

class _SchoolProfileState extends State<SchoolProfile> {
  CreateschoolController createschoolController = Get.put(CreateschoolController());

  final GetImage getImageController = Get.put(GetImage());

  Uint8List? file;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create School",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: cWhite)),
          backgroundColor: cblue,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SelectState(
                        onCountryChanged: (value) {
                          createschoolController.countryValue.value = value;
                        },
                        onStateChanged: (value) {
                          createschoolController.stateValue.value = value;
                        },
                        onCityChanged: (value) {
                          createschoolController.cityValue.value = value;
                        },
                      ),
                    ),
                    SchoolTextFormFieldWidget(
                      textEditingController: createschoolController.schoolNameController,
                      function: checkFieldEmpty,
                      labelText: 'School Name',
                      icon: Icons.school,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SchoolTextFormFieldWidget(
                      textEditingController: createschoolController.schoolCodeController,
                      function: checkFieldEmpty,
                      labelText: 'School Code',
                      icon: Icons.school_outlined,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SchoolTextFormFieldWidget(
                      textEditingController: createschoolController.placeController,
                      function: checkFieldEmpty,
                      labelText: 'Address',
                      icon: Icons.place_outlined,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SchoolTextFormFieldWidget(
                      textEditingController: createschoolController.placeController,
                      function: checkFieldEmpty,
                      labelText: 'Place',
                      icon: Icons.place_outlined,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SchoolTextFormFieldWidget(
                      textEditingController: createschoolController.adminUserNameController,
                      function: checkFieldEmpty,
                      labelText: 'Admin Username',
                      icon: Icons.admin_panel_settings_outlined,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SchoolTextFormFieldWidget(
                      textEditingController: createschoolController.designationController,
                      function: checkFieldEmpty,
                      labelText: 'Designation',
                      icon: Icons.person_4,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SchoolTextFormFieldWidget(
                      textEditingController: createschoolController.phoneNumberController,
                      function: checkFieldPhoneNumberIsValid,
                      labelText: 'Phone number',
                      maxLength: 10,
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SchoolTextFormFieldWidget(
                          textEditingController: createschoolController.emailController,
                          function: checkFieldEmailIsValid,
                          labelText: 'Enter email',
                          hintText: "Enter school's official mail ID",
                          icon: Icons.mail_outline,
                        ),
                        GooglePoppinsWidgets(
                          text: "* You can't edit or change this entry in future ",
                          fontsize: 13,
                          color: Color.fromARGB(255, 27, 106, 170),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        obscureText: true,
                        validator: checkFieldPasswordIsValid,
                        controller: createschoolController.passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          icon: Icon(
                            Icons.lock_outline_sharp,
                            color: const Color.fromARGB(221, 28, 9, 110),
                          ),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        obscureText: true,
                        validator: (d) {
                          if (createschoolController.passwordController.text ==
                              createschoolController.confirmPassController.text) {
                            return null;
                          } else {
                            return 'Check Password';
                          }
                        },
                        controller: createschoolController.confirmPassController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          icon: Icon(
                            Icons.lock_outline_sharp,
                            color: const Color.fromARGB(221, 28, 9, 110),
                          ),
                          labelText: 'Confirm Password',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(
                      () => CircleAvatar(
                        backgroundImage: getImageController.pickedImage.value.isEmpty
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
                                  backgroundColor: const Color.fromARGB(255, 95, 92, 92),
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
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 3, 39, 68),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                            if (Get.find<GetImage>().pickedImage.isEmpty) {
                              showToast(
                                  msg: 'Add an image of school before requesting create school');
                            } else if (_formKey.currentState!.validate()) {
                              await createschoolController.addNewSchool(context);
                            }
                          },
                          child: const Text(
                            "Create",
                            style: TextStyle(color: cWhite),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ));
  }

  void _getCameraAndGallery(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomProfileImageContainerWidget(getImageController: getImageController);
        });
  }
}

class SchoolTextFormFieldWidget extends StatelessWidget {
  const SchoolTextFormFieldWidget({
    super.key,
    required this.textEditingController,
    required this.labelText,
    required this.function,
    required this.icon,
    this.obscureText,
    this.hintText,
    this.maxLength,
    this.keyboardType,
  });

  final TextEditingController textEditingController;
  final String labelText;
  final String? Function(String? fieldContent) function;
  final IconData icon;
  final bool? obscureText;
  final String? hintText;
  final int? maxLength;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.w, left: 15.w, right: 15.w, top: 15.w),
      child: TextFormField(
        // obscureText: obscureText,
        keyboardType: keyboardType,
        maxLength: maxLength,
        validator: function,
        controller: textEditingController,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            icon: Icon(
              icon,
              color: const Color.fromARGB(221, 28, 9, 110),
            ),
            labelText: labelText,
            hintText: hintText,
            labelStyle: TextStyle(color: cblack)),
      ),
    );
  }
}
