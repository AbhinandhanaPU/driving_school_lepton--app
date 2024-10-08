import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/controller/practice_shedule_controller/practice_shedule_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/all_students/student_profile.dart';
import 'package:new_project_app/view/users/admin/admin_pages/practice_shedule/students_list/practise_std_datalist.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class SearchStudentByNamePS extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(
          Icons.clear,
          color: Colors.black,
        ));
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<StudentModel> suggestionList;

    if (query.isEmpty) {
      suggestionList = Get.find<PracticeSheduleController>().studentList;
    } else {
      suggestionList = Get.find<PracticeSheduleController>()
          .studentList
          .where((item) =>
              item.studentName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    if (suggestionList.isEmpty) {
      return ListTile(
        title: GooglePoppinsWidgets(
          text: "User not found",
          fontsize: 18,
          fontWeight: FontWeight.w400,
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (context, index) {
            final data = suggestionList[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentProfile(
                      studentModel: data,
                    ),
                  ),
                );
              },
              child: PracticeStudentDataList(data: data),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: suggestionList.length,
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }
}
