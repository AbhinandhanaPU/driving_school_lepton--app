import 'package:flutter/material.dart';
 import 'package:new_project_app/constant/utils/validations.dart'; 
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';
import 'package:new_project_app/view/widgets/textformfeild_container/textformfiled_blue_container.dart';

createTeacherFunction(BuildContext context) {
  // final TeacherController teacherController = Get.put(TeacherController());
  final createTeacherList = [
    TextFormFiledBlueContainerWidgetWithOutColor(
      // controller: teacherController.teacherNameController,
      hintText: " Enter Teacher Name",
      title: 'Teacher  Name',
      validator: checkFieldEmpty,
    ), /////////////////////////...........................0....................name
    TextFormFiledBlueContainerWidgetWithOutColor(
      // controller: teacherController.teacherPhoneNumeber,
      hintText: " Enter Teacher  Ph",
      title: 'Phone Number',
      validator: checkFieldPhoneNumberIsValid,
    ), //////////////////1....................number...................
    TextFormFiledBlueContainerWidgetWithOutColor(
      // controller: teacherController.teacherEmailController,
      hintText: " Enter Employee Email",
      title: 'Employee Email',
      validator: checkFieldEmpty,
    ), ///////////////////4.......................
    // Obx(() => ProgressButtonWidget(
    //     function: () async {
    //     //   if (teacherController.formKey.currentState!.validate()) {
    //     //     teacherController
    //     //         .createNewTeacher(TeacherModel(
    //     //           teacherName: teacherController.teacherNameController.text,
    //     //           teacheremail: teacherController.teacherEmailController.text,
    //     //           phoneNumber: teacherController.teacherPhoneNumeber.text.trim(),
    //     //         ))
    //     //         .then((value) => Get.back());
    //     //   }
    //     // },
    //     buttonstate: teacherController.buttonstate.value,
    //     text: 'Create Teacher ')),
  ];
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BackButtonContainerWidget(),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextFontWidget(
                text: "Create Teacher ",
                fontsize: 15,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        content: SizedBox(
          height: 380,
          width: 300,
          child: Form(
            // key: teacherController.formKey,
            child: Column(
              children: [
                createTeacherList[0],
                createTeacherList[1],
                createTeacherList[2],
                createTeacherList[3],
              ],
            ),
          ),
        ),
      );
    },
  );
}
