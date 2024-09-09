import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/controller/course_controller/course_controller.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/all_students/student_profile.dart';
import 'package:new_project_app/view/users/admin/admin_pages/courses/course_std_list/course_std_datalist.dart';
import 'package:new_project_app/view/users/admin/admin_pages/courses/crud_functions/add_std_course.dart';
import 'package:new_project_app/view/users/admin/admin_pages/courses/crud_functions/search_student_course.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';

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
          data.courseName.tr,
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
            child: StreamBuilder<List<StudentModel>>(
              stream:
                  courseController.fetchStudentsWithStatusTrue(data.courseId),
              builder: (context, snapshot) {
                final students = snapshot.data ?? [];
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (students.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Students',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StudentProfile(studentModel: students[index]),
                            ),
                          );
                        },
                        child: CourseStudentDataList(data: students[index]),
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
    courseController.fetchStudentsWithStatusTrue(courseId);
    await showSearch(context: context, delegate: SearchCourseStudents());
  }
}
