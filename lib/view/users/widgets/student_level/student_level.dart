import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/controller/course_controller/course_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';

class StudentLevelDropDown extends StatefulWidget {
  final StudentModel data;
  final String courseID;
  final String? level;

  const StudentLevelDropDown({
    super.key,
    required this.data,
    required this.courseID,
    this.level,
  });

  @override
  State<StudentLevelDropDown> createState() => _StudentLevelDropDownState();
}

class _StudentLevelDropDownState extends State<StudentLevelDropDown> {
  CourseController courseController = Get.put(CourseController());
  String? selectStdLevel;

  @override
  void initState() {
    super.initState();
    // Set selectStdLevel to feeData if it's not null and valid; otherwise, set it to null
    if (['beginner', 'intermediate', 'advanced'].contains(widget.level)) {
      selectStdLevel = widget.level;
    } else {
      selectStdLevel = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectStdLevel,
      hint: Text('Choose Level'),
      decoration: const InputDecoration(
        border: InputBorder.none,
        filled: false,
      ),
      items: const [
        DropdownMenuItem(
          value: 'beginner',
          child: Text('Beginner'),
        ),
        DropdownMenuItem(
          value: 'intermediate',
          child: Text('Intermediate'),
        ),
        DropdownMenuItem(
          value: 'advanced',
          child: Text('Advanced'),
        ),
      ],
      onChanged: (val) {
        if (val != null) {
          log('Selected user type: $val');
          setState(() {
            widget.data.level = val;
          });
          courseController.updateStudentLevel(
            widget.data,
            val,
            widget.courseID,
          );
        }
      },
    );
  }
}
