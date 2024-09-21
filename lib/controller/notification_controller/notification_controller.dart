import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/notification_model/notification_model.dart';
import 'package:new_project_app/model/practice_shedule_model/practice_shedule_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/model/test_model/test_model.dart';
import 'package:new_project_app/model/user_device_model/user_device_model.dart';
import 'package:new_project_app/view/widgets/notification_color/notification_color_widget.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

class NotificationController extends GetxController {
  TextEditingController headingController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;
  final formKey = GlobalKey<FormState>();
  RxBool selectStudent = false.obs;
  RxBool selectTeacher = false.obs;

  Future<void> sendNotificationSelectedUsers(
      {required IconData icon,
      required Color whiteshadeColor,
      required Color containerColor}) async {
    try {
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
            .doc(selectedUSerUIDList[i].docId)
            .set({'message': true, 'docid': selectedUSerUIDList[i].docId},
                SetOptions(merge: true)).then((value) async {
          await server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection('AllUsersDeviceID')
              .doc(selectedUSerUIDList[i].docId)
              .get()
              .then((value) async {
            await sendPushMessage(selectedUSerUIDList[i].devideID,
                messageController.text, headingController.text);
          }).then((value) async {
            await server
                .collection('DrivingSchoolCollection')
                .doc(UserCredentialsController.schoolId)
                .collection('AllUsersDeviceID')
                .doc(selectedUSerUIDList[i].docId)
                .collection("Notification_Message")
                .doc(uuid)
                .set(messageDetails.toMap());
          });
        });
      }

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

  List<UserDeviceIDModel> selectedUSerUIDList = []; // fetchUsersID
  Future<void> fetchUsersID({required String role}) async {
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('AllUsersDeviceID')
        .get()
        .then((usersvalue) async {
      for (var i = 0; i < usersvalue.docs.length; i++) {
        if (usersvalue.docs[i].data()['userRole'] == role) {
          final list = usersvalue.docs
              .map((e) => UserDeviceIDModel.fromMap(e.data()))
              .toList();
          selectedUSerUIDList.add(list[i]);
        }
      }
    });
  }

  Future<void> sendPushMessage(String token, String body, String title) async {
    final Uri url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/driving-school-6e78e/messages:send');

    final Map<String, dynamic> message = {
      'message': {
        'token': token,
        'notification': {
          'title': title,
          'body': body,
        },
        'android': {
          'notification': {
            'title': title,
            'body': body,
            'click_action': 'TOP_STORY_ACTIVITY'
          },
          'data': {'story_id': 'story_12345'}
        },
        'apns': {
          'payload': {
            'aps': {'category': 'NEW_MESSAGE_CATEGORY'}
          },
        },
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'status': 'done',
          'body': body,
          'title': title,
        },
      },
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await getPushNotification()}',
        },
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully!');
      } else {
        print('Failed to send notification: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception caught sending notification: $e');
    }
  }

  Future<String> getPushNotification() async {
    String serverKey = 'notification-key'; // default value

    // Fetch the serverKey from Firestore and wait for the result
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('PushNotification')
        .doc('key')
        .get();

    // Safely cast the data to a Map<String, dynamic> before accessing the 'key'
    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      if (data != null && data.containsKey('key')) {
        serverKey = data['key'];
      }
    }

    return serverKey;
  }

  List<UserDeviceIDModel> fetchUnpaidUsersDeviceIDList = [];
  Future<void> fetchUnpaidUsers({
    required String batchID,
    required String bodyText,
    required String titleText,
  }) async {
    final uuid = const Uuid().v1();
    fetchUnpaidUsersDeviceIDList.clear();
    NotificationModel messageDetails = NotificationModel(
      dateTime: DateTime.now().toString(),
      docid: uuid,
      open: false,
      icon: AlertNotifierSetup().icon,
      messageText: bodyText,
      headerText: titleText,
      whiteshadeColor: AlertNotifierSetup().whiteshadeColor,
      containerColor: AlertNotifierSetup().containerColor,
    );
    try {
      showToast(msg: "Please wait......");
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('FeesCollection')
          .doc(batchID)
          .collection('Courses')
          .get()
          .then((courseId) async {
        for (var i = 0; i < courseId.docs.length; i++) {
          await server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection('FeesCollection')
              .doc(batchID)
              .collection('Courses')
              .doc(courseId.docs[i].data()['courseId'])
              .collection('Students')
              .get()
              .then((docvalue) async {
            for (var i = 0; i < docvalue.docs.length; i++) {
              if (docvalue.docs[i].data()['paidStatus'] == false) {
                final userID = docvalue.docs[i].data()['studentID'];
                try {
                  await server
                      .collection('DrivingSchoolCollection')
                      .doc(UserCredentialsController.schoolId)
                      .collection('AllUsersDeviceID')
                      .doc(userID)
                      .get()
                      .then((usersvalue) async {
                    fetchUnpaidUsersDeviceIDList
                        .add(UserDeviceIDModel.fromMap(usersvalue.data()!));
                  });
                } catch (e) {
                  log('fetch AllUsersDeviceID Collection Error: $e');
                }
              }
            }
          }).then((value) async {
            for (var i = 0; i < fetchUnpaidUsersDeviceIDList.length; i++) {
              await sendPushMessage(fetchUnpaidUsersDeviceIDList[i].devideID,
                  bodyText, titleText); // Push notification
              await server
                  .collection('DrivingSchoolCollection')
                  .doc(UserCredentialsController.schoolId)
                  .collection('AllUsersDeviceID')
                  .doc(fetchUnpaidUsersDeviceIDList[i].docId)
                  .collection("Notification_Message")
                  .doc(uuid)
                  .set(messageDetails.toMap());
            }
          });
        }
      }).then((value) {
        showToast(msg: "Notification sent successfully");
        fetchUnpaidUsersDeviceIDList.clear();
      });
    } catch (e) {
      log('fetchUnpaidUsers Error: $e');
      fetchUnpaidUsersDeviceIDList.clear();
    }
  }

  List<StudentModel> allDrivingStudentList = [];
  Future<void> fetchDrivingTestAllUsers(
      {required String bodyText, required String titleText}) async {
    showToast(msg: "Please wait......");
    allDrivingStudentList.clear();

    try {
      // Get the diving test data first
      final divingTestDatas = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('DrivingTest')
          .get();

      // Loop through each diving test data
      for (var i = 0; i < divingTestDatas.docs.length; i++) {
        final data = TestModel.fromMap(divingTestDatas.docs[i].data());
        log("testTime: ${data.testTime}");

        // Get the students for each driving test
        final allStudentvalue = await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('DrivingTest')
            .doc(data.docId)
            .collection('Students')
            .get();

        // If there are students, add them to the list
        if (allStudentvalue.docs.isNotEmpty) {
          final results = allStudentvalue.docs
              .map((e) => StudentModel.fromMap(e.data()))
              .toList();
          allDrivingStudentList.addAll(results);
        }
      }

      // Now you can safely use the populated allDrivingStudentList
      final uuid = const Uuid().v1();
      NotificationModel messageDetails = NotificationModel(
        dateTime: DateTime.now().toString(),
        docid: uuid,
        open: false,
        icon: WarningNotifierSetup().icon,
        messageText: bodyText,
        headerText: titleText,
        whiteshadeColor: WarningNotifierSetup().whiteshadeColor,
        containerColor: WarningNotifierSetup().containerColor,
      );
      for (var i = 0; i < allDrivingStudentList.length; i++) {
        log(allDrivingStudentList[i].studentName.toString());
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('AllUsersDeviceID')
            .doc(allDrivingStudentList[i].docid)
            .get()
            .then((value) async {
          if (value.data() != null) {
            await sendPushMessage(value.data()!['devideID'], bodyText,
                titleText); // Push notification
            await server
                .collection('DrivingSchoolCollection')
                .doc(UserCredentialsController.schoolId)
                .collection('AllUsersDeviceID')
                .doc(allDrivingStudentList[i].docid)
                .collection("Notification_Message")
                .doc(uuid)
                .set(messageDetails.toMap());
          }
        });
      }
    } catch (e) {
      log('fetchDrivingTestAllUsers Error: $e');
      showToast(msg: "Please try again");
    }
  }

  List<StudentModel> fetchStudentsForPartice = [];
  Future<void> sendNotificationParticeSchedule(
      {required String bodyText,
      required String titleText,
      required List<PracticeSheduleModel> selectedListDocID}) async {
    try {
      showToast(msg: "Please wait......");
      fetchStudentsForPartice.clear();
      for (var i = 0; i < selectedListDocID.length; i++) {
        final QuerySnapshot<Map<String, dynamic>> fetchstudentparaticeSDetails =
            await server
                .collection('DrivingSchoolCollection')
                .doc(UserCredentialsController.schoolId)
                .collection('PracticeSchedule')
                .doc(selectedListDocID[i].practiceId)
                .collection('Students')
                .get();
        final results = fetchstudentparaticeSDetails.docs
            .map((e) => StudentModel.fromMap(e.data()))
            .toList();
        fetchStudentsForPartice.addAll(results);
      }
      // Now you can safely use the populated allDrivingStudentList
      final uuid = const Uuid().v1();
      NotificationModel messageDetails = NotificationModel(
        dateTime: DateTime.now().toString(),
        docid: uuid,
        open: false,
        icon: CardNotifierSetup().icon,
        messageText: bodyText,
        headerText: titleText,
        whiteshadeColor: CardNotifierSetup().whiteshadeColor,
        containerColor: CardNotifierSetup().containerColor,
      );
      for (var i = 0; i < fetchStudentsForPartice.length; i++) {
        log(fetchStudentsForPartice[i].studentName.toString());
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('AllUsersDeviceID')
            .doc(fetchStudentsForPartice[i].docid)
            .get()
            .then((value) async {
          if (value.data() != null) {
            await sendPushMessage(value.data()!['devideID'], bodyText,
                titleText); // Push notification
            await server
                .collection('DrivingSchoolCollection')
                .doc(UserCredentialsController.schoolId)
                .collection('AllUsersDeviceID')
                .doc(fetchStudentsForPartice[i].docid)
                .collection("Notification_Message")
                .doc(uuid)
                .set(messageDetails.toMap());
          }
        });
      }
      showToast(msg: "Notification sent successfully");
    } catch (e) {
      log('sendNotificationParticeSchedule Error: $e');
      showToast(msg: "Please try again");
    }
  }
}
