import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/const/const.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/controller/chat_controller/tutor_controller/tutor_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';

class TutorStdChatsScreen extends StatefulWidget {
  final String stdDocID;
  final String stdName;

  const TutorStdChatsScreen(
      {required this.stdDocID, required this.stdName, super.key});

  @override
  State<TutorStdChatsScreen> createState() => Parent_TeachersChatsScreenState();
}

class Parent_TeachersChatsScreenState extends State<TutorStdChatsScreen> {
  final tutorChatController = Get.put(TutorChatController());

  int currentStudentMessageIndex = 0;
  int currentStudentMessageIndex2 = 0;
  int teacherIndex = 0;

  @override
  void initState() {
    fectingTeacherChatStatus();
    connectingParentToteacher();
    connectingCurrentParentToteacher();
    getParentTeacherChatIndex();
    getCurrentTeacherMessageIndex().then((value) => resetUserMessageIndex());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("---------------------------------");
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 242, 224),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(),
            kWidth10,
            Text(widget.stdName),
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
                      .collection('Teachers')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('StudentChats')
                      .doc(widget.stdDocID)
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
                          return tutorChatController.messageTitles(
                              widget.stdDocID,size,
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
                    .collection('Students')
                    .doc(widget.stdDocID)
                    .collection('TeacherChats')
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
                              SizedBox(height: 10, ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: size.height / 15,
                        width: size.width,
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
                                  controller: tutorChatController.messageController,
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
                                        log('stdName >>>>  ${widget.stdDocID}');
                                        ///////////////////////////
                                        tutorChatController.sentMessagesToStd(
                                          widget.stdDocID,
                                          await getCurrentTeacherMessageIndex(),
                                          await getTutorChatCounterIndex(),
                                          //await connectingParentToteacher(),
                                        );
                                        /////////////////////////
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

  Future<int> getParentTeacherChatIndex() async {
    var vari = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Teachers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('StudentChats')
        .doc(widget.stdDocID)
        .get();
    teacherIndex = vari.data()?['messageindex'] ?? 0;
    // log("message>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${vari.data()?['messageindex']}");
    if (teacherIndex < 0) {
      return 0;
    } else {
      return teacherIndex;
    }
  }

  Future<int> getCurrentTeacherMessageIndex() async {
    var vari = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Students')
        .doc(widget.stdDocID)
        .collection('TeacherChats')
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
    final int messageIndexNotify =MessageCounter.tutorMessageCounter - await getParentTeacherChatIndex();
    MessageCounter.tutorMessageCounter = messageIndexNotify;

    log("StudentCounter${MessageCounter.tutorMessageCounter}");
    log("StudentIndex $currentStudentMessageIndex");
    log("messageIndexNotify $messageIndexNotify");
    await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Teachers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('StudentChatCounter')
        .doc('c3cDX5ymHfITQ3AXcwSp')
        .update({
      'chatIndex': messageIndexNotify == 0 ? zero : messageIndexNotify
    }).then((value) async {
      await FirebaseFirestore.instance
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Teachers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('StudentChats')
          .doc(widget.stdDocID)
          .update({'messageindex': 0});
    });
  }

  Future<int> getTutorChatCounterIndex() async {
    var vari = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Teachers')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('StudentChatCounter')
        .doc('c3cDX5ymHfITQ3AXcwSp')
        .get();
    return currentStudentMessageIndex2 = vari.data()?['chatIndex'] ?? 0;
  }

  Future connectingCurrentParentToteacher() async {
    final checkuser = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Students')
        .doc(widget.stdDocID)
        .collection('TeacherChats')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (checkuser.data() == null) {
      await FirebaseFirestore.instance
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .doc(widget.stdDocID)
          .collection('TeacherChats')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'block': false,
        'docid': FirebaseAuth.instance.currentUser?.uid,
        'messageindex': 0,
        'teachername': UserCredentialsController.teacherModel?.teacherName ?? "",///ppppprnt
      });
    }
  }

  Future connectingParentToteacher() async {
    final checkuser = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Students')
        .doc(widget.stdDocID)
        .collection('TeacherChats')
        .get();
    if (checkuser.docs.isEmpty) {
      await FirebaseFirestore.instance
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .doc(widget.stdDocID)
          .collection('TeacherChats')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'block': false,
        'docid': FirebaseAuth.instance.currentUser?.uid,
        'messageindex': 0,
        'teachername': UserCredentialsController.teacherModel?.teacherName ?? "", ///ppprnt
      }).then((value) async {
        await FirebaseFirestore.instance
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Teachers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('StudentChats')
            .doc(widget.stdDocID)
            .set({
          'block': false,
          'docid': widget.stdDocID,
          'messageindex': 0,
          'studentname': widget.stdName,
        });
      });
    }
  }

  Future fectingTeacherChatStatus() async {
    final firebasecollection = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Students')
        .doc(widget.stdDocID)
        .collection('TutorChatCounter')
        .get();

    if (firebasecollection.docs.isEmpty) {
      log('firebasecollection.docs.isEmpty');
      await FirebaseFirestore.instance
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .doc(widget.stdDocID)
          .collection('TutorChatCounter')
          .doc('F0Ikn1UouYIkqmRFKIpg')
          .set({'chatIndex': 0, 'docid': "F0Ikn1UouYIkqmRFKIpg"});
    } else {
      log('NMNnnnnnnnnnnnnnnnnnnnnnnn');
      return;
    }
  }
  // resetUserMessageIndex() async {  
  //   final messageIndexNotify =
  //       widget.tutorMessageCounter - currentStudentMessageIndex;
  //   await FirebaseFirestore.instance
  //       .collection('SchoolListCollection')
  //       .doc(UserCredentialsController.schoolId)
  //       .collection('Teachers')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection('ParentChatCounter')
  //       .doc('F0Ikn1UouYIkqmRFKIpg')
  //       .update({'chatIndex': messageIndexNotify}).then((value) async {
  //     await FirebaseFirestore.instance
  //         .collection('SchoolListCollection')
  //         .doc(UserCredentialsController.schoolId)
  //         .collection('Teachers')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection('ParentChats')
  //         .doc(widget.stdDocID)
  //         .update({'messageindex': 0});
  //   });
  // }
}
