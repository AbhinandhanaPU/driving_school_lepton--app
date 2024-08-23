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

class StudentChatsScreen extends StatefulWidget {
 final String studentDocID;
 final String StudentName;

  const StudentChatsScreen(
      {required this.studentDocID, required this.StudentName, super.key});

  @override
  State<StudentChatsScreen> createState() => _StudentChatsScreenState();
}

class _StudentChatsScreenState extends State<StudentChatsScreen> {
  final studentChatController = Get.put(StudentChatController());

  int currentStudentMessageIndex = 0;
  int currentStudentMessageIndex2 = 0;
  int studentIndex = 0;

  @override
  void initState() {
    fectinStudentChatStatus();
    // connectingTeacherToStudent();
    // connectingCurrentTeacherToStudent();
    getTeacherStudentChatIndex();
    getCurrentStudentMessageIndex().then((value) => resetUserMessageIndexstd());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("getTeacherStudentChatIndex().toString()$studentIndex");
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 242, 224),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(),
            kWidth10,
            Text(widget.StudentName),
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
                      .collection('TeacherChats')
                      .doc(widget.studentDocID)
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
                              widget.studentDocID,
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
                    .collection('Students')
                    .doc(widget.studentDocID)
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
                                        log('StudentName >>>>  ${widget.studentDocID}');
                                        ///////////////////////////
                                        ///abcde
                                       String messageText = studentChatController.messageController.text.trim();
                                       if (messageText.isNotEmpty) {
                                        studentChatController.sentMessageBYTeacher(
                                          widget.studentDocID,
                                          await getCurrentStudentMessageIndex(),
                                          await getTeacherChatCounterIndex(),
                                        );
                                       }
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

  Future<int> getTeacherStudentChatIndex() async {
    var vari = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Students')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('TeacherChats')
        .doc(widget.studentDocID)
        .get();
    studentIndex = vari.data()?['messageindex'] ?? 0;
    // log("message>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${vari.data()?['messageindex']}");
    if (studentIndex < 0) {
      return 0;
    } else {
      return studentIndex;
    }
  }

  Future<int> getCurrentStudentMessageIndex() async {
    var vari = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Students')
        .doc(widget.studentDocID)
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

  resetUserMessageIndexstd() async {
    int zero = 0;
    final int messageIndexNotify = MessageCounter.adminMessageCounter -
        await getTeacherStudentChatIndex();
    MessageCounter.adminMessageCounter = messageIndexNotify;

    log("StudentCounter${MessageCounter.adminMessageCounter}");
    log("StudentIndex $currentStudentMessageIndex");
    log("messageIndexNotify $messageIndexNotify");
    await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Students')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('StudentsChatCounter')
        .doc('c3cDX5ymHfITQ3AXcwSp')
        .update({
      'chatIndex': messageIndexNotify == 0 ? zero : messageIndexNotify
    }).then((value) async {
      await FirebaseFirestore.instance
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('StudentChats')
          .doc(widget.studentDocID)
          .update({'messageindex': 0});
    });
  }

  Future<int> getTeacherChatCounterIndex() async {
    var vari = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Students')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('StudentsChatCounter')
        .doc('c3cDX5ymHfITQ3AXcwSp')
        .get();
    return currentStudentMessageIndex2 = vari.data()?['chatIndex'] ?? 0;
  }

  // Future connectingCurrentTeacherToStudent() async {
  //   final checkuser = await FirebaseFirestore.instance
  //       .collection('DrivingSchoolCollection')
  //       .doc(UserCredentialsController.schoolId)
  //       .collection('Students')
  //       .doc(widget.studentDocID)
  //       .collection('TeacherChats')
  //       .doc(FirebaseAuth.instance.currentUser?.uid)
  //       .get();
  //   if (checkuser.data() == null) {
  //     await FirebaseFirestore.instance
  //         .collection('DrivingSchoolCollection')
  //         .doc(UserCredentialsController.schoolId)
  //         .collection('Students')
  //         .doc(widget.studentDocID)
  //         .collection('TeacherChats')
  //         .doc(FirebaseAuth.instance.currentUser?.uid)
  //         .set({
  //       'block': false,
  //       'docid': FirebaseAuth.instance.currentUser?.uid,
  //       'messageindex': 0,
  //       'teachername': UserCredentialsController.teacherModel?.teacherName,
  //     });
  //   }
  // }

  // Future connectingTeacherToStudent() async {
  //   final checkuser = await FirebaseFirestore.instance
  //       .collection('DrivingSchoolCollection')
  //       .doc(UserCredentialsController.schoolId)
  //       .collection('Students')
  //       .doc(widget.studentDocID)
  //       .collection('TeacherChats')
  //       .get();
  //   if (checkuser.docs.isEmpty) {
  //     await FirebaseFirestore.instance
  //         .collection('DrivingSchoolCollection')
  //         .doc(UserCredentialsController.schoolId)
  //         .collection('Students')
  //         .doc(widget.studentDocID)
  //         .collection('TeacherChats')
  //         .doc(FirebaseAuth.instance.currentUser?.uid)
  //         .set({
  //       'block': false,
  //       'docid': FirebaseAuth.instance.currentUser?.uid,
  //       'messageindex': 0,
  //       'teachername': UserCredentialsController.teacherModel?.teacherName,
  //     });
  //   }
  // }

  Future fectinStudentChatStatus() async {
    final firebasecollection = await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Students')
        .doc(widget.studentDocID)
        .collection('TutorChatCounter')
        .get();

    if (firebasecollection.docs.isEmpty) {
      log('firebasecollection.docs.isEmpty');
      await FirebaseFirestore.instance
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .doc(widget.studentDocID)
          .collection('TutorChatCounter')
          .doc('F0Ikn1UouYIkqmRFKIpg')
          .set({'chatIndex': 0, 'docid': "F0Ikn1UouYIkqmRFKIpg"});
    } else {
      log('NMNnnnnnnnnnnnnnnnnnnnnnnn');
      return;
    }
  }
}
