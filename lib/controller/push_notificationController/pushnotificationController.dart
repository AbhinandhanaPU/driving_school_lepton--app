import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';

class PushNotificationController extends GetxController {
  RxString deviceID = ''.obs;
  Future<void> getUserDeviceID() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      deviceID.value = token ?? "";
      log("Device ID $token");
    });
  }

  Future<void> allUSerDeviceID(String userrole, String currentUSer) async {
    log('>currentUID>>>>$currentUSer');
    log('>>>>>User Role ${UserCredentialsController.userRole}');
    print('allUSerDeviceID');
    print('allUSerDeviceID  $currentUSer');
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('AllUsersDeviceID')
          .doc(currentUSer)
          .set({
        'docId': currentUSer,
        'userRole': userrole,
        'devideID': deviceID.value,
      }, SetOptions(merge: true)).then((value) async {
        await server
            .collection('AllUsersDeviceID')
            .doc(currentUSer)
            .update({"devideID": deviceID.value});
      });
      print('allUSerDeviceID**** FINISHED');
    } catch (e) {
      log(e.toString());
    }
  }
}
