import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';

import 'chats/admin_vs_tutor.dart';

// import 'chats/teachers_chats.dart';

class TutorAdminMessagesScreen extends StatelessWidget {
  const TutorAdminMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Teachers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("AdminChats")
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 70,
                    child: ListTile(
                      onTap: () {
 
Navigator.push(context,MaterialPageRoute(builder: (context) {
               return TutorAdminChatsScreen(
                              adminName: snapshots.data!.docs[index]
                                  ['adminName'],
                              adminDocID: snapshots.data!.docs[index]
                                  ['docid'],
                            );
    },));

                        // Get.off(() => ParentTeachersChatsScreen(
                        //       teacherName: snapshots.data!.docs[index]
                        //           ['teacherName'],
                        //       teacherDocID: snapshots.data!.docs[index]
                        //           ['docid'],
                        //     ));
                      },
                      leading: const CircleAvatar(
                        radius: 30,
                      ),
                      title: Text(snapshots.data!.docs[index]['adminName'],
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
                itemCount: snapshots.data!.docs.length);
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        });
  }
}
