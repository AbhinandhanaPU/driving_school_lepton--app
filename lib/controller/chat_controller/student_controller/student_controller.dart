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
import 'package:new_project_app/model/admin_model/data_base_model_ad.dart';
import 'package:new_project_app/model/chat_model/send_chatModel.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/model/teacher_model/teacher_model.dart';

import '../../../model/chat_model/chat_model.dart';

class StudentChatController extends GetxController {
   int studentIndex = 0;
   int teacherIndex = 0;
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
                content: SingleChildScrollView(
                  child: ListBody(
                    children: const <Widget>[
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
                          .collection('StudentChats')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('messages')
                          .doc(docid)
                          .delete()
                          .then((value) async {
                        await FirebaseFirestore.instance
                            .collection('DrivingSchoolCollection')
                            .doc(UserCredentialsController.schoolId)
                            .collection('Students')
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
                padding:const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 194, 243, 189),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('$message              ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    Text(timeformattedd,
                      style: const TextStyle(color: Color.fromARGB(255, 90, 90, 90), fontSize: 10),
                    ),
                  ],
                ),
              ),
              const SizedBox( height: 05,),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text( dayformattedd,
                  style: const TextStyle(color: Color.fromARGB(255, 90, 90, 90), fontSize: 10),
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
                  Text('$message              ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Text(timeformattedd,
                    style: const TextStyle( color: Color.fromARGB(255, 90, 90, 90), fontSize: 10),
                  ),
                ],
              ),
            ),
            const SizedBox( height: 05, ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                dayformattedd,
                style: const TextStyle( color: Color.fromARGB(255, 90, 90, 90), fontSize: 10),
              ),
            ),
          ],
        ),
      );
    }
  }
   sentMessageTeacher(String teacherId,  usercurrentIndex,
     int studentchatCounterIndex ) async {
    var countPlusone = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection("Teachers")
        .doc(teacherId)
        .collection('StudentChatCounter')
        .doc('F0Ikn1UouYIkqmRFKIpg')
        .get();

    int sentStudentChatIndex = (countPlusone.data()?['chatIndex'] ?? 0) + 1;
    int sentIindex = usercurrentIndex + 1;
    log('usercurrentIndex  $usercurrentIndex');
    // log("Student id${FirebaseAuth.instance.currentUser!.uid}");
    final id = uuid.v1();
    //  final userDetails = SendUserStatusModel(
    //     block: false,
    //     docid: FirebaseAuth.instance.currentUser!.uid,
    //     messageindex: await fectchingCurrentMessageIndex(teacherId),
    //     senderName: UserCredentialsController.studentModel?.studentName??"");
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
        .collection('Students')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('TeacherChats')
        .doc(teacherId)
        .collection('messages')
        .doc(id)
        .set(sendMessage.toMap())
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection("Teachers")
          .doc(teacherId)
          .collection('StudentChats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          //.set(userDetails.toMap(), SetOptions(merge: true))
          .collection('messages')
          .doc(id)
          .set(sendMessage.toMap())
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection("Teachers")
            .doc(teacherId)
            .collection('StudentChats')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            // .collection('messages')
            // .doc(id)
            // .set(sendMessage.toMap())
           .update({'messageindex': sentIindex})
            .then((value) async {
           var docSnapshot = await FirebaseFirestore.instance
      .collection('DrivingSchoolCollection')
      .doc(UserCredentialsController.schoolId)
      .collection("Teachers")
      .doc(teacherId)
      .collection('StudentChatCounter')
      .doc('F0Ikn1UouYIkqmRFKIpg')
      .get();

  if (docSnapshot.exists) {
    // Document exists, proceed with update
    await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection("Teachers")
        .doc(teacherId)
        .collection('StudentChatCounter')
        .doc('F0Ikn1UouYIkqmRFKIpg')
        .update({'chatIndex': sentStudentChatIndex});
  } else {
    // Document does not exist, create it
    await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection("Teachers")
        .doc(teacherId)
        .collection('StudentChatCounter')
        .doc('F0Ikn1UouYIkqmRFKIpg')
        .set({'chatIndex': sentStudentChatIndex}, SetOptions(merge: true));
  } messageController.clear();
        });
      });
    });
  }
   Future<int> fectchingCurrentMessageIndex(String teacherId) async {
    final teacherData = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Teachers')
        .doc(teacherId)
        .collection('StudentChats')
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

   Future<int> fectchingTeacherCurrentMessageIndex(String teacherId) async {
    final teacherData = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Teachers')
        .doc(teacherId)
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
    Future<int> fectchingStudentCurrentMessageIndex(String adminId) async {
    final stdData = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Admins')
        .doc(adminId)
        .collection('StudentChats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (stdData.data()?['messageindex'] == null) {
      return 1;
    } else {
      int currentIndex = stdData.data()!['messageindex'];
      studentIndex = currentIndex + 1;
      return studentIndex;
    }
  }
    sentMessage(String adminId, int usercurrentIndex,
      int studentchatCounterIndex) async {
    var countPlusone = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection("Admins")
        .doc(adminId)
        .collection('StudentChatCounter')
        .doc('F0Ikn1UouYIkqmRFKIpg')
        .get();

    int sentStudentChatIndex = (countPlusone.data()?['chatIndex'] ?? 0) + 1;
    // ignore: unused_local_variable
    int sentIindex = usercurrentIndex + 1;
    log('usercurrentIndex  $usercurrentIndex');
    // log("Student id${FirebaseAuth.instance.currentUser!.uid}");
    final id = uuid.v1();
     final userDetails = SendUserStatusModel(
        block: false,
        docid: FirebaseAuth.instance.currentUser!.uid,
        messageindex: await fectchingStudentCurrentMessageIndex(adminId),
        senderName: UserCredentialsController.studentModel?.studentName??"");
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
        .collection('Students')
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
          .collection('StudentChats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(userDetails.toMap(), SetOptions(merge: true))
          // .collection('messages')
          // .doc(id)
          // .set(sendMessage.toMap())
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection("Admins")
            .doc(adminId)
            .collection('StudentChats')
            .doc(FirebaseAuth.instance.currentUser!.uid)
             .collection('messages')
            .doc(id)
            .set(sendMessage.toMap())
          //  .update({'messageindex': sentIindex})
            .then((value) async {
          await FirebaseFirestore.instance
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection("Admins")
              .doc(adminId)
              .collection('StudentChatCounter')
              .doc('F0Ikn1UouYIkqmRFKIpg')
              .update({'chatIndex': sentStudentChatIndex}).then(
                  (value) => messageController.clear());
        });
      });
    });
  }

  unBlockuser(String teacherId, BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[Text('Do you want Unblock this user ?')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('DrivingSchoolCollection')
                    .doc(UserCredentialsController.schoolId)
                    .collection("Students")
                    .doc(UserCredentialsController.studentModel!.docid)
                    .collection('TeacherChats')
                    .doc(teacherId)
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
 List<StudentModel> searchStudent = [];

   Future<void> fetchStudents() async {
    searchStudent.clear();
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection("DrivingSchoolCollection")
              .doc(UserCredentialsController.schoolId)
              .collection("Students")
              .get();
      searchStudent =
          snapshot.docs.map((e) => StudentModel.fromMap(e.data())).toList();
          
    } catch (e) {
      showToast(msg: "Student Data Error");
    }
  }
  List<TeacherModel> searchTeacher = [];
  Future<void> fetchTeacher() async {
    searchTeacher.clear();
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection("DrivingSchoolCollection")
              .doc(UserCredentialsController.schoolId)
              .collection("Teachers")
              .get();
      searchTeacher =
          snapshot.docs.map((e) => TeacherModel.fromMap(e.data())).toList();
          
    } catch (e) {
      showToast(msg: "Teacher Data Error");
    }
  }
  List<AdminModel> searchAdmin = [];
  Future<void> fetchAdmin() async {
    searchAdmin.clear();
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection("DrivingSchoolCollection")
              .doc(UserCredentialsController.schoolId)
             // .collection("Admins")
              .get();
     // searchAdmin = snapshot.docs.map((e) => AdminModel.fromMap(e.data())).toList();
          if (snapshot.exists) {
      final adminData = snapshot.data();
      if (adminData != null) {
        searchAdmin.add(AdminModel.fromMap(adminData));
      }
    } else {
      showToast(msg: "Admin document not found");
    }    
    } catch (e) {
      showToast(msg: "Admin Data Error");
    }
  }
 List<AddAdminModel> searchAdminAdd = [];
  Future<void> fetchAdminAdd() async {
    searchAdminAdd.clear();
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection("DrivingSchoolCollection")
              .doc(UserCredentialsController.schoolId)
              .collection("Admins")
              .get();
      searchAdminAdd =
          snapshot.docs.map((e) => AddAdminModel.fromMap(e.data())).toList();
          
    } catch (e) {
      showToast(msg: "Add Admin Data Error");
    }
  }
  @override
  void onInit() async {
    await fetchAdmin();
   await fetchAdminAdd();
    super.onInit();
  }
}

  // sentMessageBYTeacher(String teacherId, int usercurrentIndex,
  //     int studentchatCounterIndex) async {
  //   var countPlusone = await FirebaseFirestore.instance
  //       .collection('DrivingSchoolCollection')
  //       .doc(UserCredentialsController.schoolId)
  //       .collection("Teachers")
  //       .doc(teacherId)
  //       .collection('StudentChatCounter')
  //       .doc('F0Ikn1UouYIkqmRFKIpg')
  //       .get();

  //   int sentStudentChatIndex = (countPlusone.data()?['chatIndex'] ?? 0) + 1;
  //   int sentIindex = usercurrentIndex + 1;
  //   log('usercurrentIndex  $usercurrentIndex');
  //   // log("Student id${FirebaseAuth.instance.currentUser!.uid}");
  //   final id = uuid.v1();
  //      final userDetails = SendUserStatusModel(
  //       block: false,
  //       docid: FirebaseAuth.instance.currentUser!.uid,
  //       messageindex: await fectchingTeacherCurrentMessageIndex(teacherId),
  //       senderName: UserCredentialsController.studentModel?.studentName??"");
  //   final sendMessage = OnlineChatModel(
  //     message: messageController.text,
  //     messageindex: 1,
  //     chatid: FirebaseAuth.instance.currentUser!.uid,
  //     docid: id,
  //     sendTime: DateTime.now().toString(),
  //   );
  //   await FirebaseFirestore.instance
  //       .collection('DrivingSchoolCollection')
  //       .doc(UserCredentialsController.schoolId)
  //       .collection('Students')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection('TeacherChats')
  //       .doc(teacherId)
  //       .collection('messages')
  //       .doc(id)
  //       .set(sendMessage.toMap())
  //       .then((value) async {
  //     await FirebaseFirestore.instance
  //         .collection('DrivingSchoolCollection')
  //         .doc(UserCredentialsController.schoolId)
  //         .collection("Teachers")
  //         .doc(teacherId)
  //         .collection('StudentChats')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //      //  .set(userDetails.toMap(), SetOptions(merge: true))
  //         .collection('messages')
  //         .doc(id)
  //         .set(sendMessage.toMap())
  //         .then((value) async {

  //       await FirebaseFirestore.instance
  //           .collection('DrivingSchoolCollection')
  //           .doc(UserCredentialsController.schoolId)
  //           .collection("Teachers")
  //           .doc(teacherId)
  //           .collection('StudentChats')
  //           .doc(FirebaseAuth.instance.currentUser!.uid)
  //           // .collection('messages')
  //           // .doc(id)
  //           // .set(sendMessage.toMap())
  //          .update({'messageindex': sentIindex})
  //           .then((value) async {
  //         await FirebaseFirestore.instance
  //             .collection('DrivingSchoolCollection')
  //             .doc(UserCredentialsController.schoolId)
  //             .collection("Teachers")
  //             .doc(teacherId)
  //             .collection('StudentChatCounter')
  //             .doc('F0Ikn1UouYIkqmRFKIpg')
  //             .update({'chatIndex': sentStudentChatIndex}).then(
  //                 (value) => messageController.clear());
  //       });
  //     });
  //   });
  // }