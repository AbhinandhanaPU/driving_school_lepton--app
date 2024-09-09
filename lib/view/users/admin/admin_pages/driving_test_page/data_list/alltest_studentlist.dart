import 'dart:developer';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/controller/student_controller/student_controller.dart';
import 'package:new_project_app/controller/test_controller/test_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/model/test_model/test_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/all_students/student_profile.dart';
import 'package:new_project_app/view/users/admin/admin_pages/driving_test_page/CRUD/add_std_test.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';
import 'package:new_project_app/view/widgets/loading_widget/lottie_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class AllTestStudentList extends StatelessWidget {
  final TestModel testModel;
  AllTestStudentList({super.key, required this.testModel});

  @override
  Widget build(BuildContext context) {
    StudentController studentController = Get.put(StudentController());
    TestController testController = Get.put(TestController());

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text('Students List'),
              Spacer(),
              GestureDetector(
                onTap: () {
                  addStudentToTest(context, testModel.docId);
                },
                child: Icon(Icons.person_add),
              )
            ],
          ),
          foregroundColor: cWhite,
          backgroundColor: themeColor,
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<StudentModel>>(
                stream:
                    testController.fetchStudentsWithStatusTrue(testModel.docId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingWidget();
                  }
                  if (snapshot.hasError) {
                    return Center(
                        child: Text('Error: ${snapshot.error.toString()}'));
                  }
                  final students = snapshot.data ?? [];
                  if (students.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Please add Students",
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (BuildContext context, int index) {
                        log("Count ${students.length}");
                        final studentModel = students[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return StudentProfile(
                                    studentModel: studentModel,
                                  );
                                },
                              ),
                            );
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
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: studentModel
                                                        .profileImageUrl ==
                                                    ''
                                                ? const NetworkImage(
                                                    'https://firebasestorage.googleapis.com/v0/b/vidya-veechi-8-feb-2024.appspot.com/o/important***%2Fteacher-avathar2.png?alt=media&token=3db0d66c-225d-429b-a34e-f71b6b7dde7d')
                                                : NetworkImage(
                                                    studentModel
                                                        .profileImageUrl,
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
                                              text: studentModel.studentName,
                                              fontsize: 21,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        children: [
                                          TextFontWidget(
                                            text: '👩🏻‍🎓 Course :  ',
                                            fontsize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: cblack,
                                          ),
                                          FutureBuilder<List<String>>(
                                            future: studentController
                                                .fetchStudentsCourse(
                                                    studentModel),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return LottieLoadingWidet();
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              } else if (!snapshot.hasData ||
                                                  snapshot.data!.isEmpty) {
                                                return TextFontWidget(
                                                  text: 'No Course',
                                                  fontsize: 14.h,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                );
                                              } else {
                                                String courses =
                                                    snapshot.data!.join(',\n ');
                                                return TextFontWidget(
                                                  text: courses,
                                                  fontsize: 14.h,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        children: [
                                          TextFontWidget(
                                            text: '✉️  Email :  ',
                                            fontsize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: cblack,
                                          ),
                                          TextFontWidget(
                                            text: studentModel.studentemail,
                                            fontsize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        children: [
                                          TextFontWidget(
                                            text: '📞  Phone No  :  ',
                                            fontsize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: cblack,
                                          ),
                                          TextFontWidget(
                                            text: studentModel.phoneNumber,
                                            fontsize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        ],
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
        ));
  }
}
