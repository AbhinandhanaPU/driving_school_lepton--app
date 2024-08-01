import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/test_controller/test_controller.dart';
import 'package:new_project_app/view/users/admin/admin_pages/courses/crud_functions/create_course.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/progess_button/progress_button.dart';

class CreateTest extends StatelessWidget {
  const CreateTest({super.key});

  @override
  Widget build(BuildContext context) {
     final TestController testController =
      Get.put(TestController());

    final createTestList = [
      TextFormFiledBlueContainerWidgetWithOutColor(
        title: 'Test Date',
        hintText: 'Test Date',
        formField: TextFormField(
          controller: testController.testDateController,
          decoration: InputDecoration(hintText: "Enter Test Date"),
          validator: checkFieldDateIsValid,
           onTap: () async {
            testController.testDateController.text =
                await dateTimePicker(context);
          },
        ),
      ),
      TextFormFiledBlueContainerWidgetWithOutColor(
        title: 'Test Time',
        hintText: 'Test Time',
        formField: TextFormField(
          controller: testController.testTimeController,
          decoration: InputDecoration(hintText: "Enter Test Time"),
          validator: checkFieldTimeIsValid,
          onTap: () async {
            testController.testTimeController.text =
                await timePicker(context);
          },
        ),
      ),
      TextFormFiledBlueContainerWidgetWithOutColor(
        title: 'Location',
        hintText: 'Location',
        formField: TextFormField(
          controller: testController.testLocationController,
          decoration: InputDecoration(hintText: "Enter Location"),
          validator: checkFieldEmpty,
         
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Obx(
          () => ProgressButtonWidget(
            function: () async {
              if (testController.formKey.currentState!.validate()) {
                testController.addTestDate()
                    //  .then((value) => Navigator.pop(context))
                    ;
              }
            },
            buttonstate: testController.buttonstate.value,
            text: 'Create Test',
          ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: screenContainerbackgroundColor,
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Create Driving Test".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 30),
        child: SingleChildScrollView(
          child: Form(
            key: testController.formKey,
            child: Column(
              children: createTestList,
            ),
          ),
        ),
      ),
    );
  }
}