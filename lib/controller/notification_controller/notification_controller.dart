import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/notification_model/notification_model.dart';
import 'package:new_project_app/model/user_device_model/user_device_model.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

class NotificationController extends GetxController {
  TextEditingController headingController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  List<UserDeviceIDModel> selectedUSerUIDList = [];
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;
  final formKey = GlobalKey<FormState>();
  RxBool selectStudent = false.obs;
  RxBool selectTeacher = false.obs;

  Future<void> sendMessageSelectedUSers() async {
    buttonstate.value = ButtonState.loading;
    try {
      if (selectStudent.value && selectTeacher.value) {
        return fetchStudentID().then((studentID) => fetchTeacherID());
      } else if (selectStudent.value) {
        return fetchStudentID();
      } else if (selectTeacher.value) {
        return fetchTeacherID();
      } else {
        return;
      }
    } catch (e) {
      showToast(msg: 'Somthing went wrong please try again');
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }

  Future<void> fetchStudentID() async {
    log('fetchStudentID');
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('AllUsersDeviceID')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        if (selectStudent.value == true &&
            value.docs[i].data()['userrole'] == 'student') {
          log('if teacher Condition');
          log('student UId ${value.docs[i].data()['uid']}');
          final list = value.docs
              .map((e) => UserDeviceIDModel.fromMap(e.data()))
              .toList();
          selectedUSerUIDList.add(list[i]);
        }
      }
    });
  }

  Future<void> fetchTeacherID() async {
    log('fetchTeacherID');
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('AllUsersDeviceID')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        if (selectTeacher.value == true &&
            value.docs[i].data()['userrole'] == 'teacher') {
          log('if teacher Condition');
          log('teacher UId ${value.docs[i].data()['uid']}');
          final list = value.docs
              .map((e) => UserDeviceIDModel.fromMap(e.data()))
              .toList();
          selectedUSerUIDList.add(list[i]);
        }
      }
    });
  }

  Future<void> sendNotificationSelectedUsers(
      {required IconData icon,
      required Color whiteshadeColor,
      required Color containerColor}) async {
    try {
      log('selectedUSerUIDList  $selectedUSerUIDList');

      final uuid = const Uuid().v1();
      NotificationModel messageDetails = NotificationModel(
          dateTime: DateTime.now().toString(),
          docid: uuid,
          open: false,
          icon: icon,
          messageText: messageController.text,
          headerText: headingController.text,
          whiteshadeColor: whiteshadeColor,
          containerColor: containerColor);
      for (var i = 0; i < selectedUSerUIDList.length; i++) {
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('AllUsersDeviceID')
            .doc(selectedUSerUIDList[i].uid)
            .set({'message': true, 'docid': selectedUSerUIDList[i].uid},
                SetOptions(merge: true)).then((value) async {
          await server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection('AllUsersDeviceID')
              .doc(selectedUSerUIDList[i].uid)
              .get()
              .then((value) async {
            await sendPushMessage(selectedUSerUIDList[i].devideID,
                messageController.text, headingController.text);
          }).then((value) async {
            await server
                .collection('DrivingSchoolCollection')
                .doc(UserCredentialsController.schoolId)
                .collection('AllUsersDeviceID')
                .doc(selectedUSerUIDList[i].uid)
                .collection("Notification_Message")
                .doc(uuid)
                .set(messageDetails.toMap());
          });
        });
      }
      selectStudent.value = false;
      selectTeacher.value = false;
      selectedUSerUIDList.clear();
      headingController.clear();
      messageController.clear();
      buttonstate.value = ButtonState.success;
      await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
        buttonstate.value = ButtonState.idle;
      });
    } catch (e) {
      showToast(msg: 'Somthing went wrong please try again');
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }

  Future<void> sendPushMessage(String token, String body, String title) async {
    try {
      final reponse = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAT5j1j9A:APA91bEDY97KTVTB5CH_4YTnLZEol4Z5fxF0fmO654V7YJO6dL9TV_PyIfv64-pVDx477rONsIl8d63VjxT793_Tj4zuGg32JTy_wUNQ4OhGNbr0KOS2i4z7JaG-ZtENTBpYnEGh-ZLg'
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              'title': title,
              'body': body,
              'android_channel_id': 'high_importance_channel'
            },
            'to': token,
          },
        ),
      );
      log(reponse.body.toString());
    } catch (e) {
      if (kDebugMode) {
        log("error push Notification");
      }
    }
  }

  Future<void> userStudentNotification({
    required String studentID,
    required IconData icon,
    required String messageText,
    required String headerText,
    required Color whiteshadeColor,
    required Color containerColor,
  }) async {
    final String docid = uuid.v1();
    try {
      print(messageText);
      log('Calling user notification');
      final details = NotificationModel(
          icon: icon,
          messageText: messageText,
          headerText: headerText,
          whiteshadeColor: whiteshadeColor,
          containerColor: containerColor,
          open: false,
          docid: docid,
          dateTime: DateTime.now().toString());
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection("AllUsersDeviceID")
          .doc(studentID)
          .collection("Notification_Message")
          .doc(docid)
          .set(details.toMap())
          .then((value) async {
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection("AllUsersDeviceID")
            .doc(studentID)
            .get()
            .then((value) async {
          await sendPushMessage(value['devideID'], messageText, headerText);
        });
      });
    } catch (e) {
      log(e.toString());
    }
  }
}

class InfoNotification {
  Color whiteshadeColor = const Color.fromARGB(255, 63, 162, 232);
  Color containerColor = const Color.fromARGB(255, 4, 130, 225);
  IconData icon = Icons.warning_rounded;
}
