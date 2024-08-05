import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/view/users/teacher/teacher_pages/Tutor_batch/tutor_batch_home.dart';
import 'package:new_project_app/view/users/teacher/teacher_pages/driving_test_tutor/driving_test_home.dart';
import 'package:new_project_app/view/users/teacher/teacher_pages/practice_shedule_tutor/practice_schedule_tr/practice_shedule_home_tr.dart';
import 'package:new_project_app/view/users/teacher/teacher_pages/study_materials/study_materials_teacher.dart';

class QuickActionsWidgetDrivingTestTr extends StatelessWidget {
  const QuickActionsWidgetDrivingTestTr({
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
            onTap: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return     TutorDrivingHomePage();
            },)),

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

class QuickActionsWidgetPracticeTr extends StatelessWidget {
  const QuickActionsWidgetPracticeTr({
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
                return   TutorPracticeSheduleHome();
            },)),
            child: Container(
              height: 55.h,
              width: 55.w,
              decoration: BoxDecoration(
                  color: cWhite,
                  border: Border.all(color: cblack.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                'assets/flaticons/calendar.png',
                scale: 2.5,
              ),
            ),
          ),
          Text(
            "Practice",
            style: TextStyle(fontSize: 12.sp),
          )
        ],
      ),
    );
  }
}

class QuickActionsWidgetSMTR extends StatelessWidget {
  const QuickActionsWidgetSMTR({
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
                return const StudyMaterialsTeacher();
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

class QuickActionsWidgetChatTr extends StatelessWidget {
  const QuickActionsWidgetChatTr({
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
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
             return   AllBatchHomeOfTutor();
            },)),
            child: Container(
              height: 55.h,
              width: 55.w,
              decoration: BoxDecoration(
                  color: cWhite,
                  border: Border.all(color: cblack.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                      'assets/flaticons/batch-processing.png',//bacth
                scale: 2.5,
              ),
            ),
          ),
          Text(
            "Batch",
            style: TextStyle(fontSize: 12.sp),
          )
        ],
      ),
    );
  }
}
