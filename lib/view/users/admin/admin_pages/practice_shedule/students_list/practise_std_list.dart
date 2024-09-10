import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/controller/practice_shedule_controller/practice_shedule_controller.dart';
import 'package:new_project_app/model/practice_shedule_model/practice_shedule_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/all_students/student_profile.dart';
import 'package:new_project_app/view/users/admin/admin_pages/practice_shedule/crud_functions/add_std_practise.dart';
import 'package:new_project_app/view/users/admin/admin_pages/practice_shedule/crud_functions/search_student_name.dart';
import 'package:new_project_app/view/users/admin/admin_pages/practice_shedule/students_list/practise_std_datalist.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class PracticalStudentsList extends StatelessWidget {
  final PracticeSheduleModel dataModel;

  PracticalStudentsList({
    super.key,
    required this.dataModel,
  });
  final PracticeSheduleController practiceSheduleController =
      Get.put(PracticeSheduleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          dataModel.practiceName,
        ),
        flexibleSpace: const AppBarColorWidget(),
        actions: [
          GestureDetector(
            onTap: () {
              searchStudentsByName(context, dataModel.practiceId);
            },
            child: Icon(Icons.search),
          ),
          kWidth20,
          GestureDetector(
            onTap: () {
              addStudentToPractise(context);
            },
            child: Icon(Icons.person_add),
          ),
          kWidth10
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: StreamBuilder<List<StudentModel>>(
                  stream: practiceSheduleController
                      .fetchStudentsWithStatusTrue(dataModel.practiceId),
                  builder: (context, studentSnapshot) {
                    if (studentSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const LoadingWidget();
                    }
                    if (studentSnapshot.hasError) {
                      return Center(
                        child:
                            Text('Error: ${studentSnapshot.error.toString()}'),
                      );
                    }
                    final students = studentSnapshot.data ?? [];
                    if (students.isEmpty) {
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
                      return ListView.builder(
                        itemCount: students.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StudentProfile(
                                    studentModel: students[index],
                                  ),
                                ),
                              );
                            },
                            child: PracticeStudentDataList(
                              data: students[index],
                            ),
                          );
                        },
                      );
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
              onTap: () {},
              child: ButtonContainerWidgetRed(
                curving: 30,
                height: 40,
                width: 180,
                child: const Center(
                  child: TextFontWidgetRouter(
                    text: 'Send Notification',
                    fontsize: 14,
                    fontWeight: FontWeight.bold,
                    color: cWhite,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> searchStudentsByName(
      BuildContext context, String practiceId) async {
    practiceSheduleController.fetchStudentsWithStatusTrue(practiceId);
    await showSearch(context: context, delegate: SearchStudentByNamePS());
  }
}
