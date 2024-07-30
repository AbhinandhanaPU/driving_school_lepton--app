import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/study_materials/study_materials_controller.dart';
import 'package:new_project_app/view/widgets/custom_show_dialogbox/custom_show_dialouge.dart';
import 'package:new_project_app/view/widgets/textformfeild_container/textformfiled_blue_container.dart';

editFunctionOfSM(BuildContext context, Map<String, dynamic> data) {
  final StudyMaterialController StudyMController =
      Get.put(StudyMaterialController());

  customShowDilogBox(
      context: context,
      title: 'Edit',
      children: [
        Form(
          key: StudyMController.formKey,
          child: Column(
            children: [
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: StudyMController.studyMTitleController,
                  hintText: data['title'],
                  title: 'Name'),
              kHeight10,
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: StudyMController.studyMDesController,
                  hintText: data['des'],
                  title: 'Description'),
              kHeight10,
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: StudyMController.studyMCateController,
                  hintText: data['category'],
                  title: 'Category'),
            ],
          ),
        ),
      ],
      doyouwantActionButton: true,
      actiononTapfuction: () {
        if (StudyMController.formKey.currentState!.validate()) {
          StudyMController.updateSM(
            data['docId'],
            context,
          );
        }
      },
      actiontext: 'Update');
}
