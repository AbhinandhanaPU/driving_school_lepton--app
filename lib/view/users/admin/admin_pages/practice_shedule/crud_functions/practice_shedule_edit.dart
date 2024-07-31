import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/practice_shedule_controller/practice_shedule_controller.dart';
import 'package:new_project_app/model/practice_shedule_model/practice_shedule_model.dart';
import 'package:new_project_app/view/widgets/custom_show_dialogbox/custom_show_dialouge.dart';
import 'package:new_project_app/view/widgets/textformfeild_container/textformfiled_blue_container.dart';

editFunctionOfPractice(BuildContext context, PracticeSheduleModel data) {
  final PracticeSheduleController practiceshedulecontroller =
      Get.put(PracticeSheduleController());

  customShowDilogBox(
      context: context,
      title: 'Edit',
      children: [
        Form(
          key: practiceshedulecontroller.formKey,
          child: Column(
            children: [
              TextFormFiledHeightnoColor(
                validator: checkFieldEmpty,
                controller: practiceshedulecontroller.practiceNameController,
                hintText: data.practiceName,
                title: 'name',
              ),
              TextFormFiledHeightnoColor(
                onTap: () async {
                  practiceshedulecontroller.startTimeController.text =
                      await timePicker(context);
                },
                validator: checkFieldTimeIsValid,
                controller: practiceshedulecontroller.startTimeController,
                keyboardType: TextInputType.none,
                hintText: data.startTime,
                title: 'start time',
              ),
              TextFormFiledHeightnoColor(
                onTap: () async {
                  practiceshedulecontroller.endTimeController.text =
                      await timePicker(context);
                },
                validator: checkFieldTimeIsValid,
                controller: practiceshedulecontroller.endTimeController,
                keyboardType: TextInputType.none,
                hintText: data.endTime,
                title: 'end time',
              ),
            ],
          ),
        ),
      ],
      doyouwantActionButton: true,
      actiononTapfuction: () {
        if (practiceshedulecontroller.formKey.currentState!.validate()) {
          practiceshedulecontroller.updatePractice(
            data.practiceId,
            context,
          );
        }
      },
      actiontext: 'Update');
}
