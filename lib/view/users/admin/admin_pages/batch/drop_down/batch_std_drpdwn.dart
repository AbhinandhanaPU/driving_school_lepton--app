import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_app/controller/course_controller/course_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';

class AllStudentDropDownBatch extends StatelessWidget {
  final Function(StudentModel?)? onChanged;
  AllStudentDropDownBatch({super.key, this.onChanged});

  final courseCntrl = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Center(
        child: DropdownSearch<StudentModel>(
      validator: (item) {
        if (item == null) {
          return "Required field";
        } else {
          return null;
        }
      },
      asyncItems: (value) {
        courseCntrl.allstudentList.clear();

        return courseCntrl.fetchAllStudents();
      },
       itemAsString: (StudentModel student) => student.studentName,
      onChanged: (StudentModel? student) {
        if (onChanged != null) {
          onChanged!(student);
        }
      },
      popupProps: const PopupProps.menu(
          searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                  hintText: "Search Student", border: OutlineInputBorder())),
          showSearchBox: true,
          searchDelay: Duration(microseconds: 10)),
      dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: GoogleFonts.poppins(
              fontSize: 13, color: Colors.black.withOpacity(0.7))),
    ));
  }
}
