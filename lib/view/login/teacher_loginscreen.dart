import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/text_hide_controller/text_hide_controller.dart';
import 'package:new_project_app/controller/user_login_controller/teacher_login_controller.dart';
import 'package:new_project_app/view/sign_up/teacher_sign_up/teacher_sign_up_page.dart';
import 'package:new_project_app/view/widgets/forgot_password_screen/forgot_password.dart';
import 'package:new_project_app/view/widgets/image_container_widgets/image_container_widgets.dart';
import 'package:new_project_app/view/widgets/login_button/login_button.dart';
import 'package:new_project_app/view/widgets/login_text_formfield/login_text_formfield.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_montserrat.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class TeacherLoginScreen extends StatelessWidget {
  final PasswordField hideGetxController = Get.put(PasswordField());
  final TeacherLoginController teacherLoginController = Get.put(TeacherLoginController());
  TeacherLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text('Tutor Login'),
        backgroundColor: themeColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: teacherLoginController.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AssetContainerImage(
                    height: 340.h,
                    width: double.infinity,
                    imagePath: 'assets/images/teacherDriver.png'),
                GoogleMontserratWidgets(
                  fontsize: 25.w,
                  text: 'Tutor Login'.tr,
                  color: cblack,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
                kHeight20,
                //  Mail id Session
                LoginTextFormfield(
                  obscureText: false,
                  hintText: 'Email ID'.tr,
                  labelText: 'Enter Mail ID',
                  prefixIcon: const Icon(Icons.mail_outline),
                  textEditingController: teacherLoginController.emailController,
                  validator: checkFieldEmailIsValid,
                ),
                kHeight20,
                //  Password
                Obx(
                  () => LoginTextFormfield(
                    hintText: 'Password'.tr,
                    labelText: 'Password',
                    icon: Icons.lock,
                    obscureText: hideGetxController.isObscurefirst.value,
                    textEditingController: teacherLoginController.passwordController,
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

                Padding(
                  padding: EdgeInsets.only(left: 210.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: GooglePoppinsWidgets(
                      fontsize: 15,
                      text: 'Forgot Password?'.tr,
                      fontWeight: FontWeight.w400,
                      color: themeColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 60.h),
                  child: GestureDetector(
                    onTap: () async {
                      if (teacherLoginController.formKey.currentState!.validate()) {
                        await teacherLoginController.teacherSignIn(context);
                      }
                    },
                    child: Obx(
                      () => teacherLoginController.isLoading.value
                          ? circularProgressIndicatotWidget
                          : loginButtonWidget(
                              height: 50,
                              width: 150,
                              text: 'Login'.tr,
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GooglePoppinsWidgets(text: "Don't Have an account?".tr, fontsize: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeacherSignUpScreen(),
                            ),
                          );
                        },
                        child: GooglePoppinsWidgets(
                          text: ' Sign Up'.tr,
                          fontsize: 19,
                          color: themeColor,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
