import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/admin_model/admin_model.dart';

import '../../../model/chat_model/chat_model.dart';

class TutorChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();

  messageTitles(String adminID, Size size, String chatId, String message,
      String docid, String time, BuildContext context) {
    if (FirebaseAuth.instance.currentUser!.uid == chatId) {
      //to get which <<<< DD//Month//Year   >>>>>
      DateTime parseDatee = DateTime.parse(time.toString());
      final DateFormat dayformatterr = DateFormat('dd MMMM yyy');
      String dayformattedd = dayformatterr.format(parseDatee);
      ///////////////////////
      DateTime parseTime = DateTime.parse(time.toString());
      final DateFormat timeformatterr = DateFormat('h:mm a');
      String timeformattedd = timeformatterr.format(parseTime);
////
      return GestureDetector(
        onLongPress: () async {
          return showDialog(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Alert'),
                content: const SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Do you want Delete this message ?')
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () async {
                      log(docid);
                      await FirebaseFirestore.instance
                           .collection('DrivingSchoolCollection')
                          .doc(UserCredentialsController.schoolId)
                          .collection("Admins")
                          .doc(adminID)
                          .collection('TeacherChats')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('messages')
                          .doc(docid)
                          .delete()
                          .then((value) async {
                        await FirebaseFirestore.instance
                            .collection('DrivingSchoolCollection')
                            .doc(UserCredentialsController.schoolId)
                            .collection("Teachers")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('AdminChats')
                            .doc(adminID)
                            .collection('messages')
                            .doc(docid)
                            .delete()
                            .then((value) => Get.back());
                      });
                    },
                  ),
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          width: size.width,
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 194, 243, 189),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$message              ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    Text(
                      timeformattedd,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 90, 90, 90), fontSize: 10),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 05,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  dayformattedd,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 90, 90, 90), fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      //to get which <<<< DD//Month//Year   >>>>>
      DateTime parseDatee = DateTime.parse(time.toString());
      final DateFormat dayformatterr = DateFormat('dd MMMM yyy');
      String dayformattedd = dayformatterr.format(parseDatee);
      ///////////////////////
      DateTime parseTime = DateTime.parse(time.toString());
      final DateFormat timeformatterr = DateFormat('h:mm a');
      String timeformattedd = timeformatterr.format(parseTime);
////
      return Container(
        width: size.width,
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$message              ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Text(
                    timeformattedd,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 90, 90, 90), fontSize: 10),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 05,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                dayformattedd,
                style: const TextStyle(
                    color: Color.fromARGB(255, 90, 90, 90), fontSize: 10),
              ),
            ),
          ],
        ),
      );
    }
  }

  sentMessages(String adminId, int usercurrentIndex,
      int parentChatCounterIndex) async {
    var countPlusone = await FirebaseFirestore.instance
         .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection("Admins")
        .doc(adminId)
        .collection('TutorChatCounter')
        .doc('F0Ikn1UouYIkqmRFKIpg')
        .get();

    int sentStudentChatIndex = countPlusone.data()?['chatIndex'] + 1;
    int sentIindex = usercurrentIndex + 1;
    log('''countPlusone.data()?['chatIndex']  ${countPlusone.data()?['chatIndex']}''');
    // log("Student id${FirebaseAuth.instance.currentUser!.uid}");
    final id = uuid.v1();
    final sendMessage = OnlineChatModel(
      message: messageController.text,
      messageindex: 1,
      chatid: FirebaseAuth.instance.currentUser!.uid,
      docid: id,
      sendTime: DateTime.now().toString(),
    );
    await FirebaseFirestore.instance
       .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection("Teachers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('AdminChats')
        .doc(adminId)
        .collection('messages')
        .doc(id)
        .set(sendMessage.toMap())
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection("Admins")
          .doc(adminId)
          .collection('TeacherChats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('messages')
          .doc(id)
          .set(sendMessage.toMap())
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection("Admins")
            .doc(adminId)
            .collection('TeacherChats')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'messageindex': sentIindex}).then((value) async {
          await FirebaseFirestore.instance
             .collection('DrivingSchoolCollection')
             .doc(UserCredentialsController.schoolId)
             .collection("Admins")
              .doc(adminId)
              .collection('TutorChatCounter')
              .doc('F0Ikn1UouYIkqmRFKIpg')
              .update({'chatIndex': sentStudentChatIndex}).then(
                  (value) => messageController.clear());
        });
      });
    });
  }

  unBlockuser(String adminId, BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('Do you want Unblock this user ?')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('DrivingSchoolCollection')
                    .doc(UserCredentialsController.schoolId)
                    .collection("Admins")
                    .doc(UserCredentialsController.adminModel!.docid)
                    .collection('AdminChats')
                    .doc(adminId)
                    .set({'block': false}, SetOptions(merge: true)).then(
                        (value) => Navigator.of(context).pop());
              },
            ),
            TextButton(
              child: const Text('Cancek'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<AdminModel> searchTeacher = [];
  Future<void> fetchAdmin() async {
    searchTeacher.clear();
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection("Admins")
              .get();
      searchTeacher =
          snapshot.docs.map((e) => AdminModel.fromMap(e.data())).toList();
    } catch (e) {
      showToast(msg: "Admin Data Error");
    }
  }

  @override
  void onInit() async {
    await fetchAdmin();
    super.onInit();
  }
}
