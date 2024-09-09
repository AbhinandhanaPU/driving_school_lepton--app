import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/course_controller/course_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/users/widgets/std_fees_level/std_fees_level.dart';
import 'package:new_project_app/view/users/widgets/student_level/student_level.dart';
import 'package:new_project_app/view/widgets/custom_delete_showdialog/custom_delete_showdialog.dart';
import 'package:new_project_app/view/widgets/loading_widget/lottie_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class CourseStudentDataList extends StatelessWidget {
  final StudentModel data;

  CourseStudentDataList({
    super.key,
    required this.data,
  });
  final CourseController courseController = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    final courseModel = courseController.courseModelData.value!;
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
              IconButton(
                onPressed: () {
                  customDeleteShowDialog(
                    context: context,
                    onTap: () {
                      courseController
                          .deleteStudentsFromCourse(data)
                          .then((value) => Navigator.pop(context));
                    },
                  );
                },
                icon: Icon(Icons.delete_outline),
                iconSize: 25,
                color: cred,
                padding: EdgeInsets.all(0),
              ),
            ],
          ),
          kHeight10,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFontWidget(
                text: 'Completed Days : ',
                fontsize: 17.h,
                fontWeight: FontWeight.w400,
                color: cblack,
              ),
              TextFontWidget(
                text: '0',
                fontsize: 18.h,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ],
          ),
          kHeight20,
          Row(
            children: [
              TextFontWidget(
                text: 'Level : ',
                fontsize: 20.h,
                fontWeight: FontWeight.bold,
                color: cblack,
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: server
                        .collection('DrivingSchoolCollection')
                        .doc(UserCredentialsController.schoolId)
                        .collection('Courses')
                        .doc(courseModel.courseId)
                        .collection('Students')
                        .doc(data.docid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LottieLoadingWidet();
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }
                      String? level;
                      if (snapshot.hasData && snapshot.data?.data() != null) {
                        final feeData = snapshot.data!.data();
                        level = feeData!['level'] ?? 'biginner';
                      }
                      return StudentLevelDropDown(
                        data: data,
                        courseID: courseModel.courseId,
                        level: level,
                      );
                    }),
              ),
            ],
          ),
          kHeight10,
          Row(
            children: [
              TextFontWidget(
                text: 'Fees Status : ',
                fontsize: 20.h,
                fontWeight: FontWeight.bold,
                color: cblack,
              ),
              SizedBox(
                width: 15,
              ),
              StreamBuilder(
                stream: data.batchId.isNotEmpty && data.docid.isNotEmpty
                    ? server
                        .collection('DrivingSchoolCollection')
                        .doc(UserCredentialsController.schoolId)
                        .collection('FeesCollection')
                        .doc(data.batchId)
                        .collection('Courses')
                        .doc(courseModel.courseId)
                        .collection('Students')
                        .doc(data.docid)
                        .snapshots()
                    : null,
                builder: (context, snapshot) {
                  if (data.batchId.isEmpty || data.docid.isEmpty) {
                    return const Center(
                      child: Text('Batch Not Assigned'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LottieLoadingWidet();
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  String? feeStatus;
                  if (snapshot.hasData && snapshot.data?.data() != null) {
                    final feeData = snapshot.data!.data();
                    feeStatus = feeData!['feeStatus'] ?? 'not paid';
                  }

                  return Expanded(
                    child: StdFeesLevelDropDown(
                      data: data,
                      course: courseModel,
                      feeData: feeStatus,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
