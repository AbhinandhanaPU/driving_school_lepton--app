import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: studentController.fetchStdFeeStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No fee data available.'));
          } else {
            final feeDocs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: feeDocs.length,
              itemBuilder: (context, index) {
                final feeData = feeDocs[index].data();

                return StudentFeeDatas(dataa: feeData);
              },
            );
          }
        },
      ),
    );
  }
}
