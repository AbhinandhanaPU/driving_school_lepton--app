import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/controller/test_controller/test_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/model/test_model/test_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/driving_test_page/CRUD/edit_test.dart';
import 'package:new_project_app/view/widgets/custom_delete_showdialog/custom_delete_showdialog.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class DrivingTestList extends StatelessWidget {
  final TestModel data;

  DrivingTestList({
    super.key,
    required this.data,
  });
  final TestController testController = Get.put(TestController());

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
                  text: "Test Date : ${data.testDate}",
                  fontsize: 21.h,
                  fontWeight: FontWeight.w500,
                ),
              ),
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: const Text(
                        "Edit",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      onTap: () {
                        testController.testDateController.text = data.testDate;
                        testController.testTimeController.text = data.testTime;
                        testController.testLocationController.text =
                            data.location;
                        editFunctionOfTest(context, data);
                      },
                    ),
                    PopupMenuItem(
                      onTap: () {
                        customDeleteShowDialog(
                          context: context,
                          onTap: () {
                            testController
                                .deleteTest(docId: data.docId)
                                .then((value) => Navigator.pop(context));
                          },
                        );
                      },
                      child: const Text(
                        " Delete",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ];
                },
              ),
            ],
          ),
          kHeight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFontWidget(
                    text: "${data.location}",
                    fontsize: 18.h,
                    fontWeight: FontWeight.bold,
                    color: cblue,
                  ),
                  TextFontWidget(
                    text: 'Test Location',
                    fontsize: 14.h,
                    fontWeight: FontWeight.bold,
                    color: cblack.withOpacity(0.7),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFontWidget(
                    text: "${data.testTime}",
                    fontsize: 18.h,
                    fontWeight: FontWeight.bold,
                    color: cblue,
                  ),
                  TextFontWidget(
                    text: 'Test Time',
                    fontsize: 14.h,
                    fontWeight: FontWeight.bold,
                    color: cblack.withOpacity(0.7),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.group, color: cblue),
                      kWidth10,
                      StreamBuilder<List<StudentModel>>(
                        stream: testController
                            .fetchStudentsWithStatusTrue(data.docId),
                        builder: (context, snapshot) {
                          final studentCount =
                              snapshot.hasData ? snapshot.data!.length : 0;
                          return TextFontWidget(
                            text: studentCount.toString(),
                            fontsize: 16.h,
                            fontWeight: FontWeight.bold,
                            color: cblack,
                          );
                        },
                      ),
                    ],
                  ),
                  TextFontWidget(
                    text: 'Total Students',
                    fontsize: 14.h,
                    fontWeight: FontWeight.bold,
                    color: cblack.withOpacity(0.7),
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
