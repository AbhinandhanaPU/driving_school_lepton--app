import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class StudentFeeDatas extends StatelessWidget {
  final Map<String, dynamic> dataa;

  StudentFeeDatas({
    super.key,
    required this.dataa,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        left: 15,
        right: 15,
        bottom: 8,
      ),
      padding: const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 25),
      decoration: BoxDecoration(
        color: cWhite,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: cblack.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFontWidget(
                text: "Course Name : ",
                fontsize: 21.h,
                fontWeight: FontWeight.w500,
              ),
              StreamBuilder(
                stream: server
                    .collection('DrivingSchoolCollection')
                    .doc(UserCredentialsController.schoolId)
                    .collection('Courses')
                    .doc(dataa['courseID'])
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Flexible(
                      child: TextFontWidget(
                        text: "Error loading course",
                        fontsize: 21.h,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    );
                  } else if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Flexible(
                      child: TextFontWidget(
                        text: "Course not found",
                        fontsize: 21.h,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    );
                  } else {
                    final courseData = CourseModel.fromMap(snapshot.data!.data()!);
                    return Flexible(
                      child: TextFontWidget(
                        text: courseData.courseName,
                        fontsize: 21.h,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }
                },
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
                    text: 'Fee Status',
                    fontsize: 14.h,
                    fontWeight: FontWeight.bold,
                    color: cblack.withOpacity(0.7),
                  ),
                  kHeight10,
                  TextFontWidget(
                    text: dataa['feeStatus'],
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
                    text: 'Pending Amount',
                    fontsize: 14.h,
                    fontWeight: FontWeight.bold,
                    color: cblack.withOpacity(0.7),
                  ),
                  kHeight10,
                  TextFontWidget(
                    text: dataa['pendingAmount'].toString(),
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
