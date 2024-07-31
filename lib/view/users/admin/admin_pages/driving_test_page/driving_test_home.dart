// import 'package:flutter/material.dart';
// import 'package:new_project_app/constant/colors/colors.dart';
// import 'package:new_project_app/view/users/admin/admin_pages/driving_test_page/driving_test_list.dart';
 
// import 'package:new_project_app/view/widgets/catagory_table_header_widget/catagory_table_header_widget.dart';

// class DrivingHomePage extends StatelessWidget {
//   const DrivingHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Driving Test'),
//         foregroundColor: cWhite,
//         backgroundColor: themeColor,
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Padding(
//           padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
//           child: Container(
//             height: 1200,
//             width: 600,
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10),
//                   child: Container(
//                     color: cWhite,
//                     height: 40,
//                     child: const Row(
//                       children: [
//                         Expanded(flex: 4, child: CatrgoryTableHeaderWidget(headerTitle: 'Name')),
//                         SizedBox(
//                           width: 2,
//                         ),
//                         Expanded(
//                             flex: 6, child: CatrgoryTableHeaderWidget(headerTitle: 'Joining Date')),
//                         SizedBox(
//                           width: 2,
//                         ),
//                         Expanded(
//                             flex: 6,
//                             child: CatrgoryTableHeaderWidget(headerTitle: 'Completed Days')),
//                         SizedBox(
//                           width: 2,
//                         ),
//                         Expanded(
//                             flex: 6, child: CatrgoryTableHeaderWidget(headerTitle: 'Test Date')),
//                         SizedBox(
//                           width: 2,
//                         ),
//                         Expanded(flex: 4, child: CatrgoryTableHeaderWidget(headerTitle: 'Review')),
//                         SizedBox(
//                           width: 2,
//                         ),
//                         Expanded(flex: 4, child: CatrgoryTableHeaderWidget(headerTitle: 'Result')),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   // Use Expanded to take up remaining space for the list
//                   child: Container(
//                     // width: 1200,
//                     decoration: BoxDecoration(
//                       color: cWhite,
//                       border: Border.all(color: cWhite),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 5, right: 5),
//                       child: ListView.separated(
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                             onTap: () {},
//                             child: DrivingTestStudentList(index: index
//                                 // data: data,
//                                 ),
//                           );
//                         },
//                         separatorBuilder: (context, index) {
//                           return const SizedBox(
//                             height: 2,
//                           );
//                         },
//                         itemCount: 2, // Replace this with the actual number of items
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/test_model/test_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/driving_test_page/CRUD/create_test.dart';
import 'package:new_project_app/view/users/admin/admin_pages/driving_test_page/data_list/alltest_studentlist.dart';
import 'package:new_project_app/view/users/admin/admin_pages/driving_test_page/data_list/list_test.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class DrivingHomePage extends StatelessWidget {
  DrivingHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Driving Test".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: server
                      .collection('DrivingSchoolCollection')
                      .doc(UserCredentialsController.schoolId)
                      .collection('DrivingTest')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final data = TestModel.fromMap(
                              snapshot.data!.docs[index].data());
                          return GestureDetector(
                            onTap: () {
                              log("Hai do you");
                              Get.to(()=>AllTestStudentList(id: data,));
                              //AllTestStudentList(id: data,);
                            },
                            child: DrivingTestList(data: data),
                          );
                        },
                      );
                    } else {
                      return const LoadingWidget();
                    }
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return CreateTest();
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
                      text: 'Create Test',
                      fontsize: 14,
                      fontWeight: FontWeight.bold,
                      color: cWhite,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
