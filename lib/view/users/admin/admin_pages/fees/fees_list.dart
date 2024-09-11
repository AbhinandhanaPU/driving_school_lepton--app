import 'dart:developer';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/student_controller/student_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/batch_model/batch_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/widgets/loading_widget/lottie_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class FeesList extends StatelessWidget {
  final StudentModel stdData;
  final double amountPaid;
  final double totalAmount;
  final double pendingAmount;
  FeesList({
    super.key,
    required this.stdData,
    required this.amountPaid,
    required this.totalAmount,
    required this.pendingAmount,
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
      padding: EdgeInsets.only(left: 12, right: 12, top: 15, bottom: 15),
      decoration: BoxDecoration(
        color: pendingAmount != 0 ? cWhite : Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: pendingAmount != 0
                ? Colors.red.withOpacity(0.1)
                : Colors.green.withOpacity(0.1),
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
                  text: stdData.studentName,
                  fontsize: 21.h,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<List<String>>(
                      future: studentController.fetchStudentsCourse(stdData),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LottieLoadingWidet();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
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
                    stdData.batchId.isEmpty
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
                                .doc(stdData.batchId)
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
                                log('No data found for batchId: ${stdData.batchId}');
                                return const Text('Batch Not Found');
                              } else {
                                final batchData =
                                    BatchModel.fromMap(snapshot.data!.data()!);
                                String batchName = batchData.batchName.isEmpty
                                    ? "Not found"
                                    : batchData.batchName;
                                log('Batch name for batchId ${stdData.batchId}: $batchName');
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
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFontWidget(
                      text: pendingAmount.toStringAsFixed(0),
                      fontsize: 19.h,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                    TextFontWidget(
                      text: 'Pending Amount',
                      fontsize: 16.h,
                      fontWeight: FontWeight.bold,
                      color: cgrey,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFontWidget(
                      text: amountPaid.toStringAsFixed(0),
                      fontsize: 19.h,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                    TextFontWidget(
                      text: 'Amount Paid',
                      fontsize: 16.h,
                      fontWeight: FontWeight.bold,
                      color: cgrey,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFontWidget(
                      text: totalAmount.toStringAsFixed(0),
                      fontsize: 19.h,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                    TextFontWidget(
                      text: 'Total Amount',
                      fontsize: 16.h,
                      fontWeight: FontWeight.bold,
                      color: cgrey,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
