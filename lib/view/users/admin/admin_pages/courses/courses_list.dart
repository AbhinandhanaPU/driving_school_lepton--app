// ignore_for_file: must_be_immutable

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/course_controller/course_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/courses/create_course.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class CourseList extends StatelessWidget {
  CourseList({super.key});

  CourseController courseController = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Course List".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
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
                      .collection('Courses')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          CourseModel data = CourseModel.fromMap(
                              snapshot.data!.docs[index].data());
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 15,
                                  left: 15,
                                  right: 15,
                                  bottom: 8,
                                ),
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 15),
                                decoration: BoxDecoration(
                                  color: cWhite,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: cblack.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                // height: 210,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: TextFontWidget(
                                            text: data.courseName,
                                            fontsize: 21.h,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.more_vert,
                                          color: cgrey,
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 12.h, bottom: 15.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: TextFontWidget(
                                              text: data.courseDes,
                                              fontsize: 15.h,
                                              fontWeight: FontWeight.w400,
                                              color: cgrey,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextFontWidget(
                                              text: data.rate,
                                              fontsize: 18.h,
                                              fontWeight: FontWeight.bold,
                                              color: themeColor,
                                            ),
                                            TextFontWidget(
                                              text: 'Fee',
                                              fontsize: 14.h,
                                              fontWeight: FontWeight.bold,
                                              color: cgrey,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.group,
                                                    color: themeColor),
                                                kWidth10,
                                                StreamBuilder<int>(
                                                  stream: courseController
                                                      .fetchTotalStudents(
                                                          data.courseId),
                                                  builder: (context, snapshot) {
                                                    return TextFontWidget(
                                                      text: snapshot.hasData
                                                          ? snapshot.data
                                                              .toString()
                                                          : '0',
                                                      fontsize: 16.h,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: cblack,
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            TextFontWidget(
                                              text: 'Total Students',
                                              fontsize: 14.h,
                                              fontWeight: FontWeight.bold,
                                              color: cgrey,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            TextFontWidget(
                                              text: "${data.duration} Days",
                                              fontsize: 18.h,
                                              fontWeight: FontWeight.bold,
                                              color: themeColor,
                                            ),
                                            TextFontWidget(
                                              text: 'Duration',
                                              fontsize: 14.h,
                                              fontWeight: FontWeight.bold,
                                              color: cgrey,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return CreateCourses();
                  },
                ));
              },
              child: ButtonContainerWidget(
                  curving: 30,
                  colorindex: 0,
                  height: 40,
                  width: 140,
                  child: const Center(
                    child: TextFontWidgetRouter(
                      text: 'Create Course',
                      fontsize: 14,
                      fontWeight: FontWeight.bold,
                      color: cWhite,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
