// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/course_controller/course_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/fees/course/course_datalist.dart';
import 'package:new_project_app/view/users/admin/admin_pages/fees/fees_home_page.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';

class FeeCourseList extends StatelessWidget {
  FeeCourseList({super.key});

  CourseController courseController = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Fee Course List".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: server
                  .collection('DrivingSchoolCollection')
                  .doc(UserCredentialsController.schoolId)
                  .collection('FeeCollection')
                  .snapshots(),
              builder: (context, snapS) {
                if (snapS.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapS.data == null || snapS.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'No courses',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: snapS.data!.docs.length,
                  itemBuilder: (context, index) {
                    final fee = snapS.data!.docs[index].data();
                    final courseId = fee['docId'];
                    return StreamBuilder(
                      stream: server
                          .collection('DrivingSchoolCollection')
                          .doc(UserCredentialsController.schoolId)
                          .collection('Courses')
                          .doc(courseId)
                          .snapshots(),
                      builder: (context, courseSnapshot) {
                        if (courseSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (!courseSnapshot.hasData ||
                            !courseSnapshot.data!.exists) {
                          return const SizedBox.shrink();
                        }
                        final data =
                            CourseModel.fromMap(courseSnapshot.data!.data()!);
                        return FutureBuilder<int>(
                          future: courseController
                              .fetchFeeStudentsCount(data.courseId),
                          builder: (context, countSnap) {
                            if (countSnap.hasError || countSnap.data == 0) {
                              return const SizedBox.shrink();
                            }
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FeesHomePage(courseId: courseId),
                                  ),
                                );
                              },
                              child: FeeCourseDatalist(data: data),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
