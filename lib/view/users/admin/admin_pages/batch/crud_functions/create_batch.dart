import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/batch_controller/batch_controller.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/progess_button/progress_button.dart';

class CreateBatch extends StatelessWidget {
  const CreateBatch({super.key});

  @override
  Widget build(BuildContext context) {
  BatchController batchController =Get.put(BatchController());

    final createBatchList = [
      TextFormFiledBlueContainerWidgetWithOutColor(
        title: 'Batch Name',
        hintText: 'Batch Name',
        formField: TextFormField(
          controller: batchController.batchNameController,
          decoration: InputDecoration(hintText: "Enter Batch Name"),
          validator: checkFieldEmpty,
        ),
      ),
      
      TextFormFiledBlueContainerWidgetWithOutColor(
        title: 'Date',
        hintText: 'Date',
        formField: TextFormField(
          controller: batchController.dateController,
          decoration: InputDecoration(hintText: "Enter Date"),
          validator: checkFieldDateIsValid,
          onTap: () async {
            batchController.dateController.text =
                await dateTimePicker(context);
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Obx(
          () => ProgressButtonWidget(
            function: () async {
              if (batchController.formKey.currentState!.validate()) {
                batchController.createBatch()
                    //  .then((value) => Navigator.pop(context))
                    ;
              }
            },
            buttonstate: batchController.buttonstate.value,
            text: 'Create Batch',
          ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: screenContainerbackgroundColor,
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Create Batch".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 30),
        child: SingleChildScrollView(
          child: Form(
            key: batchController.formKey,
            child: Column(
              children: createBatchList,
            ),
          ),
        ),
      ),
    );
  }
}

class TextFormFiledBlueContainerWidgetWithOutColor extends StatelessWidget {
  final String hintText;
  final String title;
  final Widget formField;

  const TextFormFiledBlueContainerWidgetWithOutColor({
    super.key,
    required this.hintText,
    required this.title,
    required this.formField,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: formField,
        ),
      ],
    );
  }
}
