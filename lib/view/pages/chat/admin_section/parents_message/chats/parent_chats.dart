import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/const/const.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/controller/admin_controller/teacher_admin_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';

class ParentsChatsScreen extends StatefulWidget {
  final String tutorDocID;
  final String teachername;

  const ParentsChatsScreen(
      {required this.tutorDocID, required this.teachername, super.key});

  @override
  State<ParentsChatsScreen> createState() => _ParentsChatsScreenState();
}

class _ParentsChatsScreenState extends State<ParentsChatsScreen> {
  final teacherParentChatController = Get.put(AdminTeacherChatController());

  int currentStudentMessageIndex = 0;
  @override
  void initState() {
    connectingCurrentParentToteacher();
    connectingTeacherToParent();
    fectingParentChatStatus();

    getCurrentParenttMessageIndex().then((value) => resetUserMessageIndex());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    log('teachername${widget.teachername}');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 242, 224),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(),
            kWidth10,
            Text(widget.teachername),
          ],
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () async {
                  log("PopUp Blocked button");
                  await FirebaseFirestore.instance
                      .collection('DrivingSchoolCollection')
                      .doc(UserCredentialsController.schoolId)
                      .collection("Admins")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('TeacherChats')
                      .doc(widget.tutorDocID)
                      .set({'block': true}, SetOptions(merge: true));
                },
                child: const Center(child: Text('Block')),
              ),
            ],
          )
        ],
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
                      .collection("Admins")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('TeacherChats')
                      .doc(widget.tutorDocID)
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
                          return teacherParentChatController.messageTitles(
                              widget.tutorDocID,
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
                      .collection("Admins")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('TeacherChats')
                    .doc(widget.tutorDocID)
                    .snapshots(),
                builder: (context, checkingblock) {
                  if (checkingblock.hasData) {
                    if (checkingblock.data?.data()?['block'] == true) {
                      return GestureDetector(
                        onTap: () async {
                          await teacherParentChatController.unBlockuser(
                              widget.tutorDocID, context);
                        },
                        child: SizedBox(
                          height: size.height / 15,
                          width: size.width,
                          child: const Column(
                            children: [
                              Text('You Blocked this user'),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Tap to unblock '),
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
                                  controller: teacherParentChatController
                                      .messageController,
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
                                        ///////////////////////////
                                           String messageText = teacherParentChatController.messageController.text.trim();
                        if (messageText.isNotEmpty) {
                          await teacherParentChatController.sentMessage(widget.tutorDocID, );
                          teacherParentChatController.messageController.clear();
                        } 
                                        // if (teacherParentChatController
                                        //         .messageController.text.trim() != "") {
                                        //   teacherParentChatController .sentMessage(widget.tutorDocID);
                                        // }
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

  Future<void> getCurrentParenttMessageIndex() async {
    var vari = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
         .collection("Admins")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('TeacherChats')
        .doc(widget.tutorDocID)
        .get();

    currentStudentMessageIndex = vari.data()?['messageindex'];
  }

  resetUserMessageIndex() async {
    int zero = 0;
    final int messageIndexNotify =
        MessageCounter.studentMessageCounter - currentStudentMessageIndex;
    MessageCounter.studentMessageCounter = messageIndexNotify;

    log("StudentCounter${MessageCounter.studentMessageCounter}");
    log("StudentIndex $currentStudentMessageIndex");
    log("messageIndexNotify $messageIndexNotify");
    await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection("Admins")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('TutorChatCounter')
        .doc('F0Ikn1UouYIkqmRFKIpg')
        .update({
      'chatIndex': messageIndexNotify == 0 ? zero : messageIndexNotify
    }).then((value) async {
      await FirebaseFirestore.instance
           .collection('DrivingSchoolCollection')
           .doc(UserCredentialsController.schoolId)
          .collection("Admins")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('TeacherChats')
          .doc(widget.tutorDocID)
          .update({'messageindex': 0});
    });
  }

  Future connectingCurrentParentToteacher() async {
    final checkuser = await FirebaseFirestore.instance
       .collection('DrivingSchoolCollection')
       .doc(UserCredentialsController.schoolId)
       .collection("Teachers")
        .doc(widget.tutorDocID)
        .collection('AdminChats')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (checkuser.data() == null) {
      await FirebaseFirestore.instance
         .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection("Teachers")
          .doc(widget.tutorDocID)
          .collection('AdminChats')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'block': false,
        'docid': FirebaseAuth.instance.currentUser?.uid,
        'messageindex': 0,
        'teachername': UserCredentialsController.teacherModel?.teacherName,
      }).then((value) async {
        await FirebaseFirestore.instance
            .collection('DrivingSchoolCollection')
           .doc(UserCredentialsController.schoolId)
           .collection("Admins")
           .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('TeacherChats')
            .doc(widget.tutorDocID)
            .set({
          'block': false,
          'docid': widget.tutorDocID,
          'messageindex': 0,
          'teachername': widget.teachername,
        });
      });
    }
  }

  Future connectingTeacherToParent() async {
    log("parent nulllllllllllllll caloinnnnnn ${widget.tutorDocID}");
    final checkuser = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
           .doc(UserCredentialsController.schoolId)
           .collection("Admins")
           .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('TeacherChats')
        .doc(widget.tutorDocID)
        .get();
    if (checkuser.data() == null) {
      log("parent nulllllllllllllll");
      await FirebaseFirestore.instance
         .collection('DrivingSchoolCollection')
           .doc(UserCredentialsController.schoolId)
           .collection("Admins")
           .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('TeacherChats')
          .doc(widget.tutorDocID)
          .set({
        'block': false,
        'docid': widget.tutorDocID,
        'messageindex': 0,
        'teachername': widget.teachername,
      });
    }
  }

  Future fectingParentChatStatus() async {
    final firebasecollection = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection("Teachers")
        .doc(widget.tutorDocID)
        .collection('AdminChatCounter')
        .get();

    if (firebasecollection.docs.isEmpty) {
      log('firebasecollection.docs.isEmpty');
      await FirebaseFirestore.instance
          .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection("Teachers")
          .doc(widget.tutorDocID)
          .collection('AdminChatCounter')
          .doc('c3cDX5ymHfITQ3AXcwSp')
          .set({'chatIndex': 0, 'docid': "c3cDX5ymHfITQ3AXcwSp"});
    } else {
      log('NMNnnnnnnnnnnnnnnnnnnnnnnn');
      return;
    }
  }
}
