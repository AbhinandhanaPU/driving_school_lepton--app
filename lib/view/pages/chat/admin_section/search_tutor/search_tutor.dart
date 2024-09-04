import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/controller/admin_controller/teacher_admin_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/teacher_model/teacher_model.dart';
import 'package:new_project_app/view/pages/chat/admin_section/admin_tutor_message/chats_tr/admin_tutor_chats.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

// }
class SearcTeacherForChat extends SearchDelegate {
  AdminTeacherChatController teacherParentChatController =  Get.put(AdminTeacherChatController());

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.clear));
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection("Teachers")
            .snapshots(),
        builder: (context, snapshots) {
          var screenSize = MediaQuery.of(context).size;
          if (snapshots.hasData) {
            return Scaffold(
              body: ListView.separated(
                  itemBuilder: (context, index) {
                    TeacherModel data = TeacherModel.fromMap(
                        snapshots.data!.docs[index].data());
                    return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: screenSize.width / 8,
                        width: double.infinity,
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {},
                                child: const CircleAvatar(
                                  radius: 60,
                                )),
                            kHeight40,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.teacherName!,
                                    style: GoogleFonts.poppins(fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ));
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: snapshots.data!.docs.length),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<TeacherModel> buildSuggestionList;
    if (query.isEmpty) {
      buildSuggestionList = teacherParentChatController.searchTeacher;
    } else {
      buildSuggestionList = teacherParentChatController.searchTeacher
          .where((item) =>
              item.teacherName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    if (buildSuggestionList.isEmpty) {
      return ListTile(
        title: TextFontWidget(text: "Result not Found", fontsize: 18),
      );
    } else {
      return Scaffold(
        body: ListView.separated(
            itemBuilder: (context, index) {
              final screenSize = MediaQuery.of(context).size;

              return GestureDetector(
                onTap: () {
                  final data = buildSuggestionList[index];
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return AdminToTeachersChatsScreen(
                          teacherDocID: data.docid!,
                          teacherName: data.teacherName!);
                    },
                  ));
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: screenSize.width / 8,
                    width: double.infinity,
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              // ignore: unused_local_variable
                              final data = buildSuggestionList[index];
                            },
                            child: const Icon(
                              Icons.person_sharp,
                              size: 30,
                            )),
                        kwidth40,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                buildSuggestionList[index].teacherName!,
                                style: GoogleFonts.poppins(fontSize: 16),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: buildSuggestionList.length),
      );
    }
  }
}
