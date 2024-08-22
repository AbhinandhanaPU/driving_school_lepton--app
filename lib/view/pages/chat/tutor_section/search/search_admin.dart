import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/controller/chat_controller/tutor_controller/tutor_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/admin_model/admin_model.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

import '../teacher_messages/chats/admin_vs_tutor.dart';

class SearchTeachersForParents extends SearchDelegate {
  TutorChatController tutorChatController = Get.put(TutorChatController());

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
            .collection("DrivingSchoolCollection")
            .doc(UserCredentialsController.schoolId)
            .collection("Admins")
            .snapshots(),
        builder: (context, snapshots) {
          var screenSize = MediaQuery.of(context).size;
          if (snapshots.hasData) {
            return Scaffold(
              // backgroundColor: Colors.transparent,
              body: ListView.separated(
                  itemBuilder: (context, index) {
                    AdminModel data =
                        AdminModel.fromMap(snapshots.data!.docs[index].data());
                    return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(color: Colors.grey,width: 0.5),
                        ),
                        height: screenSize.width / 8,
                        width: double.infinity,
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  // log(data.profileImageUrl ?? "");
                                  // _showlert(context, data);
                                },
                                child: const CircleAvatar(
                                  radius: 60,
                                )),
                            kHeight40,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(snapshots.data!.docs[index]['id']),
                                  Text(
                                    data.adminName,
                                    style: GoogleFonts.poppins(fontSize: 16),
                                  ),
                                  // sizedBoxH10,
                                  // Text(
                                  //   'Admission No. :${data.admissionNumber}',
                                  //   style: GoogleFonts.poppins(fontSize: 12),
                                  // ),
                                  // sizedBoxH10,

                                  // Text(
                                  //   'Class & Division : ${data.classID}',
                                  //   style: GoogleFonts.poppins(fontSize: 12),
                                  // ),
                                  // sizedBoxH10,
                                  // Text(
                                  //   'Phone No :${data.guardianID}',
                                  //   style: GoogleFonts.poppins(fontSize: 12),
                                  // ),
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
    final List<AdminModel> buildSuggestionList;
    if (query.isEmpty) {
      buildSuggestionList = tutorChatController.searchTeacher;
    } else {
      buildSuggestionList = tutorChatController.searchTeacher
          .where((item) =>
              item.adminName.toLowerCase().contains(query.toLowerCase()))
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
                      return TutorAdminChatsScreen(
                          adminDocID: data.docid, adminName: data.adminName);
                    },
                  ));
                  // Get.off(ParentTeachersChatsScreen(
                  //     teacherDocID: data.docid!,
                  //     teacherName: data.teacherName!));
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

                              // _showlert(context, data);
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
                              // Text(snapshots.data!.docs[index]['id']),
                              Text(
                                buildSuggestionList[index].adminName,
                                style: GoogleFonts.poppins(fontSize: 16),
                              ),
                              // sizedBoxH10,
                              // Text(
                              //   'Admission No. :${buildSuggestionList[index].admissionNumber}',
                              //   style: GoogleFonts.poppins(fontSize: 12),
                              // ),
                              // sizedBoxH10,

                              // Text(
                              //   'Class & Division : ${buildSuggestionList[index].classID}',
                              //   style: GoogleFonts.poppins(fontSize: 12),
                              // ),
                              // sizedBoxH10,
                              // Text(
                              //   'Phone No :${buildSuggestionList[index].guardianID}',
                              //   style: GoogleFonts.poppins(fontSize: 12),
                              // ),
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

// void _showlert(BuildContext context, TeacherModel data) {
//   showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) => Student_Details_AlertBox_Widget(
//             studentID: data.docid ?? "",
//             studentImage: data.profileImageUrl ?? "",
//             teacherName: data.teacherName ?? "",
//             studentClass: data.classID ?? "",
//             admissionNumber: data.admissionNumber ?? "",
//             studentGender: data.gender ?? "",
//             bloodGroup: data.bloodgroup ?? "",
//             studentEmail: data.studentemail ?? "",
//             houseName: data.houseName ?? "",
//             place: data.place ?? "",
//             district: data.district ?? "",
//           ));
// }