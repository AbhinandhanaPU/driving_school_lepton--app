import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/helper/shared_pref_helper.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/teacher_model/teacher_model.dart';
import 'package:new_project_app/view/splash_screen/splash_screen.dart';

class TeacherLoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = RxBool(false);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> teacherSignIn(BuildContext context) async {
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
            .collection('Teachers')
            .doc(value.user?.uid)
            .get();

        if (user.data() != null) {
          UserCredentialsController.teacherModel = TeacherModel.fromMap(user.data()!);
          log(UserCredentialsController.teacherModel.toString());
        }

        if (UserCredentialsController.teacherModel?.userRole == "teacher") {
          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.currenUserKey, value.user!.uid);
          await SharedPreferencesHelper.setString(SharedPreferencesHelper.userRoleKey, 'teacher')
              .then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const SplashScreen();
                },
              ),
            );
            emailController.clear();
            passwordController.clear();
          });

          isLoading.value = false;
        } else {
          showToast(msg: "You are not a teacher");
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
