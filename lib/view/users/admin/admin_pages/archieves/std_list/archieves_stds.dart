import 'dart:developer';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/student_controller/student_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/batch_model/batch_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/widgets/loading_widget/lottie_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class ArchiveStdDataList extends StatelessWidget {
  final StudentModel studentModel;

  ArchiveStdDataList({
    super.key,
    required this.studentModel,
  });
  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
        bottom: 8,
      ),
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 15),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextFontWidget(
                  text: studentModel.studentName,
                  fontsize: 21.h,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Transform.scale(
                scale: 0.65,
                child: Switch(
                  activeColor: Colors.green,
                  value: studentModel.status == true,
                  onChanged: (value) {
                    final newStatus = value ? true : false;
                    studentController.updateStudentStatus(
                        studentModel, newStatus);
                  },
                ),
              ),
            ],
          ),
          kHeight30,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<List<String>>(
                    future: studentController.fetchStudentsCourse(studentModel),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LottieLoadingWidet();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return TextFontWidget(
                          text: 'Course Not Found',
                          fontsize: 18.h,
                          fontWeight: FontWeight.bold,
                          color: themeColor,
                        );
                      } else {
                        String courses = snapshot.data!.join(', ');
                        return TextFontWidget(
                          text: courses,
                          fontsize: 19.h,
                          fontWeight: FontWeight.bold,
                          color: themeColor,
                        );
                      }
                    },
                  ),
                  TextFontWidget(
                    text: 'Courses',
                    fontsize: 18.h,
                    fontWeight: FontWeight.bold,
                    color: cgrey,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  studentModel.batchId.isEmpty
                      ? Expanded(
                          child: TextFontWidget(
                            text: 'Batch not Assigned',
                            fontsize: 18.h,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        )
                      : FutureBuilder(
                          future: server
                              .collection('DrivingSchoolCollection')
                              .doc(UserCredentialsController.schoolId)
                              .collection('Batch')
                              .doc(studentModel.batchId)
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const LottieLoadingWidet();
                            } else if (snapshot.hasError) {
                              log('Error fetching batch data: ${snapshot.error}');
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                !snapshot.data!.exists) {
                              log('No data found for batchId: ${studentModel.batchId}');
                              return const Text('Batch Not Found');
                            } else {
                              final batchData =
                                  BatchModel.fromMap(snapshot.data!.data()!);
                              String batchName = batchData.batchName.isEmpty
                                  ? "Not found"
                                  : batchData.batchName;
                              log('Batch name for batchId ${studentModel.batchId}: $batchName');
                              return TextFontWidget(
                                text: batchName,
                                fontsize: 19.h,
                                fontWeight: FontWeight.bold,
                                color: themeColor,
                              );
                            }
                          },
                        ),
                  TextFontWidget(
                    text: 'Batch',
                    fontsize: 18.h,
                    fontWeight: FontWeight.bold,
                    color: cgrey,
                  ),
                ],
              ),
            ],
          ),
          kHeight30,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFontWidget(
                    text: studentModel.studentemail,
                    fontsize: 19.h,
                    fontWeight: FontWeight.bold,
                    color: themeColor,
                  ),
                  TextFontWidget(
                    text: 'Email Id',
                    fontsize: 18.h,
                    fontWeight: FontWeight.bold,
                    color: cgrey,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFontWidget(
                    text: stringTimeToDateConvert(studentModel.joiningDate),
                    fontsize: 19.h,
                    fontWeight: FontWeight.bold,
                    color: themeColor,
                  ),
                  TextFontWidget(
                    text: 'Joining Date',
                    fontsize: 18.h,
                    fontWeight: FontWeight.bold,
                    color: cgrey,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}