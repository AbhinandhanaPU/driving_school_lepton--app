import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/view/users/teacher/drawer/teacher_header_drawer.dart';
import 'package:new_project_app/view/users/teacher/teacher_home_page/teacher_dashboard.dart';

class TeachersMainHomeScreen extends StatefulWidget {
  const TeachersMainHomeScreen({super.key});

  @override
  State<TeachersMainHomeScreen> createState() => _TeachersMainHomeScreenState();
}

class _TeachersMainHomeScreenState extends State<TeachersMainHomeScreen> {
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
        body: const TeacherDashboard(),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TeacherHeaderDrawer(),
                MyDrawerList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
