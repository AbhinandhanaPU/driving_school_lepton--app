import 'package:flutter/material.dart';

import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/utils.dart';

import 'package:new_project_app/view/users/student/drawer/student_header_drawer.dart';
import 'package:new_project_app/view/users/student/student_home_page/student_dashboard.dart';

class StudentsMainHomeScreen extends StatefulWidget {
   StudentsMainHomeScreen({super.key});

  @override
  State<StudentsMainHomeScreen> createState() => _StudentsMainHomeScreenState();
}

class _StudentsMainHomeScreenState extends State<StudentsMainHomeScreen> {
  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onbackbuttonpressed(context),
      child: Scaffold(
        appBar: AppBar(
            // flexibleSpace: const AppBarColorWidget(),
            foregroundColor: cWhite,
            title: const Text("Driving School"),
            backgroundColor: themeColor),
        body:    StudentDashboard(),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const StudentsHeaderDrawer(),
                MyDrawerList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
