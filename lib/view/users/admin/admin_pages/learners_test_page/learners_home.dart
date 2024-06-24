import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/view/users/admin/admin_pages/learners_test_page/student_list.dart';
 
import 'package:new_project_app/view/widgets/catagory_table_header_widget/catagory_table_header_widget.dart';

class LearnersHomePage extends StatelessWidget {
  const LearnersHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learners Home'),
        foregroundColor: cWhite,
        backgroundColor: themeColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Container(
            height: 1200,
            width: 400,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    color: cWhite,
                    height: 40,
                    child: const Row(
                      children: [
                        Expanded(flex: 4, child: CatrgoryTableHeaderWidget(headerTitle: 'Name')),
                        SizedBox(
                          width: 2,
                        ),
                        Expanded(
                            flex: 6, child: CatrgoryTableHeaderWidget(headerTitle: 'Joining Date')),
                        SizedBox(
                          width: 2,
                        ),
                        Expanded(
                            flex: 4, child: CatrgoryTableHeaderWidget(headerTitle: 'Test Date')),
                        SizedBox(
                          width: 2,
                        ),
                        Expanded(flex: 4, child: CatrgoryTableHeaderWidget(headerTitle: 'Result')),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  // Use Expanded to take up remaining space for the list
                  child: Container(
                     
                    // width: 1200,
                    decoration: BoxDecoration(
                      color: cWhite,
                      border: Border.all(color: cWhite),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: LearnersStudentList(index: index
                                // data: data,
                                ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 2,
                          );
                        },
                        itemCount: 2, // Replace this with the actual number of items
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
