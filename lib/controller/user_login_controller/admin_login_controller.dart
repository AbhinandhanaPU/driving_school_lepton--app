import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/helper/shared_pref_helper.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/admin_model/admin_model.dart';
import 'package:new_project_app/view/splash_screen/splash_screen.dart';

class AdminLoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isLoading = RxBool(false);
  RxBool logined = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<bool> secondaryAdminLogin(BuildContext context) async {
    try {
      await serverAuth
          .signInWithEmailAndPassword(
              email: emailController.text.trim(), password: passwordController.text.trim())
          .then((authvalue) async {
        await SharedPreferencesHelper.setString(
            SharedPreferencesHelper.currentUserDocid, authvalue.user!.uid);
        final result = await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Admins')
            .doc(authvalue.user?.uid)
            .get();
        if (result.data() != null) {
          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.userRoleKey, 'secondoryAdmin');
          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.schoolIdKey, UserCredentialsController.schoolId!);
          emailController.clear();
          passwordController.clear();
          isLoading.value = false;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const SplashScreen();
              },
            ),
          );
          // if (result.data() != null) {
          //   UserCredentialsController.adminModel =
          //       AdminModel.fromMap(result.data()!);
          //   log(UserCredentialsController.adminModel.toString());
          // }
        } else {
          logined.value = false;
          showToast(msg: "Secondary-Admin login failed");
        }
      }).catchError((error) {
        if (error is FirebaseAuthException) {
          isLoading.value = false;
          handleFirebaseError(error);
        }
      });
    } catch (e) {
      log(e.toString());
      showToast(msg: "Secondary-Admin login failed");
    }
    return true;
  }

  Future<void> adminSignIn(BuildContext context) async {
    try {
      isLoading.value = true;
      await serverAuth
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((value) async {
        final user = await server.collection('DrivingSchoolCollection').doc(value.user?.uid).get();

        if (user.data() != null) {
          UserCredentialsController.adminModel = AdminModel.fromMap(user.data()!);
          log(UserCredentialsController.adminModel.toString());
        }

        if (UserCredentialsController.adminModel?.userRole == "admin") {
          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.currentUserDocid, value.user!.uid);
          await SharedPreferencesHelper.setString(SharedPreferencesHelper.userRoleKey, 'admin')
              .then((value) {
            isLoading.value = false;
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
        } else {
          // Attempt Secondary Admin Login if not Admin
          await secondaryAdminLogin(context);
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
