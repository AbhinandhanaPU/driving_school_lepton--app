import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/view/users/admin/drawer/admin_header_drawer.dart';
import 'package:new_project_app/view/users/admin/admin_home_page/admin_dashboard.dart';
 
class AdminMainHomeScreen extends StatefulWidget {
  const AdminMainHomeScreen({super.key});

  @override
  State<AdminMainHomeScreen> createState() => _AdminMainHomeScreenState();
}

class _AdminMainHomeScreenState extends State<AdminMainHomeScreen> {
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
        body: const AdminDashboard(),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const AdminHeaderDrawer(),
                MyDrawerList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
