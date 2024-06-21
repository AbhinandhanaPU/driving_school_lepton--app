import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/teacher_controller/teacher_controller.dart';
import 'package:new_project_app/model/teacher_model/teacher_model.dart';
import 'package:new_project_app/view/widgets/progess_button/progress_button.dart';
import 'package:new_project_app/view/widgets/textformfeild_container/textformfiled_blue_container.dart';

class CreateTutor extends StatelessWidget {
  const CreateTutor({super.key});

  @override
  Widget build(BuildContext context) {
    final TeacherController teacherController = Get.put(TeacherController());

    final createTutorList = [
      TextFormFiledBlueContainerWidgetWithOutColor(
        controller: teacherController.teacherNameController,
        hintText: " Enter Tutor Name",
        title: 'Tutor  Name',
        validator: checkFieldEmpty,
      ), /////////////////////////...........................0....................name
      TextFormFiledBlueContainerWidgetWithOutColor(
        controller: teacherController.teacherPhoneNumeber,
        hintText: " Enter Tutor Ph",
        title: 'Phone Number',
        validator: checkFieldPhoneNumberIsValid,
      ), //////////////////1....................number...................
      TextFormFiledBlueContainerWidgetWithOutColor(
        controller: teacherController.teacherEmailController,
        hintText: " Enter Tutor Email",
        title: 'Tutor Email',
        validator: checkFieldEmailIsValid,
      ), ///////////////////4.......................
      Obx(
        () => ProgressButtonWidget(
            function: () async {
              if (teacherController.formKey.currentState!.validate()) {
                teacherController
                    .createNewTeacher(TeacherModel(
                      teacherName: teacherController.teacherNameController.text,
                      teacheremail:
                          teacherController.teacherEmailController.text,
                      phoneNumber:
                          teacherController.teacherPhoneNumeber.text.trim(),
                    ))
                    .then((value) => Get.back());
              }
            },
            buttonstate: teacherController.buttonstate.value,
            text: 'Create Teacher '),
      ),
    ];

    return SafeArea(
      child: Scaffold(
          backgroundColor: screenContainerbackgroundColor,
          appBar: AppBar(
            title: Row(
              children: [
                Text("Create Tutor".tr),
              ],
            ),
            backgroundColor: themeColor,
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, top: 30),
            child: Form(
              key: teacherController.formKey,
              child: Column(
                children: [
                  createTutorList[0],
                  createTutorList[1],
                  createTutorList[2],
                  createTutorList[3],
                ],
              ),
            ),
          )),
    );
  }
}
