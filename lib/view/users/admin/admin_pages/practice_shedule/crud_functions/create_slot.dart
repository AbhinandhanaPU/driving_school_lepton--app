import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/practice_shedule_controller/practice_shedule_controller.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/progess_button/progress_button.dart';

class CreateSlot extends StatelessWidget {
  const CreateSlot({super.key});

  @override
  Widget build(BuildContext context) {
    PracticeSheduleController practiceshedulecontroller =
        Get.put(PracticeSheduleController());

    final createTutorList = [
      TextFormFiledBlueContainerWidgetWithOutColor(
        title: 'Slot Name',
        hintText: 'Slot Name',
        formField: TextFormField(
          controller: practiceshedulecontroller.practiceNameController,
          decoration: InputDecoration(hintText: "Enter Slot Name"),
          validator: checkFieldEmpty,
        ),
      ),
      TextFormFiledBlueContainerWidgetWithOutColor(
        title: 'Start Time',
        hintText: 'Start Time',
        formField: TextFormField(
          controller: practiceshedulecontroller.startTimeController,
          decoration: InputDecoration(hintText: "Enter Start Time"),
          validator: checkFieldTimeIsValid,
          onTap: () async {
            practiceshedulecontroller.startTimeController.text =
                await timePicker(context);
          },
        ),
      ),
      TextFormFiledBlueContainerWidgetWithOutColor(
        title: 'End Time',
        hintText: 'End Time',
        formField: TextFormField(
          controller: practiceshedulecontroller.endTimeController,
          decoration: InputDecoration(hintText: "Enter End Time"),
          validator: checkFieldTimeIsValid,
          onTap: () async {
            practiceshedulecontroller.endTimeController.text =
                await timePicker(context);
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Obx(
          () => ProgressButtonWidget(
            function: () async {
              if (practiceshedulecontroller.formKey.currentState!.validate()) {
                practiceshedulecontroller.createPracticeShedule()
                    //  .then((value) => Navigator.pop(context))
                    ;
              }
            },
            buttonstate: practiceshedulecontroller.buttonstate.value,
            text: 'Create Practice',
          ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: screenContainerbackgroundColor,
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Create Course".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 30),
        child: SingleChildScrollView(
          child: Form(
            key: practiceshedulecontroller.formKey,
            child: Column(
              children: createTutorList,
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
