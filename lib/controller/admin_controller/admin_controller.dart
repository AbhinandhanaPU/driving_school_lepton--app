import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:progress_state_button/progress_button.dart';

class AdminController extends GetxController {
  RxBool ontapAdmin = false.obs;
  RxString dobSelectedDate = ''.obs;
  RxString joiningSelectedDate = ''.obs;
  final Rx<String> gender = ''.obs;
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;
   final RxList<bool> openedNotifications = <bool>[].obs;
//......................  Add Admin Section

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController conformpassController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxBool automaticmail = false.obs;

  Future<void> createNewAdmin(BuildContext context) async {
    buttonstate.value = ButtonState.loading;
    try {
      await serverAuth
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(), password: passwordController.text.trim())
          .then((value) async {
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Admins')
            .doc(value.user!.uid)
            .set({
          'docid': value.user!.uid,
          'username': nameController.text,
          'password': passwordController.text,
          'email': emailController.text.trim(),
          'phoneNumber': phoneNumberController.text.trim(),
          'active': false,
        }).then(
          (value) async {
            showToast(msg: 'New Admin Created success');
            buttonstate.value = ButtonState.success;

            await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
              buttonstate.value = ButtonState.idle;
            });
          },
        ).then((value) => {
                  nameController.clear(),
                  conformpassController.clear(),
                  passwordController.clear(),
                  emailController.clear(),
                  phoneNumberController.clear(),
                });
      });
    } on FirebaseAuthException catch (e) {
      showToast(msg: e.code);
    } catch (e) {
      log(e.toString());
      showToast(msg: 'Somthing went wrong please try again');
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
    }
  }

  Future<void> deactiveAdmin(String docid) async {}
}
