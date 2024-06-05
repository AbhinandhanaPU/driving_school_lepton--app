// ignore_for_file: must_be_immutable

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/const/const.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/text_hide_controller/text_hide_controller.dart';
import 'package:new_project_app/controller/user_signup_controller/student_signup_controller.dart';
import 'package:new_project_app/view/login/student_login_screen.dart';
import 'package:new_project_app/view/sign_up/student_sign_up/student_profile_creation.dart';
import 'package:new_project_app/view/widgets/image_container_widgets/image_container_widgets.dart';
import 'package:new_project_app/view/widgets/login_button/login_button.dart';
import 'package:new_project_app/view/widgets/login_text_formfield/login_text_formfield.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class StudentSignUpScreen extends StatelessWidget {
  StudentSignUpScreen({super.key});
  PasswordField hideGetxController = Get.find<PasswordField>();
  final studentSignUpController = Get.put(StudentSignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: const Text("Driving School"),
        backgroundColor: themeColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AssetContainerImage(
                height: 300.h,
                width: double.infinity,
                imagePath: 'assets/images/licence.jpeg',
              ),
              kHeight30,
              Form(
                key: studentSignUpController.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    kHeight10,
                    LoginTextFormfield(
                      obscureText: false,
                      hintText: 'Email ID'.tr,
                      labelText: 'Enter Mail ID',
                      prefixIcon: const Icon(Icons.mail_outline),
                      textEditingController:
                          studentSignUpController.emailController,
                      validator: checkFieldEmailIsValid,
                    ),
                    kHeight10,
                    Padding(
                      padding: EdgeInsets.only(right: 32.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GooglePoppinsWidgets(
                            text: "* Use a valid email".tr,
                            fontsize: 13.w,
                            fontWeight: FontWeight.w500,
                            color: themeColor,
                          ),
                        ],
                      ),
                    ),
                    kHeight10,
                    Obx(
                      () => LoginTextFormfield(
                        hintText: 'Password'.tr,
                        obscureText: hideGetxController.isObscurefirst.value,
                        labelText: 'Password',
                        icon: Icons.lock,
                        textEditingController:
                            studentSignUpController.passwordController,
                        validator: checkFieldPasswordIsValid,
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.lock),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(hideGetxController.isObscurefirst.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            hideGetxController.toggleObscureFirst();
                          },
                        ),
                      ),
                    ),
                    kHeight10,
                    Obx(
                      () => LoginTextFormfield(
                        hintText: 'Confirm Password'.tr,
                        labelText: 'Confirm Password',
                        obscureText: hideGetxController.isObscureSecond.value,
                        icon: Icons.lock,
                        textEditingController:
                            studentSignUpController.confirmPasswordController,
                        validator: checkFieldPasswordIsValid,
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.lock),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(hideGetxController.isObscureSecond.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            hideGetxController.toggleObscureSecond();
                          },
                        ),
                      ),
                    ),
                    kHeight10,
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: GestureDetector(
                        onTap: () {
                          if (studentSignUpController.formKey.currentState!
                              .validate()) {
                            if (studentSignUpController
                                    .confirmPasswordController.text
                                    .trim() ==
                                studentSignUpController.passwordController.text
                                    .trim()) {
                              StudentPasswordSaver.studentEmailID =
                                  studentSignUpController.emailController.text
                                      .trim();
                              StudentPasswordSaver.studentPassword =
                                  studentSignUpController
                                      .passwordController.text
                                      .trim();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StudentProfileCreationScreen(),
                                ),
                              );
                            } else {
                              showToast(msg: "Password Missmatch");
                            }
                          }
                        },
                        child: Obx(
                          () => studentSignUpController.isLoading.value
                              ? circularProgressIndicatotWidget
                              : loginButtonWidget(
                                  height: 60,
                                  width: 180,
                                  text: 'Submit'.tr,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?".tr,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return StudentLoginScreen();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Login".tr,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontSize: 19,
                                color: themeColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
