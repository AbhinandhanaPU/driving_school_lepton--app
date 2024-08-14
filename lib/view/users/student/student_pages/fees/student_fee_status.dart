import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/view/users/student/student_pages/fees/student_fee_datas.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';

class StudentFeeStatus extends StatelessWidget {
  const StudentFeeStatus({super.key});

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
      body: StreamBuilder(
        stream: server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('FeeCollection')
            .doc(UserCredentialsController.studentModel!.docid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.data();
             if (data == null) {
        return Center(
          child: Text('You have no pending'),
        );
      }
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) => StudentFeeDatas(dataa: data),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Text('No data'.tr),
          );
        },
      ),
    );
  }
}
