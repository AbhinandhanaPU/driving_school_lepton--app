import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/student_controller/student_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class ArchiveStdDataList extends StatelessWidget {
  final StudentModel data;

  ArchiveStdDataList({
    super.key,
    required this.data,
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
                  text: data.studentName,
                  fontsize: 21.h,
                  fontWeight: FontWeight.w500,
                ),
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
                  StreamBuilder<List<String>>(
                    stream: studentController.fetchStudentsCourse(data),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return TextFontWidget(
                          text: "Course not found",
                          fontsize: 18.h,
                          fontWeight: FontWeight.bold,
                          color: cblack,
                        );
                      } else {
                        String courses = snapshot.data!.join(',\n ');
                        return TextFontWidget(
                          text: courses,
                          fontsize: 18.h,
                          fontWeight: FontWeight.bold,
                          color: themeColor,
                        );
                      }
                    },
                  ),
                  TextFontWidget(
                    text: 'Course Type',
                    fontsize: 14.h,
                    fontWeight: FontWeight.bold,
                    color: cgrey,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFontWidget(
                    text: stringTimeToDateConvert(data.joiningDate),
                    fontsize: 18.h,
                    fontWeight: FontWeight.bold,
                    color: themeColor,
                  ),
                  TextFontWidget(
                    text: 'Joining Date',
                    fontsize: 14.h,
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
