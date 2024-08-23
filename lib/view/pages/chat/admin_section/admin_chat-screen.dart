import 'dart:developer';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/const/const.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/view/pages/chat/admin_section/student_message/students_messages.dart';
import 'package:new_project_app/view/pages/chat/student_section/tutor_msg/tutor_message/tutor_message.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';

import '../group_chats/group_chat.dart';

class AdminChatScreen extends StatelessWidget {
  const AdminChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log(DateTime.now().toString());
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: const AppBarColorWidget(),
          foregroundColor: cWhite,
          backgroundColor: adminePrimayColor,
          title: Text('chat'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: Icon(Icons.group),
                    ),
                    //////////////////////////////////////////////////////////////////////////////////////////////////
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Students",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('DrivingSchoolCollection')
                              .doc(UserCredentialsController.schoolId)
                              .collection("Admins")
                              .doc(UserCredentialsController.adminModel?.docid)
                              .collection('StudentChatCounter')
                              .doc('F0Ikn1UouYIkqmRFKIpg')
                              .snapshots(),
                          builder: (context, messageIndex) {
                            if (messageIndex.hasData) {
                              if (messageIndex.data!.data() == null) {
                                return const Text('');
                              } else if (messageIndex.data!.data()!['chatIndex'] <= 0) {
                                FirebaseFirestore.instance
                                    .collection('DrivingSchoolCollection')
                                    .doc(UserCredentialsController.schoolId)
                                    .collection("Admins")
                                    .doc(UserCredentialsController.adminModel?.docid)
                                    .collection('StudentChatCounter')
                                    .doc('F0Ikn1UouYIkqmRFKIpg')
                                    .update({'chatIndex': 0});
                                return CircleAvatar(
                                  radius: 10.sp,
                                  backgroundColor: Colors.white,
                                  child: Center(
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              } else {
                                MessageCounter.studentMessageCounter =
                                    messageIndex.data?.data()?['chatIndex'];
                                return Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.white,
                                    child: Center(
                                      child: Text(
                                        messageIndex.data!.data()!['chatIndex'].toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Tab(
                icon: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: Icon(Icons.group),
                    ),
                    //////////////////////////////////////////////////////////////////////////////////////////////////
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tutors",
                          style: TextStyle(fontSize: 17.sp),
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('DrivingSchoolCollection')
                              .doc(UserCredentialsController.schoolId)
                              .collection("Admins")
                              .doc(UserCredentialsController.adminModel?.docid)
                              .collection('TeacherChatCounter')
                              .doc('F0Ikn1UouYIkqmRFKIpg')
                              .snapshots(),
                          builder: (context, messageIndex) {
                            if (messageIndex.hasData) {
                              if (messageIndex.data!.data() == null) {
                                return const Text('');
                              } else if (messageIndex.data!.data()!['chatIndex'] <= 0) {
                                FirebaseFirestore.instance
                                    .collection('DrivingSchoolCollection')
                                    .doc(UserCredentialsController.schoolId)
                                    .collection("Admins")
                                    .doc(UserCredentialsController.adminModel?.docid)
                                    .collection('TeacherChatCounter')
                                    .doc('F0Ikn1UouYIkqmRFKIpg')
                                    .update({'chatIndex': 0});
                                return const CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.white,
                                  child: Center(
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              } else {
                                MessageCounter.tutorMessageCounter =
                                    messageIndex.data?.data()?['chatIndex'];
                                return Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: CircleAvatar(
                                    radius: 10.sp,
                                    backgroundColor: Colors.white,
                                    child: Center(
                                      child: Text(
                                        messageIndex.data!.data()!['chatIndex'].toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Tab(
                  icon: const Icon(
                    Icons.class_,
                  ),
                  text: 'Group'.tr),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const StudentsMessagesScreen(),
              const TeachersMessagesScreen(),
            GroupChatScreenForAdmin(),
          ],
        ),
      ),
    );
  }
}
