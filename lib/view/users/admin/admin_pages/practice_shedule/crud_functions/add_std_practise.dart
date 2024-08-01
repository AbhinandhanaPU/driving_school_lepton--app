import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/controller/practice_shedule_controller/practice_shedule_controller.dart';
import 'package:new_project_app/view/widgets/custom_show_dialogbox/custom_showdilog.dart';
import 'package:new_project_app/view/widgets/student_dropdown/all_students.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

addStudentToPractise(BuildContext context, ) {
  final PracticeSheduleController practiceshedulecontroller =
      Get.put(PracticeSheduleController());
  customShowDilogBox2(
      context: context,
      title: 'All Student',
      children: [
        Form(
          key: practiceshedulecontroller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding:
                    EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
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
        if (practiceshedulecontroller.formKey.currentState!.validate()) {
          practiceshedulecontroller
              .addStudent()
              .then((value) => Navigator.pop(context));
        }
      });
}
