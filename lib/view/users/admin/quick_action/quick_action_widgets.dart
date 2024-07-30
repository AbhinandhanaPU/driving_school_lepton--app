import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/view/users/admin/admin_pages/driving_test_page/driving_test_home.dart';
import 'package:new_project_app/view/users/admin/admin_pages/notifications/notifications.dart';
import 'package:new_project_app/view/users/admin/admin_pages/practice_shedule/practice_shedule_home.dart';
import 'package:new_project_app/view/users/admin/admin_pages/study_materials/study_materials_admin.dart';

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
                return const DrivingHomePage();
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
                  return const PracticeSheduleHome();
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
                return AdminStudyMaterials();
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
                  return Notifications();
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
                'assets/flaticons/mobile-notification.png',
                scale: 2.5,
              ),
            ),
          ),
          Text(
            "NOtification",
            style: TextStyle(fontSize: 12.sp),
          )
        ],
      ),
    );
  }
}
