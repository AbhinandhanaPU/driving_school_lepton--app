// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/batch_controller/batch_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/batch_model/batch_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/batch/batch_files/batch_list.dart';
import 'package:new_project_app/view/users/admin/admin_pages/batch/crud_functions/create_batch.dart';
import 'package:new_project_app/view/users/admin/admin_pages/batch/students_list/students_list.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class BatchHome extends StatelessWidget {
  BatchHome({super.key});

  BatchController batchController =Get.put(BatchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "All Batch".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: server
                      .collection('DrivingSchoolCollection')
                      .doc(UserCredentialsController.schoolId)
                      .collection('Batch')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final data= BatchModel.fromMap(
                              snapshot.data!.docs[index].data());
                          return GestureDetector(
                            onTap: () {
                              batchController.batchId.value =
                                  data.batchId;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BatchStudentsList(data: data),
                                ),
                              );
                            },
                            child: BatchList(data: data),
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
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return CreateBatch();
                  },
                ));
              },
              child: ButtonContainerWidget(
                  curving: 30,
                  colorindex: 0,
                  height: 40,
                  width: 140,
                  child: const Center(
                    child: TextFontWidgetRouter(
                      text: 'Create Batch',
                      fontsize: 14,
                      fontWeight: FontWeight.bold,
                      color: cWhite,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
