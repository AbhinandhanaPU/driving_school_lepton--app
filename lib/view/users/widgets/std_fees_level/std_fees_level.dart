import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/controller/student_controller/student_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/users/widgets/std_fees_level/fee_edit_popup.dart';

class StdFeesLevelDropDown extends StatefulWidget {
  final StudentModel data;
  final String courseID;
  final String feeData;

  const StdFeesLevelDropDown({
    super.key,
    required this.data,
    required this.courseID,
    required this.feeData,
  });

  @override
  State<StdFeesLevelDropDown> createState() => _StdFeesLevelDropDownState();
}

class _StdFeesLevelDropDownState extends State<StdFeesLevelDropDown> {
  StudentController studentController = Get.put(StudentController());
  String? selectStdLevel;

  @override
  void initState() {
    super.initState();
    selectStdLevel = widget.feeData;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectStdLevel,
      hint: Text(widget.feeData),
      decoration: const InputDecoration(
        border: InputBorder.none,
        filled: false,
      ),
      items: const [
        DropdownMenuItem(
          value: 'partly paid',
          child: Text('Partly paid'),
        ),
        DropdownMenuItem(
          value: 'fully paid',
          child: Text('Fully paid'),
        ),
        DropdownMenuItem(
          value: 'not paid',
          child: Text('Not paid'),
        ),
      ],
      onChanged: (val) {
        if (val != null) {
          setState(() {
            selectStdLevel = val;
          });
          if (val == 'partly paid') {
            pendingAmountFunction(
              context,
              widget.data,
              val,
              widget.courseID,
            );
          } else {
            studentController.addStudentFeeColl(
                widget.data, val, widget.courseID);
          }
        }
      },
    );
  }
}
