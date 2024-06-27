import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/view/widgets/progess_button/progress_button.dart';
import 'package:progress_state_button/progress_button.dart';

class CreateTest extends StatelessWidget {
  const CreateTest({super.key});

  @override
  Widget build(BuildContext context) {
    final tutorNames = ['Tutor 1', 'Tutor 2', 'Tutor 3'];

    final createTutorList = [
      TextFormFiledBlueContainerWidgetWithOutColor(
        hintText: "Enter course Name",
        title: 'Course Name',
        validator: checkFieldEmpty,
        formField: TextFormField(
          decoration: InputDecoration(hintText: "Enter course Name"),
          validator: checkFieldEmpty,
        ),
      ),
      TextFormFiledBlueContainerWidgetWithOutColor(
        hintText: "Select Tutor Name",
        title: 'Tutor Name',
        validator: checkFieldPhoneNumberIsValid,
        formField: DropdownButtonFormField<String>(
          decoration: InputDecoration(hintText: "Select Tutor Name"),
          items: tutorNames.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {},
          validator: (value) => value == null ? 'Please select a tutor' : null,
        ),
      ),
      TextFormFiledBlueContainerWidgetWithOutColor(
        hintText: "Enter Duration",
        title: 'Tutor Email',
        validator: checkFieldEmailIsValid,
        formField: TextFormField(
          decoration: InputDecoration(hintText: "Enter Duration"),
          validator: checkFieldEmailIsValid,
        ),
      ),
      TextFormFiledBlueContainerWidgetWithOutColor(
        hintText: "Enter Fee",
        title: 'Fee',
        validator: checkFieldEmailIsValid,
        formField: TextFormField(
          decoration: InputDecoration(hintText: "Enter Fee"),
          validator: checkFieldEmailIsValid,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 30),
        child: ProgressButtonWidget(
          text: 'Create Test',
          function: () {
            print("Create Test button pressed");
          },
          buttonstate: ButtonState.idle, // Ensure buttonstate is not null
        ),
      ),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: screenContainerbackgroundColor,
        appBar: AppBar(
          title: Row(
            children: [
              Text("Create Test".tr),
            ],
          ),
          backgroundColor: themeColor,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18, top: 30),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: createTutorList,
              ),
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
  final String? Function(String?) validator;
  final Widget formField;

  const TextFormFiledBlueContainerWidgetWithOutColor({
    super.key,
    required this.hintText,
    required this.title,
    required this.validator,
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
