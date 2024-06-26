import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/text_hide_controller/text_hide_controller.dart';
import 'package:new_project_app/controller/user_login_controller/admin_login_controller.dart';
import 'package:new_project_app/view/widgets/forgot_password_screen/forgot_password.dart';
import 'package:new_project_app/view/widgets/image_container_widgets/image_container_widgets.dart';
import 'package:new_project_app/view/widgets/login_button/login_button.dart';
import 'package:new_project_app/view/widgets/login_text_formfield/login_text_formfield.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_montserrat.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class AdminLoginScreen extends StatelessWidget {
  final PasswordField hideGetxController = Get.put(PasswordField());

  final AdminLoginController adminLoginController = Get.put(AdminLoginController());
  AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Login"),
        backgroundColor: themeColor,
        foregroundColor: cWhite,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: adminLoginController.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AssetContainerImage(
                    height: 340.h, width: double.infinity, imagePath: 'assets/images/login.webp'),
                GoogleMontserratWidgets(
                  fontsize: 25.w,
                  text: 'Admin Login'.tr,
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
                  textEditingController: adminLoginController.emailController,
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
                    textEditingController: adminLoginController.passwordController,
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
                      if (adminLoginController.formKey.currentState!.validate()) {
                        await adminLoginController.adminSignIn(context);
                      }
                    },
                    child: Obx(
                      () => adminLoginController.isLoading.value
                          ? circularProgressIndicatotWidget
                          : loginButtonWidget(
                              height: 50,
                              width: 150,
                              text: 'Login'.tr,
                            ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: 20.h),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       GooglePoppinsWidgets(text: "Don't Have an account?".tr, fontsize: 15),
                //       GestureDetector(
                //         onTap: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => const SchoolProfile(),
                //             ),
                //           );
                //         },
                //         child: GooglePoppinsWidgets(
                //           text: ' Sign Up'.tr,
                //           fontsize: 19,
                //           color: themeColor,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
