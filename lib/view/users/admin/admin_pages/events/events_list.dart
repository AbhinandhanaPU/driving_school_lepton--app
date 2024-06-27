import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/view/users/admin/admin_pages/events/events_tab.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';  

class EventList extends StatelessWidget {
   const EventList({super.key,});

  @override
  Widget build(BuildContext context) {
    return 
    // DefaultTabController(
    //   length: 2,
    //   child:
       Scaffold(
        appBar: AppBar(
          foregroundColor: cWhite,
          title: Row(
            children: [
              // IconButtonBackWidget(),
              SizedBox(
                width: 20.w,
              ),
              Text("Events".tr),
            ],
          ),
          flexibleSpace: const AppBarColorWidget(),
          // backgroundColor: adminePrimayColor,
          // bottom: TabBar(tabs: [
          //   Tab(
          //     text: 'Class Level'.tr,
          //   ),
          //   Tab(
          //     text: 'School Level'.tr,
          //   )
          // ]),
        ),

        //  appBar: AppBar(backgroundColor: adminePrimayColor),
        body: 
        const SafeArea(
          child:
          //  TabBarView(
          //   children: [ClassLevelPage(), 
            SchoolLevelPage()
          //   ],
          // ),
        ),
     // ),
    );
  }
}
