import 'dart:developer';
import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import '../../../model/chat_model/chat_model.dart';
import '../../../model/student_model/data_base_model.dart';

class AdminChatController extends GetxController {
  int studentIndex = 0;
   int teacherIndex = 0;
  final TextEditingController messageController = TextEditingController();

  messageTitles(String studentDocID, Size size, String chatId, String message,
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
                          .doc(UserCredentialsController.adminModel!.docid)
                          .collection('StudentChats')
                          .doc(studentDocID)
                          .collection('messages')
                          .doc(docid)
                          .delete()
                          .then((value) async {
                        await FirebaseFirestore.instance
                            .collection('DrivingSchoolCollection')
                            .doc(UserCredentialsController.schoolId)
                            .collection('Students')
                            .doc(studentDocID)
                          .collection("Admins")
                          .doc(UserCredentialsController.adminModel!.docid)
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
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    Text(
                      timeformattedd,
                      style: TextStyle(
                          color: const Color.fromARGB(255, 90, 90, 90),
                          fontSize: 10.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 05.h,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  dayformattedd,
                  style: TextStyle(
                      color: const Color.fromARGB(255, 90, 90, 90),
                      fontSize: 10.sp),
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
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Text(
                    timeformattedd,
                    style: TextStyle(
                        color: const Color.fromARGB(255, 90, 90, 90),
                        fontSize: 10.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 05.h,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                dayformattedd,
                style: TextStyle(
                    color: const Color.fromARGB(255, 90, 90, 90),
                    fontSize: 10.sp),
              ),
            ),
          ],
        ),
      );
    }
  }

  sentMessagee( String studentDocID,usercurrentIndex) async {
    var countPlusone = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Students')
        .doc(studentDocID)
        .collection('AdminChatCounter')
        .doc('c3cDX5ymHfITQ3AXcwSp')
        .get();
    int sentStudentChatIndex = (countPlusone.data()?['chatIndex'] ?? 0) + 1;
        int sentIindex = usercurrentIndex + 1;
    //countPlusone.data()?['chatIndex'] + 1 ?? 0;
// final senderName = UserCredentialsController.adminModel?.adminName 
//     ?? UserCredentialsController.addAdminModel?.username 
//     ?? '';
    final id = uuid.v1();
    // final userDetails = SendUserStatusModel(
    //     block: false,
    //     docid: FirebaseAuth.instance.currentUser!.uid,
    //     messageindex: await fectchingStudentCurrentMessageIndex(studentDocID),
    //     senderName:  senderName);
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
        .collection("Admins")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('StudentChats')
        .doc(studentDocID)
        .collection('messages')
        .doc(id)
        .set(sendMessage.toMap())
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .doc(studentDocID)
          .collection('AdminChats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('messages')
          .doc(id)
          .set(sendMessage.toMap())
         // .set(userDetails.toMap(), SetOptions(merge: true))
          .then((value) async {
        FirebaseFirestore.instance
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Students')
            .doc(studentDocID)
            .collection('AdminChats')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            // .collection('messages')
            // .doc(id)
            // .set(sendMessage.toMap())
             .update({'messageindex': sentIindex})
            .then((value) async {
          await FirebaseFirestore.instance
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection('Students')
              .doc(studentDocID)
              .collection('AdminChatCounter')
              .doc('c3cDX5ymHfITQ3AXcwSp')
              .update({'chatIndex': sentStudentChatIndex}).then(
                  (value) => messageController.clear());
        });
      });
    });
  }

   sentMessageeToTutuorByAdmin( String teacherDocID,usercurrentIndex) async {
    var countPlusone = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Teachers')
        .doc(teacherDocID)
        .collection('AdminChatCounter')
        .doc('c3cDX5ymHfITQ3AXcwSp')
        .get();
    int sentTeacherChatIndex = (countPlusone.data()?['chatIndex'] ?? 0) + 1;
    //countPlusone.data()?['chatIndex'] + 1 ?? 0;
// final senderName = UserCredentialsController.adminModel?.adminName 
//     ?? UserCredentialsController.addAdminModel?.username ?? '';
      int sentIindex = usercurrentIndex + 1;
    final id = uuid.v1();
    // final userDetails = SendUserStatusModel(
    //     block: false,
    //     docid: FirebaseAuth.instance.currentUser!.uid,
    //     messageindex: await fectchingTeacherCurrentMessageIndex(teacherDocID),
    //     senderName: senderName);
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
        .collection("Admins")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('TeacherChats')
        .doc(teacherDocID)
        .collection('messages')
        .doc(id)
        .set(sendMessage.toMap())
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Teachers')
          .doc(teacherDocID)
          .collection('AdminChats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
           .collection('messages')
            .doc(id)
            .set(sendMessage.toMap())
         // .set(userDetails.toMap(), SetOptions(merge: true))
          .then((value) async {

        FirebaseFirestore.instance
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Teachers')
            .doc(teacherDocID)
            .collection('AdminChats')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('messages')
            .doc(id)
           .update({'messageindex': sentIindex})
           // .set(sendMessage.toMap())
            .then((value) async {
          await FirebaseFirestore.instance
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection('Teachers')
              .doc(teacherDocID)
              .collection('AdminChatCounter')
              .doc('c3cDX5ymHfITQ3AXcwSp')
              .update({'chatIndex': sentTeacherChatIndex}).then(
                  (value) => messageController.clear());
        });
      });
    });
  }

  unBlockuser(String studentDocID, BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('Do you want to unblock this user?')],
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
                    .collection('StudentChats')
                    .doc(studentDocID)
                    .set({'block': false}, SetOptions(merge: true)).then(
                        (value) => Navigator.of(context).pop());
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
  }

  Future<int> fectchingStudentCurrentMessageIndex(String studentDocID) async {
    final studentData = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Students')
        .doc(studentDocID)
        .collection('AdminChats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (studentData.data()?['messageindex'] == null) {
      return 1;
    } else {
      int currentIndex = studentData.data()!['messageindex'];
      studentIndex = currentIndex + 1;
      return studentIndex;
    }
  }

   Future<int> fectchingTeacherCurrentMessageIndex(String teacherDocID) async {
    final teacherData = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Teachers')
        .doc(teacherDocID)
        .collection('AdminChats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (teacherData.data()?['messageindex'] == null) {
      return 1;
    } else {
      int currentIndex = teacherData.data()!['messageindex'];
      teacherIndex = currentIndex + 1;
      return teacherIndex;
    }
  }

  List<AddStudentModel> searchStudents = [];
  Future<void> fetchStudent() async {
    searchStudents.clear();
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection("DrivingSchoolCollection")
              .doc(UserCredentialsController.schoolId)
              .collection('Students')
              .get();
      searchStudents =
          snapshot.docs.map((e) => AddStudentModel.fromMap(e.data())).toList();
    } catch (e) {
      showToast(msg: "Student Data Error");
    }
  }

  @override
  void onInit() async {
    await fetchStudent();

    super.onInit();
  }
}
