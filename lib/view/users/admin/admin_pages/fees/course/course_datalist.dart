import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/controller/course_controller/course_controller.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class FeeCourseDatalist extends StatelessWidget {
  final CourseModel data;

  FeeCourseDatalist({
    super.key,
    required this.data,
  });
  final CourseController courseController = Get.put(CourseController());

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
                  text: data.courseName,
                  fontsize: 21.h,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.h, bottom: 15.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFontWidget(
                  text: 'Students to Pay : ',
                  fontsize: 15.h,
                  fontWeight: FontWeight.w400,
                  color: cblack,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                FutureBuilder<int>(
                    future:
                        courseController.fetchFeeStudentsCount(data.courseId),
                    builder: (context, snapshot) {
                      return TextFontWidget(
                        text: snapshot.hasData ? snapshot.data.toString() : '',
                        fontsize: 15.h,
                        fontWeight: FontWeight.w400,
                        color: cblack,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      );
                    }),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFontWidget(
                    text: data.rate.toString(),
                    fontsize: 18.h,
                    fontWeight: FontWeight.bold,
                    color: themeColor,
                  ),
                  TextFontWidget(
                    text: 'Fee',
                    fontsize: 14.h,
                    fontWeight: FontWeight.bold,
                    color: cgrey,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.group, color: themeColor),
                      kWidth10,
                      StreamBuilder(
                        stream: courseController
                            .fetchStudentsWithStatusTrue(data.courseId),
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
                    color: cgrey,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFontWidget(
                    text: "${data.duration} Days",
                    fontsize: 18.h,
                    fontWeight: FontWeight.bold,
                    color: themeColor,
                  ),
                  TextFontWidget(
                    text: 'Duration',
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
