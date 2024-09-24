import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/const/const.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/controller/chat_controller/student_controller/student_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';

class AdminsChatsScreen extends StatefulWidget {
 final String adminDocID;
 final String adminName;

  const AdminsChatsScreen(
      {required this.adminDocID, 
      required this.adminName, super.key});

  @override
  State<AdminsChatsScreen> createState() => _AdminsChatsScreenState();
}

class _AdminsChatsScreenState extends State<AdminsChatsScreen> {
  final studentChatController = Get.put(StudentChatController());

  int currentStudentMessageIndex = 0;
  int currentStudentMessageIndex2 = 0;
  int adminIndex = 0;

  @override
  void initState() {
    fectingAdminChatStatus();
    connectingStudentToadmin();
    connectingCurrentStudentToadmin();
    getStudentAdminChatIndex();
    getCurrentAdminMessageIndex().then((value) => resetUserMessageIndex());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('adminName >>>>  ${widget.adminName}');
    log("getStudentAdminChatIndex().toString()$adminIndex");
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 242, 224),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(),
            kWidth10,
            Text(widget.adminName),
          ],
        ),
        backgroundColor: adminePrimayColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 1.20,
              width: size.width,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('DrivingSchoolCollection')
                      .doc(UserCredentialsController.schoolId)
                      .collection('Students')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('AdminChats')
                      .doc(widget.adminDocID)
                      .collection('messages')
                      .orderBy('sendTime', descending: true)
                      .snapshots(),
                  builder: (context, snaps) {
                    if (snaps.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        controller: ScrollController(),
                        reverse: true,
                        itemCount: snaps.data!.docs.length,
                        itemBuilder: (context, index) {
                          ///////////////////////////////////
                          return studentChatController.messageTitles(
                              widget.adminDocID,
                              size,
                              snaps.data!.docs[index]['chatid'],
                              snaps.data!.docs[index]['message'],
                              snaps.data!.docs[index]['docid'],
                              snaps.data!.docs[index]['sendTime'],
                              context);
                          ///////////////////////////////
                        },
                      );
                    } else {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    }
                  }),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('DrivingSchoolCollection')
                    .doc(UserCredentialsController.schoolId)
                    .collection('Admins')
                    .doc(widget.adminDocID)
                    .collection('StudentChats')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .snapshots(),
                builder: (context, checkingblock) {
                  if (checkingblock.hasData) {
                    if (checkingblock.data?.data()?['block'] == true) {
                      return GestureDetector(
                        onTap: () async {},
                        child: SizedBox(
                          height: size.height / 15,
                          width: size.width,
                          child: const Column(
                            children: [
                              Text('You are Blocked '),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: size.height / 15,
                        width: size.width,
                        // alignment: Alignment.center,
                        child: SizedBox(
                          height: size.height / 12,
                          width: size.width / 1.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: size.height / 17,
                                width: size.width / 1.3,
                                child: TextField(
                                  controller:
                                      studentChatController.messageController,
                                  decoration: InputDecoration(
                                      hintText: "Send Message",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      )),
                                ),
                              ),
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: adminePrimayColor,
                                child: Center(
                                  child: IconButton(
                                      icon: const Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      ),
                                      onPressed: () async {
                                         log('adminName >>>>  ${widget.adminName}');
                                        log('adminName >>>>  ${widget.adminDocID}');
                                        ///////////////////////////
                                        ///
                                       String messageText = studentChatController.messageController.text.trim();
                                       if (messageText.isNotEmpty) {
                                        studentChatController.sentMessage(
                                          widget.adminDocID,
                                          await getCurrentAdminMessageIndex(),
                                          await getTutorChatCounterIndex(),
                                        );
                                       }
                                        /////////////////////////adcbef
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  } else if (checkingblock.data?.data() == null) {
                    return const Text("data");
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Future<int> getStudentAdminChatIndex() async {
    var vari = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Students')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('AdminChats')
        .doc(widget.adminDocID)
        .get();
    adminIndex = vari.data()?['messageindex'] ?? 0;
    // log("message>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${vari.data()?['messageindex']}");
    if (adminIndex < 0) {
      return 0;
    } else {
      return adminIndex;
    }
  }

  Future<int> getCurrentAdminMessageIndex() async {
    var vari = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Admins')
        .doc(widget.adminDocID)
        .collection('StudentChats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    currentStudentMessageIndex = vari.data()?['messageindex'] ?? 0;

    log("currentStudentMessageIndex.toString()${currentStudentMessageIndex.toString()}");
    if (currentStudentMessageIndex == 0) {
      return 0;
    } else {
      return currentStudentMessageIndex;
    }
  }

  resetUserMessageIndex() async {
    int zero = 0;
    final int messageIndexNotify = MessageCounter.adminMessageCounter -
        await getStudentAdminChatIndex();
    MessageCounter.adminMessageCounter = messageIndexNotify;

    log("StudentCounter${MessageCounter.adminMessageCounter}");
    log("StudentIndex $currentStudentMessageIndex");
    log("messageIndexNotify $messageIndexNotify");
    await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Students')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('AdminChatCounter')
        .doc('c3cDX5ymHfITQ3AXcwSp')
        .update({
      'chatIndex': messageIndexNotify == 0 ? zero : messageIndexNotify
    }).then((value) async {
      await FirebaseFirestore.instance
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('AdminChats')
          .doc(widget.adminDocID)
          .update({'messageindex': 0});
    });
  }

  Future<int> getTutorChatCounterIndex() async {
    var vari = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Students')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('AdminChatCounter')
        .doc('F0Ikn1UouYIkqmRFKIpg')
        .get();
    return currentStudentMessageIndex2 = vari.data()?['chatIndex'] ?? 0;
  }

  Future connectingCurrentStudentToadmin() async {
    final checkuser = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Admins')
        .doc(widget.adminDocID)
        .collection('StudentChats')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (checkuser.data() == null) {
      await FirebaseFirestore.instance
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Admins')
          .doc(widget.adminDocID)
          .collection('StudentChats')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'block': false,
        'docid': FirebaseAuth.instance.currentUser?.uid,
        'messageindex': 0,
         'studentname': UserCredentialsController.studentModel?.studentName,
      }).then((value) async {
        await FirebaseFirestore.instance
             .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Students')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('AdminChats')
            .doc(widget.adminDocID)
            .set({
          'block': false,
          'docid': widget.adminDocID,
          'messageindex': 0,
          'adminName': widget.adminName,
        });
      });
    }
  }

  Future connectingStudentToadmin() async {
    final checkuser = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Admins')
        .doc(widget.adminDocID)
        .collection('StudentChats')
        .get();
    if (checkuser.docs.isEmpty) {
      await FirebaseFirestore.instance
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Admins')
          .doc(widget.adminDocID)
          .collection('StudentChats')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'block': false,
        'docid': FirebaseAuth.instance.currentUser?.uid,
        'messageindex': 0,
        'studentname': UserCredentialsController.studentModel?.studentName,
      });
    }
  }

  Future fectingAdminChatStatus() async {
    final firebasecollection = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Admins')
        .doc(widget.adminDocID)
        .collection('StudentChatCounter')
        .get();

    if (firebasecollection.docs.isEmpty) {
      log('firebasecollection.docs.isEmpty');
      await FirebaseFirestore.instance
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Admins')
          .doc(widget.adminDocID)
          .collection('StudentChatCounter')
          .doc('F0Ikn1UouYIkqmRFKIpg')
          .set({'chatIndex': 0, 'docid': "F0Ikn1UouYIkqmRFKIpg"});
    } else {
      log('NMNnnnnnnnnnnnnnnnnnnnnnnn');
      return;
    }
  }
  // resetUserMessageIndex() async {
  //   final messageIndexNotify =
  //       widget.adminMessageCounter - currentStudentMessageIndex;
  //   await FirebaseFirestore.instance
  //       .collection('DrivingSchoolCollection')
  //       .doc(UserCredentialsController.schoolId)
  //       .collection('Admins')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection('StudentChatCounter')
  //       .doc('F0Ikn1UouYIkqmRFKIpg')
  //       .update({'chatIndex': messageIndexNotify}).then((value) async {
  //     await FirebaseFirestore.instance
  //         .collection('DrivingSchoolCollection')
  //         .doc(UserCredentialsController.schoolId)
  //         .collection('Admins')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection('StudentChats')
  //         .doc(widget.adminDocID)
  //         .update({'messageindex': 0});
  //   });
  // }
}
