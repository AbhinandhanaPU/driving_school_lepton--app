import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/view/users/admin/admin_pages/all_tutors/create_new_tutor.dart';
import 'package:new_project_app/view/users/admin/admin_pages/all_tutors/tutor_profile.dart';
import 'package:new_project_app/view/users/admin/admin_pages/driving_test_page/driving_test_list.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';
import 'package:new_project_app/view/widgets/catagory_table_header_widget/catagory_table_header_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class AllTutorsHomePage extends StatelessWidget {
  const AllTutorsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Tutors'),
          foregroundColor: cWhite,
          backgroundColor: themeColor,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                child: Container(
                  height: 1200,
                  width: 600,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          color: cWhite,
                          height: 40,
                          child: const Row(
                            children: [
                              Expanded(
                                  flex: 4, child: CatrgoryTableHeaderWidget(headerTitle: 'Name')),
                              SizedBox(
                                width: 2,
                              ),
                              Expanded(
                                  flex: 6,
                                  child: CatrgoryTableHeaderWidget(headerTitle: 'Joining Date')),
                              SizedBox(
                                width: 2,
                              ),
                              Expanded(
                                  flex: 6,
                                  child: CatrgoryTableHeaderWidget(headerTitle: 'Completed Days')),
                              SizedBox(
                                width: 2,
                              ),
                              Expanded(
                                  flex: 6,
                                  child: CatrgoryTableHeaderWidget(headerTitle: 'Test Date')),
                              SizedBox(
                                width: 2,
                              ),
                              Expanded(
                                  flex: 4, child: CatrgoryTableHeaderWidget(headerTitle: 'Review')),
                              SizedBox(
                                width: 2,
                              ),
                              Expanded(
                                  flex: 4, child: CatrgoryTableHeaderWidget(headerTitle: 'Result')),
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
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return TutorProfile();
                                      },
                                    ));
                                  },
                                  child: DrivingTestStudentList(index: index
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
            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return CreateTutor();
                    },
                  ));
                },
                child: ButtonContainerWidget(
                    curving: 30,
                    colorindex: 0,
                    height: 40,
                    width: 140,
                    child: const Center(
                      child: TextFontWidgetRouter(
                        text: 'Create Tutor',
                        fontsize: 14,
                        fontWeight: FontWeight.bold,
                        color: cWhite,
                      ),
                    )),
              ),
            )
          ],
        ));
  }
}
