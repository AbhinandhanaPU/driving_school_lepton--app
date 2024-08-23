import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/view/pages/chat/student_section/search/search_teachers.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

import 'chats/admin_chats.dart';

class AdminMessagesScreen extends StatelessWidget {
  const AdminMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
     Future<void> showsearch() async {
      await showSearch(context: context, delegate: SearchAdmin());
    }
      final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Students')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("AdminChats")
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return ListView(
              children: [
                SizedBox(
                      height: size.height * 0.72,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 70,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return AdminsChatsScreen(
                                    adminName: snapshots.data!.docs[index]
                                        ['adminName'],
                                    adminDocID: snapshots.data!.docs[index]
                                        ['docid'],
                                  );
                              },));
                              // Get.off(() => AdminsChatsScreen(
                              //       teacherName: snapshots.data!.docs[index]
                              //           ['teacherName'],
                              //       teacherDocID: snapshots.data!.docs[index]
                              //           ['docid'],
                              //     ));
                            },
                            leading: const CircleAvatar(
                              radius: 30,
                            ),
                            title: Text(snapshots.data?.docs[index]['adminName'],
                                style: const TextStyle(color: Colors.black)),
                            contentPadding: const EdgeInsetsDirectional.all(1),
                            subtitle: const Text(
                              'Admin',
                              style: TextStyle(color: Colors.black),
                            ),
                            trailing: snapshots.data!.docs[index]['messageindex'] == 0
                                ? const Text('')
                                : Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor:
                                          const Color.fromARGB(255, 118, 229, 121),
                                      child: Text(
                                        snapshots.data!.docs[index]['messageindex']
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: snapshots.data!.docs.length),
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.sp),
                      child: GestureDetector(
                        onTap: () {
                          showsearch();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.sp)),
                              color: const Color.fromARGB(255, 232, 224, 224)),
                          height: 50.h,
                          width: 200.w,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(Icons.search),
                                Padding(
                                  padding: EdgeInsets.only(right: 10.sp),
                                  child: TextFontWidget(
                                    text: 'Search Admin'.tr,
                                    fontsize: 15.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        });
  }
}
