// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/practice_shedule_controller/practice_shedule_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/practice_shedule_model/practice_shedule_model.dart';
import 'package:new_project_app/view/users/teacher/teacher_pages/practice_shedule_tutor/practice_schedule_tr/practice_shedule_list_tr.dart';
import 'package:new_project_app/view/users/teacher/teacher_pages/practice_shedule_tutor/students_list_tutor/practise_std_list_tr.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';

class TutorPracticeSheduleHome extends StatelessWidget {
  TutorPracticeSheduleHome({super.key});

  PracticeSheduleController practiceSheduleController =
      Get.put(PracticeSheduleController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Practical Schedule".tr,
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
                      .collection('PracticeSchedule')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final data = PracticeSheduleModel.fromMap(
                              snapshot.data!.docs[index].data());
                          return GestureDetector(
                            onTap: () {
                              practiceSheduleController.scheduleId.value =
                                  data.practiceId;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TutorPracticalStudentsList(data: data),
                                ),
                              );
                            },
                            child: TutorPracticeSheduleList(data: data),
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
          //           return CreateSlot();
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
          //             text: 'Create Slot',
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
