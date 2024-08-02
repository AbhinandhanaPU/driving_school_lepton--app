import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/batch_controller/batch_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/batch_model/batch_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/all_students/student_profile.dart';
import 'package:new_project_app/view/users/admin/admin_pages/batch/crud_functions/search_student_name.dart';
import 'package:new_project_app/view/users/admin/admin_pages/batch/students_list/students_datalist.dart';
import 'package:new_project_app/view/users/admin/admin_pages/practice_shedule/crud_functions/add_std_practise.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class BatchStudentsList extends StatelessWidget {
  final BatchModel data;

  BatchStudentsList({
    super.key,
    required this.data,
  });
  
final  BatchController batchController =Get.put(BatchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Students List".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
        actions: [
          GestureDetector(
            onTap: () {
              searchStudentsByName(context, data.batchId);
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
                child: StreamBuilder(
                  stream: server
                      .collection('DrivingSchoolCollection')
                      .doc(UserCredentialsController.schoolId)
                      .collection('Batch')
                      .doc(data.batchId)
                      .collection('Students')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingWidget();
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: TextFontWidget(
                          text: 'No students found',
                          fontsize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    } else {
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
                            child: StudentDataList(
                              data: data,
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
      BuildContext context, String bacthId) async {
    batchController.fetchTotalStudents(bacthId);
    await showSearch(context: context, delegate: SearchStudentByName());
  }
}
