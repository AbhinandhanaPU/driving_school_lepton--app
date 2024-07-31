import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/test_controller/test_controller.dart';
import 'package:new_project_app/model/test_model/test_model.dart';
import 'package:new_project_app/view/widgets/custom_show_dialogbox/custom_show_dialouge.dart';
import 'package:new_project_app/view/widgets/textformfeild_container/textformfiled_blue_container.dart';

editFunctionOfTest(BuildContext context, TestModel data) {
  final TestController testController =
      Get.put(TestController());

  customShowDilogBox(
      context: context,
      title: 'Edit',
      children: [
        Form(
          key: testController.formKey,
          child: Column(
            children: [
              TextFormFiledHeightnoColor(
                 onTap: () async {
                    testController.testDateEditController.text =
                        await dateTimePicker(context);
                  },
                validator: checkFieldEmpty,
                controller: testController.testDateEditController,
                hintText: data.testDate,
                title: 'Test Date',
              ),
              TextFormFiledHeightnoColor(
                onTap: () async {
                  testController.testTimeEditController.text =
                      await timePicker(context);
                },
                validator: checkFieldTimeIsValid,
                controller: testController.testTimeEditController,
                keyboardType: TextInputType.none,
                hintText: data.testTime,
                title: 'start time',
              ),
              TextFormFiledHeightnoColor(
                validator: checkFieldTimeIsValid,
                controller: testController.testLocationEditController,
                hintText: data.location,
                title: 'Location',
              ),
            ],
          ),
        ),
      ],
      doyouwantActionButton: true,
      actiononTapfuction: () {
        if (testController.formKey.currentState!.validate()) {
          testController.editTest(
            data.docId,
            context,
          );
        }
      },
      actiontext: 'Update');
}
