import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/course_controller/course_controller.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:new_project_app/view/widgets/custom_show_dialogbox/custom_show_dialouge.dart';
import 'package:new_project_app/view/widgets/textformfeild_container/textformfiled_blue_container.dart';

editFunctionOfCourse(BuildContext context, CourseModel data) {
  final CourseController courseController = Get.put(CourseController());
  customShowDilogBox(
      context: context,
      title: 'Edit',
      children: [
        Form(
          key: courseController.formKey,
          child: Column(
            children: [
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: courseController.editcourseNameController,
                  hintText: data.courseName,
                  title: 'Course Name'),
              TextFormFiledHeightnoColor(
                  controller: courseController.editcourseDesController,
                  hintText: data.courseDes,
                  validator: checkFieldEmpty,
                  title: 'Description'),
              TextFormFiledHeightnoColor(
                  controller: courseController.editcourseDurationController,
                  hintText: data.duration,
                  validator: checkFieldEmpty,
                  title: 'Duration'),
              TextFormFiledHeightnoColor(
                  controller: courseController.editcourseRateController,
                  hintText: data.rate,
                  validator: checkFieldEmpty,
                  title: 'Course Fee')
            ],
          ),
        ),
      ],
      doyouwantActionButton: true,
      actiononTapfuction: () {
        if (courseController.formKey.currentState!.validate()) {
          courseController.updateCourse(data.courseId, context);
        }
      },
      actiontext: 'Update');
}
