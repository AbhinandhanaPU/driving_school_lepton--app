

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/test_model/test_model.dart';
import 'package:new_project_app/view/users/teacher/teacher_pages/driving_test_tutor/data_list_tutor/alltest_studentlist_tutor.dart';
import 'package:new_project_app/view/users/teacher/teacher_pages/driving_test_tutor/data_list_tutor/tutor_list_test.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';

class TutorDrivingHomePage extends StatelessWidget {
  TutorDrivingHomePage({super.key});

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
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: server
                      .collection('DrivingSchoolCollection')
                      .doc(UserCredentialsController.schoolId)
                      .collection('DrivingTest')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final data = TestModel.fromMap(
                              snapshot.data!.docs[index].data());
                          return GestureDetector(
                            onTap: () {
                              log("Hai do you");
                              Get.to(()=>AllTestStudentListOfTutor(id: data,));
                              //AllTestStudentList(id: data,);
                            },
                            child: TutorDrivingTestList(data: data),
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
          // Positioned(
          //   bottom: 20,
          //   right: 20,
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.push(context, MaterialPageRoute(
          //         builder: (context) {
          //           return CreateTest();
          //         },
          //       ));
          //     },
          //     child: ButtonContainerWidget(
          //         curving: 30,
          //         colorindex: 0,
          //         height: 40,
          //         width: 140,
          //         child: const Center(
          //           child: TextFontWidgetRouter(
          //             text: 'Create Test',
          //             fontsize: 14,
          //             fontWeight: FontWeight.bold,
          //             color: cWhite,
          //           ),
          //         )),
          //   ),
          // )
        ],
      ),
    );
  }
}
