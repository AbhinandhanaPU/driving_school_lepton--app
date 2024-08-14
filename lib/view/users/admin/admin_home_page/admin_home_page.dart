import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/fonts/text_widget.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/view/users/admin/admin_home_page/admin_dashboard.dart';
import 'package:new_project_app/view/users/admin/drawer/admin_header_drawer.dart';
import 'package:new_project_app/view/users/student/student_home_page/student_dashboard.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';

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
      child: StreamBuilder(
          stream: UserCredentialsController.schoolId != serverAuth.currentUser!.uid
              ? server
                  .collection('DrivingSchoolCollection')
                  .doc(UserCredentialsController.schoolId)
                  .collection('Admins')
                  .doc(serverAuth.currentUser!.uid)
                  .snapshots()
              : null,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data?.data()?['active'] == false
                  ? const Scaffold(
                      body: SafeArea(
                          child: Center(
                        child: TextFontWidget(
                            text: "Waiting for superadmin response.....", fontsize: 20),
                      )),
                    )
                  : Scaffold(
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
                    );
            } else if (UserCredentialsController.schoolId == serverAuth.currentUser!.uid) {
              return Scaffold(
                appBar: AppBar(
                    // flexibleSpace: const AppBarColorWidget(),
                    foregroundColor: cWhite,
                    title: const Text("Driving School"),
                    backgroundColor: themeColor),
                body: AdminDashboard(),
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
              );
            } else {
              return const Scaffold(body: LoadingWidget());
            }
          }),
    );
  }
}
