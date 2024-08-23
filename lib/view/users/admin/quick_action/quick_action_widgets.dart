import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/controller/student_controller/student_controller.dart';
import 'package:new_project_app/view/users/admin/admin_pages/batch/batch_home.dart';
import 'package:new_project_app/view/users/admin/admin_pages/driving_test_page/driving_test_home.dart';
import 'package:new_project_app/view/users/admin/admin_pages/practice_shedule/practice_schedule/practice_shedule_home.dart';
import 'package:new_project_app/view/users/admin/admin_pages/requests/request_homepage.dart';

class QuickActionsWidgetDrivingTestAdmin extends StatelessWidget {
  const QuickActionsWidgetDrivingTestAdmin({
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
                return DrivingHomePage();
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
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PracticeSheduleHome();
                },
              ),
            ),
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

class QuickActionsWidgetRequest extends StatefulWidget {
  QuickActionsWidgetRequest({
    super.key,
  });

  @override
  State<QuickActionsWidgetRequest> createState() =>
      _QuickActionsWidgetRequestState();
}

class _QuickActionsWidgetRequestState extends State<QuickActionsWidgetRequest> {
  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86.h,
      width: 94.w,
      child: Stack(
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return StudentRequest();
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
                    'assets/flaticons/add.png',
                    scale: 2.5,
                  ),
                ),
              ),
              Text(
                "Student Request",
                style: TextStyle(fontSize: 12.sp),
              )
            ],
          ),
          studentController.totalStudentsCount.value != 0
              ? Positioned(
                  right: 10,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: themeColor,
                    ),
                    child: Text(
                      studentController.totalStudentsCount.value.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: cWhite,
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

class QuickActionsWidgetChat extends StatelessWidget {
  const QuickActionsWidgetChat({
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
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return BatchHome();
                },
              ),
            ),
            child: Container(
              height: 55.h,
              width: 55.w,
              decoration: BoxDecoration(
                  color: cWhite,
                  border: Border.all(color: cblack.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                'assets/flaticons/batch-processing.png',
                scale: 2.5,
              ),
            ),
          ),
          Text(
            "Batches",
            style: TextStyle(fontSize: 12.sp),
          )
        ],
      ),
    );
  }
}
