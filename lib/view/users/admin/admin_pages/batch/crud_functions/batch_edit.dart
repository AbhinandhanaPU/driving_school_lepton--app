import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/batch_controller/batch_controller.dart';
import 'package:new_project_app/model/batch_model/batch_model.dart';
import 'package:new_project_app/view/widgets/custom_show_dialogbox/custom_show_dialouge.dart';
import 'package:new_project_app/view/widgets/textformfeild_container/textformfiled_blue_container.dart';

editFunctionOfBatch(BuildContext context, BatchModel data) {

  BatchController batchController =Get.put(BatchController());

  customShowDilogBox(
      context: context,
      title: 'Edit',
      children: [
        Form(
          key: batchController.formKey,
          child: Column(
            children: [
              TextFormFiledHeightnoColor(
                validator: checkFieldEmpty,
                controller: batchController.batchNameController,
                hintText: data.batchName,
                title: 'name',
              ),
              
              TextFormFiledHeightnoColor(
                onTap: () async {
                  batchController.dateController.text =
                      await dateTimePicker(context);
                },
                validator: checkFieldDateIsValid,
                controller: batchController.dateController,
                keyboardType: TextInputType.none,
                hintText: data.date,
                title: 'Date',
              ),
            ],
          ),
        ),
      ],
      doyouwantActionButton: true,
      actiononTapfuction: () {
        if (batchController.formKey.currentState!.validate()) {
          batchController.updateBatch(
            data.batchId,
            context,
          );
        }
      },
      actiontext: 'Update');
}
