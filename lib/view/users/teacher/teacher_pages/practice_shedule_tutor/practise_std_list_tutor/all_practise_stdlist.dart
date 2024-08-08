import 'dart:developer';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/student_controller/student_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/practice_shedule_model/practice_shedule_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/users/teacher/teacher_pages/practice_shedule_tutor/practise_std_list_tutor/practise_std_profile_tr.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class AllPractiseScheduleStudentListTutor extends StatelessWidget {
  final PracticeSheduleModel id;
  AllPractiseScheduleStudentListTutor({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    StudentController studentController = Get.put(StudentController());

    return Scaffold(
        appBar: AppBar(
          title: const Text('Students'),
          foregroundColor: cWhite,
          backgroundColor: themeColor,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: server
                        .collection('DrivingSchoolCollection')
                        .doc(UserCredentialsController.schoolId)
                        .collection('PracticeSchedule')
                        .doc(id.practiceId)
                        .collection("Students")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            log("Count ${snapshot.data!.docs.length}");
                            final data = StudentModel.fromMap(
                                snapshot.data!.docs[index].data());
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return TutorPractiseScheduleStudentProfile(
                                      stdata: data,
                                    );
                                  },
                                ));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 15,
                                      left: 15,
                                      right: 15,
                                      bottom: 8,
                                    ),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: cWhite,
                                      boxShadow: [
                                        BoxShadow(
                                          color: cblack.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3),
                                          // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    height: 150,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundImage: data
                                                            .profileImageUrl ==
                                                        ''
                                                    ? const NetworkImage(
                                                        'https://firebasestorage.googleapis.com/v0/b/vidya-veechi-8-feb-2024.appspot.com/o/important***%2Fteacher-avathar2.png?alt=media&token=3db0d66c-225d-429b-a34e-f71b6b7dde7d')
                                                    : NetworkImage(
                                                        data.profileImageUrl,
                                                      ),
                                                onBackgroundImageError:
                                                    (exception, stackTrace) {},
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.h),
                                                child: TextFontWidget(
                                                  text: data.studentName,
                                                  fontsize: 21.h,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 10.h),
                                            child: Row(
                                              children: [
                                                TextFontWidget(
                                                  text: '🪪 Course :  ',
                                                  fontsize: 15.h,
                                                  fontWeight: FontWeight.bold,
                                                  color: cblack,
                                                ),
                                                StreamBuilder<List<String>>(
                                                  stream: studentController
                                                      .fetchStudentsCourse(
                                                          data),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Text(
                                                          'Error: ${snapshot.error}');
                                                    } else if (!snapshot
                                                            .hasData ||
                                                        snapshot
                                                            .data!.isEmpty) {
                                                      return TextFontWidget(
                                                        text: 'No Course',
                                                        fontsize: 14.h,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue,
                                                      );
                                                    } else {
                                                      String courses = snapshot
                                                          .data!
                                                          .join(',\n ');
                                                      return TextFontWidget(
                                                        text: courses,
                                                        fontsize: 14.h,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue,
                                                      );
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 10.h),
                                            child: Row(
                                              children: [
                                                TextFontWidget(
                                                  text: '✉️  Email :  ',
                                                  fontsize: 15.h,
                                                  fontWeight: FontWeight.bold,
                                                  color: cblack,
                                                ),
                                                TextFontWidget(
                                                  text: data.studentemail,
                                                  fontsize: 14.h,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 10.h),
                                            child: Row(
                                              children: [
                                                TextFontWidget(
                                                  text: '📞  Phone No  :  ',
                                                  fontsize: 15.h,
                                                  fontWeight: FontWeight.bold,
                                                  color: cblack,
                                                ),
                                                TextFontWidget(
                                                  text: data.phoneNumber,
                                                  fontsize: 14.h,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return const LoadingWidget();
                      }
                    },
                  ),
                ),
              ],
            ),
            // Positioned(
            //   bottom: 20,
            //   right: 20,
            //   child: GestureDetector(
            //     onTap: () {
            //       Navigator.push(context, MaterialPageRoute(
            //         builder: (context) {
            //           return CreateTutor();
            //         },
            //       ));
            //     },
            //     child: ButtonContainerWidget(
            //         curving: 30,
            //         colorindex: 0,
            //         height: 40,
            //         width: 140,
            //         child: const Center(
            //           child: TextFontWidgetRouter(
            //             text: 'Create Tutor',
            //             fontsize: 14,
            //             fontWeight: FontWeight.bold,
            //             color: cWhite,
            //           ),
            //         )),
            //   ),
            // )
          ],
        ));
  }
}
