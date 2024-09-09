import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('AllUsersDeviceID')
            .doc(currentUSer)
            .update({"devideID": deviceID.value});
      });
      print('allUSerDeviceID**** FINISHED');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> removeAllNotification() async {
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection("AllUsersDeviceID")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("Notification_Message")
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection("AllUsersDeviceID")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection("Notification_Message")
            .doc(value.docs[i].data()['docid'])
            .delete();
      }
      Get.back();
    });
  }

  Future<void> removeSingleNotification(String docid) async {
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection("AllUsersDeviceID")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('Notification_Message')
        .doc(docid)
        .delete()
        .then((value) => Get.back());
  }
}
