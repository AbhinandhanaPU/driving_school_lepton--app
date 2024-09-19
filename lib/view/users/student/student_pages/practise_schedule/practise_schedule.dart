import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/controller/practice_shedule_controller/practice_shedule_controller.dart';
import 'package:new_project_app/model/practice_shedule_model/practice_shedule_model.dart';
import 'package:new_project_app/view/users/student/student_pages/practise_schedule/practice_schedule_datalist.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';

class StudentPracticeSchedule extends StatelessWidget {
  StudentPracticeSchedule({super.key});
  final PracticeSheduleController practiceController =
      Get.put(PracticeSheduleController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Practice Schedule".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: FutureBuilder<List<PracticeSheduleModel>>(
        future: practiceController.fetchStudentPracticeSchedules(),
        builder: (context, studentSnapshot) {
          if (studentSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (studentSnapshot.hasData &&
              studentSnapshot.data!.isNotEmpty) {
            return ListView.separated(
              itemCount: studentSnapshot.data!.length,
              separatorBuilder: (context, index) => kHeight10,
              itemBuilder: (context, index) {
                final data = studentSnapshot.data![index];
                return StudentPracticeScheduleDatas(
                  data: data,
                );
              },
            );
          }
          return Center(
            child: Text('No practice schedules found!'),
          );
        },
      ),
    );
  }
}
