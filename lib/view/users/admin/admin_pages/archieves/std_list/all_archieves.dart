// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/student_controller/student_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/archieves/crud/search_student_name.dart';
import 'package:new_project_app/view/users/admin/admin_pages/archieves/std_list/archieves_stds.dart';
import 'package:new_project_app/view/users/admin/admin_pages/archieves/std_list/student_profile.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';

class ArchivedStudents extends StatelessWidget {
  ArchivedStudents({super.key});
  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "All Archieves".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
        actions: [
          IconButton(
            onPressed: () {
              searchStudentsByName(context);
            },
            icon: Icon(Icons.search),
            iconSize: 30,
          ),
          kWidth20
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: server
                  .collection('DrivingSchoolCollection')
                  .doc(UserCredentialsController.schoolId)
                  .collection('Archives')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data = StudentModel.fromMap(
                          snapshot.data!.docs[index].data());
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentProfile(
                                data: data,
                              ),
                            ),
                          );
                        },
                        child: ArchiveStdDataList(data: data),
                      );
                    },
                  );
                } else {
                  return const LoadingWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> searchStudentsByName(BuildContext context) async {
    studentController.fetchAllArchivesStudents();
    await showSearch(context: context, delegate: ArchivedStdSearchByName());
  }
}
