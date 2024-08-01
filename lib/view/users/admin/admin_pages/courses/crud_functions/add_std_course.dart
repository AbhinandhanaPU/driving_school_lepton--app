import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/controller/course_controller/course_controller.dart';
import 'package:new_project_app/view/widgets/custom_show_dialogbox/custom_showdilog.dart';
import 'package:new_project_app/view/widgets/student_dropdown/all_students.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

addStudentToCourse(BuildContext context, String courseID) {
  final CourseController courseController = Get.put(CourseController());
  customShowDilogBox2(
    context: context,
    title: 'All Student',
    children: [
      Form(
        key: courseController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
              child: TextFontWidget(text: 'Select Student *', fontsize: 12.5),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 5, left: 10, right: 10, bottom: 15),
              child: AllStudentDropDown(),
            ),
          ],
        ),
      ),
    ],
    doyouwantActionButton: true,
    actiononTapfuction: () async {
      if (courseController.formKey.currentState!.validate()) {
        courseController
            .addStudentToCourseController(courseID)
            .then((value) => Navigator.pop(context));
      }
    },
  );
}
