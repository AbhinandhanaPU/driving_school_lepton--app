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
import 'package:new_project_app/controller/user_signup_controller/teacher_sigh_up_controller.dart';
import 'package:new_project_app/view/login/teacher_loginscreen.dart';
import 'package:new_project_app/view/sign_up/teacher_sign_up/teacher_profile_creation.dart';
import 'package:new_project_app/view/widgets/image_container_widgets/image_container_widgets.dart';
import 'package:new_project_app/view/widgets/login_button/login_button.dart';
import 'package:new_project_app/view/widgets/login_text_formfield/login_text_formfield.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class TeacherSignUpScreen extends StatelessWidget {
  PasswordField hideGetxController = Get.find<PasswordField>();
  final teacherSignUpController = Get.put(TeacherSignUpController());

  TeacherSignUpScreen({super.key});

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
                key: teacherSignUpController.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          teacherSignUpController.emailController,
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
                            teacherSignUpController.passwordController,
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
                            teacherSignUpController.confirmpasswordController,
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
                        onTap: () async {
                          if (await teacherSignUpController
                              .isEmailInTempTeacherList(teacherSignUpController
                                  .emailController.text)) {
                            if (teacherSignUpController.formKey.currentState!
                                .validate()) {
                              if (teacherSignUpController
                                      .confirmpasswordController.text
                                      .trim() ==
                                  teacherSignUpController
                                      .passwordController.text
                                      .trim()) {
                                TeacherPasswordSaver.teacherEmailID =
                                    teacherSignUpController.emailController.text
                                        .trim();
                                TeacherPasswordSaver.teacherPassword =
                                    teacherSignUpController
                                        .passwordController.text
                                        .trim();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TeacherProfileCreationScreen(),
                                  ),
                                );
                              } else {
                                showToast(msg: "Password Missmatch");
                              }
                            }
                          } else {
                            // Email does not match, show an error message
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.zero)),
                                content: const Text(
                                    'Email does not match any entry in the TempTeacherList.'),
                                actions: [
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: loginButtonWidget(
                          height: 60,
                          width: 180,
                          text: 'Submit'.tr,
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
                                  return TeacherLoginScreen();
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
