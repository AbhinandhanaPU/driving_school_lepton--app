import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/controller/student_controller/student_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

import '../search_students/search_students.dart';
import 'chats/admin_students_chats.dart';

class AdminToStudentsMessagesScreen extends StatelessWidget {
  AdminToStudentsMessagesScreen({super.key});

  final StudentController studentController = Get.put(StudentController());
  @override
  Widget build(BuildContext context) {
    Future<void> showsearch() async {
      await showSearch(context: context, delegate: SearchStudentsForChat());
    }

    final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection("Admins")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("StudentChats")
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return ListView(
              children: [
                SizedBox(
                  height: size.height * 0.72,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        final doc = snapshots.data!.docs[index];
                        final studentName =
                            doc.data().containsKey('studentname')
                                ? doc['studentname']: doc['senderName'];
                        return SizedBox(
                          height: 70.h,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return AdminToStudentsChatsScreen(
                                    studentName: studentName,
                                    studentDocID: snapshots.data!.docs[index] ['docid'],
                                  );
                                },
                              ));
                            },
                            leading: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: const CircleAvatar( radius: 30,),
                            ),
                            title: Text(studentName,
                                style: TextStyle( color: Colors.black, fontSize: 20.sp)),
                            contentPadding:const EdgeInsetsDirectional.all(1),
                            subtitle: StreamBuilder<List<String>>(
                              stream:studentController.fetchStudentsCourseChat(
                                      snapshots.data!.docs[index]['docid']),
                              builder: (context, snaps) {
                                if (snaps.connectionState ==ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (snaps.hasError) {
                                  return Text('Error: ${snaps.error}');
                                } else if (!snaps.hasData ||
                                    snaps.data!.isEmpty) {
                                  return TextFontWidget(
                                    text: "Course not found",
                                    fontsize: 15.h,
                                    fontWeight: FontWeight.bold,
                                    color: cblack,
                                  );
                                } else {
                                  String courses = snaps.data!.join(', \n');
                                  return TextFontWidget(
                                    text: courses,
                                    fontsize: 15.h,
                                    fontWeight: FontWeight.bold,
                                    color: themeColor,
                                  );
                                }
                              },
                            ),
                            // subtitle: const Text(
                            //   'Student',
                            //   style: TextStyle(color: Colors.black),
                            // ),
                            trailing: snapshots.data!.docs[index] ['messageindex'] ==0
                                ? const Text('')
                                : Padding(
                                    padding: const EdgeInsets.only(right: 20,),
                                    child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor: const Color.fromARGB(
                                          255, 118, 229, 121),
                                      child: Text( snapshots.data!.docs[index]['messageindex'].toString(),
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
                        return Column(
                          children: [
                            SizedBox(height: 4,),
                            const Divider(),
                          ],
                        );
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
                                    text: 'Search Student'.tr,
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
