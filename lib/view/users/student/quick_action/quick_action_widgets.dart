import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/controller/mock_test/admin_side/adminside_controller.dart';
import 'package:new_project_app/view/users/student/drawer/drawer_items/documents/documents/documents_std.dart';
import 'package:new_project_app/view/users/student/student_pages/driving_test/driving_test.dart';
import 'package:new_project_app/view/users/student/student_pages/study_materials/study_materials_student.dart';

class QuickActionsWidgetDrivingTest extends StatelessWidget {
  const QuickActionsWidgetDrivingTest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86.h,
      width: 86.w,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentDrivingTest(),
                ),
              );
            },
            child: Container(
              height: 55.h,
              width: 55.w,
              decoration: BoxDecoration(
                  color: cWhite,
                  border: Border.all(color: cblack.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                'assets/flaticons/cone.png',
                scale: 2.5,
              ),
            ),
          ),
          Text(
            "Driving Test",
            style: TextStyle(fontSize: 12.sp),
          )
        ],
      ),
    );
  }
}

class QuickActionsWidgetPractice extends StatelessWidget {
  const QuickActionsWidgetPractice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86.h,
      width: 86.w,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return DocumentsStd();
              },
            )),
            child: Container(
              height: 55.h,
              width: 55.w,
              decoration: BoxDecoration(
                  color: cWhite,
                  border: Border.all(color: cblack.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                'assets/images/documents.png',
                scale: 2.5,
              ),
            ),
          ),
          Text(
            "Upload Doc",
            style: TextStyle(fontSize: 12.sp),
          )
        ],
      ),
    );
  }
}

class QuickActionsWidgetSM extends StatelessWidget {
  const QuickActionsWidgetSM({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86.h,
      width: 86.w,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const StudyMaterialsStudent();
              },
            )),
            child: Container(
              height: 55.h,
              width: 55.w,
              decoration: BoxDecoration(
                  color: cWhite,
                  border: Border.all(color: cblack.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                'assets/flaticons/books.png',
                scale: 2.5,
              ),
            ),
          ),
          Text(
            "Study Material",
            style: TextStyle(fontSize: 12.sp),
          )
        ],
      ),
    );
  }
}

class QuickActionsWidgetQuestion extends StatelessWidget {
  final QuizTestAdminSideController quizTestAdminSideController =
      Get.put(QuizTestAdminSideController());
  QuickActionsWidgetQuestion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86.h,
      width: 86.w,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => quizTestAdminSideController.showLanguageBottomSheet(),
            child: Container(
              height: 55.h,
              width: 55.w,
              decoration: BoxDecoration(
                  color: cWhite,
                  border: Border.all(color: cblack.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                'assets/flaticons/exam.png',
                scale: 2.5,
              ),
            ),
          ),
          Text(
            "Mock Test",
            style: TextStyle(fontSize: 12.sp),
          )
        ],
      ),
    );
  }
}
