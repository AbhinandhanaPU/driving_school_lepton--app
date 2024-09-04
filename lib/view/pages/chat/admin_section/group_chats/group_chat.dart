import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/controller/group_chat_controller/group_StudentsAdmin_chat_controller.dart';
import 'package:new_project_app/view/pages/chat/admin_section/group_chats/student_group/student_groups.dart';

class GroupChatScreenForAdmin extends StatelessWidget {
  final AdminGroupChatController teacherGroupChatController =
      Get.put(AdminGroupChatController());
  GroupChatScreenForAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('ChatGroups')
            .snapshots(),
        builder: (context, snaps) {
          if (snaps.hasData) {
            if (snaps.data!.docs.isEmpty) {
              return Center(
                child: TextButton.icon(
                    onPressed: () async {
                      createChatGroups(context, 'Students'.tr);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Create a group")),
              );
            } else {
              return Scaffold(
                // appBar: PreferredSize(
                //   preferredSize: const Size.fromHeight(50.0),
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 7, right: 7, top: 7),
                //     child: TabBar(
                //       // splashBorderRadius: BorderRadius.circular(0),
              
                //       // labelPadding:
                //       //     EdgeInsetsDirectional.symmetric(horizontal: 80.w),
                //       isScrollable: false,
                //       unselectedLabelColor: Colors.black,
                //       labelColor: Colors.white,
                //       indicator: BoxDecoration(
                //           borderRadius: BorderRadius.circular(20),
                //           color: adminePrimayColor),
                //       tabs: [
                //         Tab(
                //           text: 'Students'.tr,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                body: StudentsGroupsMessagesScreen(),
                floatingActionButton: StreamBuilder(
                    builder: (context, checkClassTeacher) {
                      if (checkClassTeacher.hasData) {
                        return FloatingActionButton(
                          child: const Icon(
                            Icons.add,
                          ),
                          onPressed: () async {
                          createChatGroups(context, 'Students'.tr);
                          },
                        );
                      } else {
                        return const Text('');
                      }
                    },
                    stream: FirebaseFirestore.instance
                        .collection('DrivingSchoolCollection')
                        .doc(UserCredentialsController.schoolId)
                        .snapshots()),
                // builder: (context, checkClassTeacher) {
              
                // }
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        });
  }
}

userIndexBecomeZero(String docid, String groupName,
    {required String adminParameter}) async {
  log("message Caliingggggggggggggggggggggggggg");
  final firebase = await FirebaseFirestore.instance
      .collection('DrivingSchoolCollection')
      .doc(UserCredentialsController.schoolId)
      
      .collection('ChatGroups')
      .doc('ChatGroups')
      .collection(groupName)
      .doc(docid)
      .collection('Participants')
      .get();
  if (firebase.docs.isNotEmpty) {
    addteacherTopaticipance(docid, groupName,
        adminParameter: adminParameter);
    await FirebaseFirestore.instance
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('ChatGroups')
        .doc('ChatGroups')
        .collection(groupName)
        .doc(docid)
        .collection('Participants')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({'messageIndex': 0}, SetOptions(merge: true));
  }
}
