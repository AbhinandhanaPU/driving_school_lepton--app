import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/controller/student_controller/student_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/widgets/custom_show_dialogbox/custom_showdilog.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

archivesStudentsFunction(BuildContext context, StudentModel studentModel) {
  StudentController studentController = Get.put(StudentController());
  customShowDilogBox2(
    context: context,
    title: "Archives",
    children: [
      const TextFontWidget(
          text:
              "You are going to delete this profile.This Profile will archived for future reference.",
          fontsize: 13)
    ],
    doyouwantActionButton: true,
    actiononTapfuction: () {
      studentController.addStudentsToArchive(studentModel);
    },
  );
}
