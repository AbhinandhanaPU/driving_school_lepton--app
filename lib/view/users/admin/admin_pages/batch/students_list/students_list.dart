import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/controller/batch_controller/batch_controller.dart';
import 'package:new_project_app/model/batch_model/batch_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/all_students/student_profile.dart';
import 'package:new_project_app/view/users/admin/admin_pages/batch/crud_functions/add_std_batch.dart';
import 'package:new_project_app/view/users/admin/admin_pages/batch/crud_functions/search_student_name.dart';
import 'package:new_project_app/view/users/admin/admin_pages/batch/students_list/students_datalist.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';

class BatchStudentsList extends StatelessWidget {
  final BatchModel batchModel;

  BatchStudentsList({
    super.key,
    required this.batchModel,
  });

  final BatchController batchController = Get.put(BatchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          batchModel.batchName.tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
        actions: [
          GestureDetector(
            onTap: () {
              searchStudentsByName(context, batchModel.batchId);
            },
            child: Icon(Icons.search),
          ),
          kWidth20,
          GestureDetector(
            onTap: () {
              addStudentToBatch(context);
            },
            child: Icon(Icons.person_add),
          ),
          kWidth10
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<StudentModel>>(
              stream: batchController
                  .fetchFilteredStudents(batchController.batchId.value),
              builder: (context, studentSnapshot) {
                if (studentSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const LoadingWidget();
                }
                if (studentSnapshot.hasError) {
                  log('error : ${studentSnapshot.error}');
                  return Center(child: Text('Error: ${studentSnapshot.error}'));
                }
                if (studentSnapshot.data == null ||
                    studentSnapshot.data!.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Please add Students",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ),
                  );
                } else {
                  final students = studentSnapshot.data!;
                  return ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (BuildContext context, int index) {
                      final studentModel = students[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentProfile(
                                studentModel: studentModel,
                              ),
                            ),
                          );
                        },
                        child: BatchStudentDataList(data: studentModel),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> searchStudentsByName(
      BuildContext context, String bacthId) async {
    batchController.fetchFilteredStudents(bacthId);
    await showSearch(context: context, delegate: SearchStudentByName());
  }
}
