import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/fees/fees_list.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';

class FeesHomePage extends StatelessWidget {
  final String courseId;

  const FeesHomePage({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Students List".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: server
                  .collection('DrivingSchoolCollection')
                  .doc(UserCredentialsController.schoolId)
                  .collection('FeeCollection')
                  .doc(courseId)
                  .collection('Students')
                  .snapshots(),
              builder: (context, snapS) {
                if (snapS.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapS.hasData && snapS.data!.docs.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapS.data!.docs.length,
                    itemBuilder: (context, index) {
                      final data = snapS.data!.docs[index].data();
                      return StreamBuilder(
                          stream: server
                              .collection('DrivingSchoolCollection')
                              .doc(UserCredentialsController.schoolId)
                              .collection('Students')
                              .doc(data['studentID'])
                              .snapshots(),
                          builder: (context, snapshot) {
                            final modeldata = snapshot.data?.data() ?? {};
                            final stdData = StudentModel.fromMap(modeldata);
                            return FeesList(
                              stdData: stdData,
                              feeData: data,
                            );
                          });
                    },
                  );
                } else if (snapS.data == null) {
                  return const LoadingWidget();
                } else {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "No students Added to fees collection",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
