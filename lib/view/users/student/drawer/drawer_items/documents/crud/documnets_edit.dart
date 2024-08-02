import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/documents_controller/documents_controller.dart';
import 'package:new_project_app/view/widgets/custom_show_dialogbox/custom_show_dialouge.dart';
import 'package:new_project_app/view/widgets/textformfeild_container/textformfiled_blue_container.dart';

editFunctionOfDocuments(BuildContext context, Map<String, dynamic> data) {
  final DocumentsController documentsController =
      Get.put(DocumentsController());

  customShowDilogBox(
      context: context,
      title: 'Edit',
      children: [
        Form(
          key: documentsController.formKey,
          child: Column(
            children: [
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: documentsController.titleController,
                  hintText: data['title'],
                  title: 'Name'),
              kHeight10,
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: documentsController.desController,
                  hintText: data['des'],
                  title: 'Description'),
              kHeight10,
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: documentsController.cateController,
                  hintText: data['category'],
                  title: 'Category'),
            ],
          ),
        ),
      ],
      doyouwantActionButton: true,
      actiononTapfuction: () {
        if (documentsController.formKey.currentState!.validate()) {
          documentsController.updateDocuments(
            data['docId'],
            context,
          );
        }
      },
      actiontext: 'Update');
}
