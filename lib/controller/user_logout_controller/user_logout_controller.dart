// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/helper/shared_pref_helper.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/view/home/first_screen/first_screen.dart';

class UserLogoutController extends GetxController {
  Future<void> userLogOut(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'.tr),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('Are you sure to Logout ?'.tr)],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ok'.tr),
              onPressed: () async {
                await serverAuth.signOut().then((value) async {
                  await SharedPreferencesHelper.clearSharedPreferenceData();
                  UserCredentialsController.clearUserCredentials();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const FirstScreen();
                      },
                    ),
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }
}
