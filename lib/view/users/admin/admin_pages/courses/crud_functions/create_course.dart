import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/course_controller/course_controller.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/progess_button/progress_button.dart';

class CreateCourses extends StatelessWidget {
  const CreateCourses({super.key});

  @override
  Widget build(BuildContext context) {
    CourseController courseController = Get.put(CourseController());

    final createTutorList = [
      TextFormFiledBlueContainerWidgetWithOutColor(
        hintText: "Enter course Name",
        title: 'Course Name',
        formField: TextFormField(
          controller: courseController.coursenameController,
          decoration: InputDecoration(hintText: "Enter course Name"),
          validator: checkFieldEmpty,
        ),
      ),
      TextFormFiledBlueContainerWidgetWithOutColor(
        hintText: "Enter Duration",
        title: 'Duration',
        formField: TextFormField(
          controller: courseController.courseDurationController,
          decoration: InputDecoration(hintText: "Enter Duration"),
          validator: checkFieldEmpty,
        ),
      ),
      TextFormFiledBlueContainerWidgetWithOutColor(
        hintText: "Enter Fee",
        title: 'Fee',
        formField: TextFormField(
          controller: courseController.courseFeeController,
          decoration: InputDecoration(hintText: "Enter Fee"),
          validator: checkFieldEmpty,
        ),
      ),
      TextFormFiledBlueContainerWidgetWithOutColor(
        hintText: "Enter Description",
        title: 'Description',
        formField: TextFormField(
          controller: courseController.courseDesController,
          decoration: InputDecoration(hintText: "Enter Description"),
          validator: checkFieldEmpty,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Obx(
          () => ProgressButtonWidget(
              function: () async {
                if (courseController.formKey.currentState!.validate()) {
                  courseController
                      .createCourses()
                      .then((value) => Navigator.pop(context));
                }
              },
              buttonstate: courseController.buttonstate.value,
              text: 'Create Courses'),
        ),
      ),
    ];

    return SafeArea(
      child: Scaffold(
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
              key: courseController.formKey,
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
