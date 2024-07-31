import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_app/controller/course_controller/course_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';


class AllStudentDropDown extends StatelessWidget {
  AllStudentDropDown({super.key});

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
      itemAsString: (value) =>
          'Name : ${value.studentName}  ID NO :  ${value.licenceNumber}',
      onChanged: (value) async {
        if (value != null) {
          courseCntrl.studentName.value = value.studentName;
          courseCntrl.studentDocID.value = value.docid;
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
