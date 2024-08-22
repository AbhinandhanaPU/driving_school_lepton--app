import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/test_model/test_model.dart';
import 'package:new_project_app/view/users/student/student_pages/driving_test/driving_test_datalist.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';

class StudentDrivingTest extends StatelessWidget {
  const StudentDrivingTest({super.key});

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
      body: StreamBuilder(
        stream: server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('DrivingTest')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.docs.length,
              separatorBuilder: ((context, index) {
                return kHeight10;
              }),
              itemBuilder: (BuildContext context, int index) {
                final drivingTestDoc = snapshot.data!.docs[index];
                return FutureBuilder(
                  future: server
                      .collection('DrivingSchoolCollection')
                      .doc(UserCredentialsController.schoolId)
                      .collection('DrivingTest')
                      .doc(drivingTestDoc.id)
                      .collection('Students')
                      .doc(UserCredentialsController.studentModel!.docid)
                      .get(),
                  builder: (context, studentSnapshot) {
                    if (studentSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (studentSnapshot.hasData &&
                        studentSnapshot.data!.exists) {
                      final data = TestModel.fromMap(drivingTestDoc.data());
                      return StudentDrivingTestDatas(
                        data: data,
                      );
                    }
                    return const SizedBox 
                        .shrink(); // Return an empty widget if the user is not found
                  },
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
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
