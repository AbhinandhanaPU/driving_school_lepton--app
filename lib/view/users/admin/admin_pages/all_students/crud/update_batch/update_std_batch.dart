import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/controller/student_controller/student_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/batch/drop_down/batch_dp_dn.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

updateStudentBatch(
    {required BuildContext context, required StudentModel studentModel}) {
  final StudentController studentController = Get.put(StudentController());
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: cWhite,
        actionsAlignment: MainAxisAlignment.spaceAround,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back),
            ),
            const SizedBox(width: 10),
            const TextFontWidget(
              text: "Select batch",
              fontsize: 17,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        content: SizedBox(
          height: 80,
          width: 150,
          child: BatchDropDown(
            onChanged: (batch) {
              studentController.batchId.value = batch!.batchId;
              studentController.batchName.value = batch.batchName;
              log('New batch of ${studentModel.studentName}: ${batch.batchId} - ${batch.batchName}');
            },
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 30,
              width: 80,
              decoration: const BoxDecoration(
                color: themeColor,
              ),
              child: Center(
                child: GooglePoppinsWidgets(
                  text: 'Cancel',
                  color: cWhite,
                  fontsize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              studentController.updateStudentBatch(studentModel);
              Navigator.pop(context);
            },
            child: Container(
              height: 30,
              width: 80,
              decoration: const BoxDecoration(
                color: themeColor,
              ),
              child: Center(
                child: GooglePoppinsWidgets(
                  text: 'OK',
                  color: cWhite,
                  fontsize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
