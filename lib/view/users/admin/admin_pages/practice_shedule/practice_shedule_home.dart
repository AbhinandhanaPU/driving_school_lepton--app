import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/view/users/admin/admin_pages/practice_shedule/practice_shedule_list.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';
import 'package:new_project_app/view/widgets/catagory_table_header_widget/catagory_table_header_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class PracticeSheduleHome extends StatelessWidget {
  const PracticeSheduleHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice Shedule'),
        foregroundColor: cWhite,
        backgroundColor: themeColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Container(
            height: 1200,
            width: 700,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // BackButton(),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(
                        //   builder: (context) {
                        //     return CreateTutor();
                        //   },
                        // ));
                      },
                      child: ButtonContainerWidgetRed(
                          curving: 30,
                          colorindex: 0,
                          height: 40,
                          width: 140,
                          child: const Center(
                            child: TextFontWidgetRouter(
                              text: 'Send Notification',
                              fontsize: 14,
                              fontWeight: FontWeight.bold,
                              color: cWhite,
                            ),
                          )),
                    ),
                  ],
                ),
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
                            flex: 6,
                            child: CatrgoryTableHeaderWidget(headerTitle: 'Shedule Practice')),
                        SizedBox(
                          width: 2,
                        ),
                        Expanded(
                            flex: 6,
                            child: CatrgoryTableHeaderWidget(headerTitle: 'Practice Completed')),
                        SizedBox(
                          width: 2,
                        ),
                        Expanded(
                            flex: 6,
                            child: CatrgoryTableHeaderWidget(headerTitle: 'Practice pending')),
                        SizedBox(
                          width: 2,
                        ),
                        Expanded(
                            flex: 6,
                            child: CatrgoryTableHeaderWidget(headerTitle: 'Practice Status')),
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
                            child: PracticeSheduleList(index: index
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
