import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/helper/shared_pref_helper.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/splash_screen/splash_screen.dart';
import 'package:new_project_app/view/widgets/custom_show_dialogbox/message_show_dialog.dart';

class StudentLoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = RxBool(false);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> studentSignIn(BuildContext context) async {
    try {
      isLoading.value = true;
      await serverAuth
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((value) async {
        final user = await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Students')
            .doc(value.user?.uid)
            .get();

        if (user.data() != null) {
          UserCredentialsController.studentModel =
              StudentModel.fromMap(user.data()!);
          log(UserCredentialsController.studentModel.toString());
        }

        if (UserCredentialsController.studentModel?.userRole == "student") {
          if (UserCredentialsController.studentModel!.status == "active") {
            await SharedPreferencesHelper.setString(
                SharedPreferencesHelper.currenUserKey, value.user!.uid);
            await SharedPreferencesHelper.setString(
                    SharedPreferencesHelper.userRoleKey, 'student')
                .then((value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SplashScreen();
                  },
                ),
              );
              emailController.clear();
              passwordController.clear();
            });

            isLoading.value = false;
          } else {
            isLoading.value = false;
            customMessageDialogBox(
              context: context,
              message: 'Your account is Deactivated',
              onPressed: () {
                Get.back();
              },
            );
          }
        } else {
          showToast(msg: "You are not a student");
          isLoading.value = false;
        }
      }).catchError((error) {
        if (error is FirebaseAuthException) {
          isLoading.value = false;
          handleFirebaseError(error);
        }
      });
    } catch (e) {
      isLoading.value = false;
      showToast(msg: "Sign in failed");
    }
  }
}
