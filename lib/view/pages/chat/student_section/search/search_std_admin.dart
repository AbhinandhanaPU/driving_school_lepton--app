// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:new_project_app/constant/sizes/sizes.dart';
// import 'package:new_project_app/controller/chat_controller/student_controller/student_controller.dart';
// import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
// import 'package:new_project_app/model/admin_model/admin_model.dart';
// import 'package:new_project_app/model/student_model/student_model.dart';
// import 'package:new_project_app/view/pages/chat/student_section/admin_message/chats/admin_chats.dart';
// import 'package:new_project_app/view/pages/chat/student_section/tutor_msg/std_chats.dart';
// import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

// class SearchAdminAndStudents extends SearchDelegate {
//   StudentChatController studentChatController =Get.put(StudentChatController());

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     IconButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         icon: const Icon(Icons.clear));
//     return null;
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         icon: const Icon(Icons.arrow_back));
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance
//               .collection("DrivingSchoolCollection")
//               .doc(UserCredentialsController.schoolId)
//               .collection("Admins")
//               .snapshots(),
//       builder: (context, adminSnapshots) {
//         return StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection("DrivingSchoolCollection")
//               .doc(UserCredentialsController.schoolId)
//               .collection("Students")
//               .snapshots(),
//           builder: (context, stdSnapshots) {
//             var screenSize = MediaQuery.of(context).size;
//             if (adminSnapshots.hasData && stdSnapshots.hasData) {
//                var combinedList = [
//                 ...adminSnapshots.data!.docs.map((doc) => AdminModel.fromMap(doc.data())),
//                 ...stdSnapshots.data!.docs.map((doc) => StudentModel.fromMap(doc.data()))
//               ];
//               return Scaffold(
//                 // backgroundColor: Colors.transparent,
//                 body: ListView.separated(
//                     itemBuilder: (context, index) {
//                        final data = combinedList[index];
//                       return Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           height: screenSize.width / 8,
//                           width: double.infinity,
//                           child: Row(
//                             children: [
//                               GestureDetector(
//                                   onTap: () {
//                                      if (data is AdminModel) {
//                                 Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                   return AdminsChatsScreen(
//                                     adminDocID: data.docid,
//                                     adminName: data.adminName,
//                                   );
//                                 }));
//                               } else if (data is StudentModel) {
//                                 Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                   return StudentChatsScreen(
//                                     studentDocID: data.docid,
//                                     StudentName: data.studentName,
//                                   );
//                                 }));
//                               }
//                             },
//                                   child: const CircleAvatar(
//                                     radius: 60,
//                                   )),
//                               kHeight40,
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     // Text(snapshots.data!.docs[index]['id']),
//                                     Text(
//                                          data is AdminModel ? data.adminName : data is StudentModel ?data.studentName: "",
//                                       style: GoogleFonts.poppins(fontSize: 16),
//                                     ),
//                                     // sizedBoxH10,
//                                     // Text(
//                                     //   'Admission No. :${data.admissionNumber}',
//                                     //   style: GoogleFonts.poppins(fontSize: 12),
//                                     // ),
//                                     // sizedBoxH10,
      
//                                     // Text(
//                                     //   'Class & Division : ${data.classID}',
//                                     //   style: GoogleFonts.poppins(fontSize: 12),
//                                     // ),
//                                     // sizedBoxH10,
//                                     // Text(
//                                     //   'Phone No :${data.guardianID}',
//                                     //   style: GoogleFonts.poppins(fontSize: 12),
//                                     // ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ));
//                     },
//                     separatorBuilder: (context, index) {
//                       return const Divider();
//                     },
//                     itemCount: combinedList.length,),
//               );
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator.adaptive(),
//               );
//             }
//           });
//   }
//     );

//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//       List<dynamic> buildSuggestionList = [];

//   if (query.isEmpty) {
//     buildSuggestionList = [
//       ...studentChatController.searchAdmin,
//       ...studentChatController.searchStudent,
//     ];
//   } else {
//     buildSuggestionList = [
//       ...studentChatController.searchAdmin
//           .where((item) => item.adminName.toLowerCase().contains(query.toLowerCase()))
//           .toList(),
//       ...studentChatController.searchStudent
//           .where((item) => item.studentName.toLowerCase().contains(query.toLowerCase()))
//           .toList(),
//     ];
//   }
//     if (buildSuggestionList.isEmpty) {
//       return ListTile(
//         title: TextFontWidget(text: "Result not Found", fontsize: 18),
//       );
//     } else {
//       return Scaffold(
//         body: ListView.separated(
//             itemBuilder: (context, index) {
//               final screenSize = MediaQuery.of(context).size;
//                final data = buildSuggestionList[index];

//               return GestureDetector(
//                 onTap: () {
//                   final data = buildSuggestionList[index];
//                    if (data is AdminModel) {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) {
//                   return AdminsChatsScreen(
//                     adminDocID: data.docid,
//                     adminName: data.adminName,
//                   );
//                 }));
//               } else if (data is StudentModel) {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) {
//                   return StudentChatsScreen(
//                     studentDocID: data.docid,
//                     StudentName: data.studentName,
//                   );
//                 }));
//               }
//             },
//                 child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     height: screenSize.width / 8,
//                     width: double.infinity,
//                     child: Row(
//                       children: [
//                         GestureDetector(
//                             onTap: () {
//                               // ignore: unused_local_variable
//                               final data = buildSuggestionList[index];

//                               // _showlert(context, data);
//                             },
//                             child: const Icon(
//                               Icons.person_sharp,
//                               size: 30,
//                             )),
//                         kwidth40,
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Text(snapshots.data!.docs[index]['id']),
//                               Text(
//                                  data is AdminModel ? data.adminName : data is StudentModel ?data.studentName  : "",
//                                 style: GoogleFonts.poppins(fontSize: 16),
//                               ),
//                               // sizedBoxH10,
//                               // Text(
//                               //   'Admission No. :${buildSuggestionList[index].admissionNumber}',
//                               //   style: GoogleFonts.poppins(fontSize: 12),
//                               // ),
//                               // sizedBoxH10,

//                               // Text(
//                               //   'Class & Division : ${buildSuggestionList[index].classID}',
//                               //   style: GoogleFonts.poppins(fontSize: 12),
//                               // ),
//                               // sizedBoxH10,
//                               // Text(
//                               //   'Phone No :${buildSuggestionList[index].guardianID}',
//                               //   style: GoogleFonts.poppins(fontSize: 12),
//                               // ),
//                             ],
//                           ),
//                         )
//                       ],
//                     )),
//               );
//             },
//             separatorBuilder: (context, index) {
//               return const Divider();
//             },
//             itemCount: buildSuggestionList.length),
//       );
//     }
//   }
// }

// // void _showlert(BuildContext context, StudentModel data) {
// //   showDialog(
// //       barrierDismissible: false,
// //       context: context,
// //       builder: (context) => Student_Details_AlertBox_Widget(
// //             studentID: data.docid ?? "",
// //             studentImage: data.profileImageUrl ?? "",
// //             teacherName: data.teacherName ?? "",
// //             studentClass: data.classID ?? "",
// //             admissionNumber: data.admissionNumber ?? "",
// //             studentGender: data.gender ?? "",
// //             bloodGroup: data.bloodgroup ?? "",
// //             studentEmail: data.studentemail ?? "",
// //             houseName: data.houseName ?? "",
// //             place: data.place ?? "",
// //             district: data.district ?? "",
// //           ));
// // }
