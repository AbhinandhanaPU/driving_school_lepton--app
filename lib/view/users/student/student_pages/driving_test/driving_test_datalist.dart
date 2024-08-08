import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/model/test_model/test_model.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class StudentDrivingTestDatas extends StatelessWidget {
  final TestModel data;

  StudentDrivingTestDatas({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        left: 15,
        right: 15,
        bottom: 8,
      ),
      padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 25),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: TextFontWidget(
                  text: "Test Date : ${data.testDate}",
                  fontsize: 21.h,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          kHeight40,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFontWidget(
                    text: 'Test Location',
                    fontsize: 14.h,
                    fontWeight: FontWeight.bold,
                    color: cblack.withOpacity(0.7),
                  ),
                  kHeight10,
                  TextFontWidget(
                    text: "${data.location}",
                    fontsize: 18.h,
                    fontWeight: FontWeight.bold,
                    color: cblue,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFontWidget(
                    text: 'Test Time',
                    fontsize: 14.h,
                    fontWeight: FontWeight.bold,
                    color: cblack.withOpacity(0.7),
                  ),
                  kHeight10,
                  TextFontWidget(
                    text: "${data.testTime}",
                    fontsize: 18.h,
                    fontWeight: FontWeight.bold,
                    color: cblue,
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
