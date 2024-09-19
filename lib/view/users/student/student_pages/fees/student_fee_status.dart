import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/controller/student_controller/student_controller.dart';
import 'package:new_project_app/view/users/student/student_pages/fees/student_fee_datas.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';

class StudentFeeStatus extends StatelessWidget {
  StudentFeeStatus({super.key});
  final StudentController studentController = Get.put(StudentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: cWhite,
          title: Text(
            "Fee".tr,
          ),
          flexibleSpace: const AppBarColorWidget(),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: studentController.fetchStdFeeStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final courseId = snapshot.data![index]['courseId'];
                  final feeData = snapshot.data![index]['feeData'];

                  return StudentFeeDatas(
                    dataa: feeData,
                    courseId: courseId,
                  );
                },
              );
            }

            return const Text('No fee data available for this student.');
          },
        ));
  }
}
