import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/helper/shared_pref_helper.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/admin_model/admin_model.dart';
import 'package:new_project_app/view/users/student/student_home_page/student_home_page.dart';

class AdminLoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isLoading = RxBool(false);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> adminSignIn(BuildContext context) async {
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
            .doc(value.user?.uid)
            .get();

        if (user.data() != null) {
          UserCredentialsController.adminModel =
              AdminModel.fromMap(user.data()!);
          log(UserCredentialsController.adminModel.toString());
        }

        if (UserCredentialsController.adminModel?.userRole == "admin") {
          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.currenUserKey, value.user!.uid);
          await SharedPreferencesHelper.setString(
                  SharedPreferencesHelper.userRoleKey, 'admin')
              .then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const StudentsMainHomeScreen();
                },
              ),
            );
            emailController.clear();
            passwordController.clear();
          });

          isLoading.value = false;
        } else {
          showToast(msg: "You are not a admin");
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
