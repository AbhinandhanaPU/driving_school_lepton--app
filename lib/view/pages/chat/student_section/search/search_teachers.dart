import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/controller/chat_controller/student_controller/student_controller.dart';
import 'package:new_project_app/controller/chat_controller/tutor_controller/tutor_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/admin_model/admin_model.dart';
import 'package:new_project_app/model/admin_model/data_base_model_ad.dart';
import 'package:new_project_app/view/pages/chat/student_section/admin_message/chats/admin_chats.dart';
import 'package:new_project_app/view/pages/chat/tutor_section/teacher_messages/chats/admin_vs_tutor.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class SearchAdmin extends SearchDelegate {
  StudentChatController studentChatController =
      Get.put(StudentChatController());

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back));
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
                    var docData = snapshots.data!.docs[index].data();
                    dynamic data;

                    if (docData.containsKey('adminName')) {
                      data = AdminModel.fromMap(docData);
                    } else if (docData.containsKey('username')) {
                      data = AddAdminModel.fromMap(docData);
                    }
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
                                    data is AdminModel
                                        ? data.adminName
                                        : (data is AddAdminModel? data.username : ''),
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
    final List<dynamic> buildSuggestionList; 
    List<dynamic> combinedList = [
      ...studentChatController.searchAdmin,
      ...studentChatController.searchAdminAdd,
    ];

    if (query.isEmpty) {
      buildSuggestionList = combinedList;
    } else {
      buildSuggestionList = combinedList
          .where((item) =>
              (item is AdminModel &&
                  item.adminName.toLowerCase().contains(query.toLowerCase())) ||
              (item is AddAdminModel &&
                  item.username.toLowerCase().contains(query.toLowerCase())))
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
            final item = buildSuggestionList[index];

            return GestureDetector(
              onTap: () {
                // Handle navigation based on the item type
                if (item is AdminModel) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AdminsChatsScreen(
                      adminDocID: item.docid,
                      adminName: item.adminName,
                    );
                  }));
                } else if (item is AddAdminModel) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AdminsChatsScreen(
                      adminDocID: item.docid,
                      adminName: item.username,
                    );
                  }));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: screenSize.width / 8,
                width: double.infinity,
                child: Row(
                  children: [
                    const Icon(
                      Icons.person_sharp,
                      size: 30,
                    ),
                    kwidth40,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item is AdminModel
                            ? item.adminName
                            : (item is AddAdminModel ? item.username : ""),
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: buildSuggestionList.length,
        ),
      );
    }
    
    //
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
class SearchAdminForTutor extends SearchDelegate {
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
                     var docData = snapshots.data!.docs[index].data();
                    dynamic data;

                    if (docData.containsKey('adminName')) {
                      data = AdminModel.fromMap(docData);
                    } else if (docData.containsKey('username')) {
                      data = AddAdminModel.fromMap(docData);
                    }
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
                                      data is AdminModel
                                        ? data.adminName
                                        : (data is AddAdminModel? data.username : ''),
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
     final List<dynamic> buildSuggestionList; 
    List<dynamic> combinedList = [
      ...tutorChatController.searchTeacher,
      ...tutorChatController.searchAdminAdd,
    ];
   // final List<AdminModel> buildSuggestionList;
    if (query.isEmpty) {
      buildSuggestionList = combinedList;
    } else {
      // Filter the combined list based on the query
      buildSuggestionList = combinedList
          .where((item) =>
              (item is AdminModel &&
                  item.adminName.toLowerCase().contains(query.toLowerCase())) ||
              (item is AddAdminModel &&
                  item.username.toLowerCase().contains(query.toLowerCase())))
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
            final item = buildSuggestionList[index];

            return GestureDetector(
              onTap: () {
                   close(context, null);
              Future.delayed(Duration.zero, () {
                if (item is AdminModel) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TutorAdminChatsScreen(
                      adminDocID: item.docid,
                      adminName: item.adminName,
                    );
                  }));
                } else if (item is AddAdminModel) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TutorAdminChatsScreen(
                      adminDocID: item.docid,
                      adminName: item.username,
                    );
                  }));
                }
              });
            },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: screenSize.width / 8,
                width: double.infinity,
                child: Row(
                  children: [
                    const Icon(
                      Icons.person_sharp,
                      size: 30,
                    ),
                    kwidth40,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item is AdminModel
                            ? item.adminName
                            : (item is AddAdminModel ? item.username : ""),
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: buildSuggestionList.length,
        ),
      );
    }
  }
}
