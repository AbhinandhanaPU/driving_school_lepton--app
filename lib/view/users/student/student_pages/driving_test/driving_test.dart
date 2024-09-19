import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/controller/test_controller/test_controller.dart';
import 'package:new_project_app/model/test_model/test_model.dart';
import 'package:new_project_app/view/users/student/student_pages/driving_test/driving_test_datalist.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';

class StudentDrivingTest extends StatelessWidget {
  StudentDrivingTest({super.key});
  final TestController testController = Get.put(TestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Driving Test".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: FutureBuilder<List<TestModel>>(
        future: testController.fetchStudentDrivingTests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final drivingTests = snapshot.data!;
            return ListView.separated(
              itemCount: drivingTests.length,
              separatorBuilder: (context, index) => kHeight10,
              itemBuilder: (context, index) {
                final data = drivingTests[index];
                return StudentDrivingTestDatas(data: data);
              },
            );
          }
          return Center(
            child: Text('You are not added to any driving test!'.tr),
          );
        },
      ),
    );
  }
}
