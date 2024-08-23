import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/const/const.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/view/pages/chat/admin_section/parents_message/parents_messages.dart';
import 'package:new_project_app/view/pages/chat/student_section/admin_message/admin_messages.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';

import 'group_message/student_message_group_screen.dart';

class StudentChatScreen extends StatelessWidget {
  const StudentChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
   

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: cWhite,
          flexibleSpace: const AppBarColorWidget(),
          // backgroundColor: adminePrimayColor,
          title: Text('Chat'.tr),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: Icon(
                        Icons.group,
                        color: cWhite,
                      ),
                    ),
                    //////////////////////////////////////////////////////////////////////////////////////////////////
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Admins".tr),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('DrivingSchoolCollection')
                                .doc(UserCredentialsController.schoolId)
                                .collection('Students')
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .collection("AdminChatCounter")
                                .doc("c3cDX5ymHfITQ3AXcwSp")
                                .snapshots(),
                            builder: (context, messageIndex) {
                              if (messageIndex.hasData) {
                                if (messageIndex.data!.data() == null) {
                                  return const Text('');
                                } else {
                                  MessageCounter.adminMessageCounter =
                                      messageIndex.data?.data()?['chatIndex'];
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.white,
                                      child: Center(
                                        child: Text(
                                          messageIndex.data!
                                              .data()!['chatIndex'].toString(),
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
                            }),
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
                      child: Icon(
                        Icons.group,
                        color: cWhite,
                      ),
                    ),
                    //////////////////////////////////////////////////////////////////////////////////////////////////
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Tutor".tr),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('DrivingSchoolCollection')
                                .doc(UserCredentialsController.schoolId)
                                .collection('Students')
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .collection("TutorChatCounter")
                                .doc("c3cDX5ymHfITQ3AXcwSp")
                                .snapshots(),
                            builder: (context, messageIndex) {
                              if (messageIndex.hasData) {
                                if (messageIndex.data!.data() == null) {
                                  return const Text('');
                                } else {
                                  MessageCounter.tutorMessageCounter =
                                      messageIndex.data?.data()?['chatIndex'];
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.white,
                                      child: Center(
                                        child: Text(
                                          messageIndex.data!
                                              .data()!['chatIndex'].toString(),
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
                            }),
                      ],
                    )
                  ],
                ),
              ),
              // const Tab(icon: Icon(Icons.groups_2), text: 'Parents'),
              Tab(
                icon: const Icon(
                  Icons.class_,
                  color: cWhite,
                ),
                text: 'Group'.tr,
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AdminMessagesScreen(),
            StudentToTutorMessagesScreen(),
            // const Icon(Icons.directions_transit, size: 350),
            StudentsGroupMessagesScreen(),
          ],
        ),
        // floatingActionButton: CircleAvatar(
        //   backgroundColor: adminePrimayColor,
        //   radius: 25,
        //   child: Center(
        //     child: IconButton(
        //         onPressed: () async {
        //           await showsearch();
        //         },
        //         icon: const Icon(
        //           Icons.search_rounded,
        //           color: Colors.white,
        //         )),
        //   ),
        // ),
      ),
    );
  }
}
