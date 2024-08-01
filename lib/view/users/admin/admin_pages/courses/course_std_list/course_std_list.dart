import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/course_controller/course_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/all_students/student_profile.dart';
import 'package:new_project_app/view/users/admin/admin_pages/courses/course_std_list/course_std_datalist.dart';
import 'package:new_project_app/view/users/admin/admin_pages/courses/crud_functions/add_std_course.dart';
import 'package:new_project_app/view/users/admin/admin_pages/courses/crud_functions/search_student_course.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class CourseStudentsList extends StatelessWidget {
  final CourseModel data;

  CourseStudentsList({
    super.key,
    required this.data,
  });
  final CourseController courseController = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Students List".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
        actions: [
          GestureDetector(
            onTap: () {
              searchStudentsByName(context, data.courseId);
            },
            child: Icon(Icons.search),
          ),
          kWidth20,
          GestureDetector(
            onTap: () {
              addStudentToCourse(context, data.courseId);
            },
            child: Icon(Icons.person_add),
          ),
          kWidth10
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: server
                  .collection('DrivingSchoolCollection')
                  .doc(UserCredentialsController.schoolId)
                  .collection('Courses')
                  .doc(data.courseId)
                  .collection('Students')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: TextFontWidget(
                      text: 'No students found',
                      fontsize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data = StudentModel.fromMap(
                          snapshot.data!.docs[index].data());
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentProfile(
                                data: data,
                              ),
                            ),
                          );
                        },
                        child: CourseStudentDataList(
                          data: data,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> searchStudentsByName(
      BuildContext context, String courseId) async {
    courseController.fetchStudentsCourse(courseId);
    await showSearch(context: context, delegate: SearchCourseStudents());
  }
}
