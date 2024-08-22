import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class FeesList extends StatelessWidget {
  final StudentModel stdData;
  final Map<String, dynamic> feeData;
  const FeesList({
    super.key,
    required this.stdData,
    required this.feeData,
  });

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
                  text: 
                  stdData.studentName,
                  fontsize: 21.h,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextFontWidget(
                text: ':',
                fontsize: 18.h,
                fontWeight: FontWeight.bold,
                color: cblack,
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFontWidget(
                    text: feeData['feeStatus'],
                    fontsize: 18.h,
                    fontWeight: FontWeight.bold,
                    color: themeColor,
                  ),
                  TextFontWidget(
                    text: 'Fee Status',
                    fontsize: 14.h,
                    fontWeight: FontWeight.bold,
                    color: cgrey,
                  ),
                ],
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFontWidget(
                    text: feeData['pendingAmount'].toString(),
                    fontsize: 18.h,
                    fontWeight: FontWeight.bold,
                    color: themeColor,
                  ),
                  TextFontWidget(
                    text: 'Pending Amount',
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
