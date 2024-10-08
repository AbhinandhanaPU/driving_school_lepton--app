import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:new_project_app/constant/images/images.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/helper/shared_pref_helper.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/admin_model/admin_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/service/push_notifications/notification_services.dart';
import 'package:new_project_app/view/home/first_screen/first_screen.dart';
import 'package:new_project_app/view/users/admin/admin_home_page/admin_home_page.dart';
import 'package:new_project_app/view/users/student/student_home_page/student_home_page.dart';
import 'package:new_project_app/view/users/teacher/teacher_home_page/teacher_home_page.dart';
import 'package:new_project_app/view/widgets/custom_show_dialogbox/message_show_dialog.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_montserrat.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    nextpage(context);
    userRequestPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AnimationConfiguration.staggeredGrid(
              position: 1,
              duration: const Duration(milliseconds: 4000),
              columnCount: 3,
              child: ScaleAnimation(
                duration: const Duration(milliseconds: 900),
                curve: Curves.fastLinearToSlowEaseIn,
                child: FadeInAnimation(
                  child: Container(
                    height: 220,
                    width: 220,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(
                        officialLogo,
                      ),
                    )),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: AnimationConfiguration.staggeredGrid(
              position: 2,
              duration: const Duration(milliseconds: 4000),
              columnCount: 3,
              child: ScaleAnimation(
                duration: const Duration(milliseconds: 900),
                curve: Curves.fastLinearToSlowEaseIn,
                child: FadeInAnimation(
                  child: GoogleMontserratWidgets(
                    text: "Lepton Communications",
                    fontsize: 25,
                    color: const Color.fromARGB(255, 230, 18, 3),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

nextpage(context) async {
  //creating firebase auth instance
  FirebaseAuth auth = FirebaseAuth.instance;

  //assigning shared preference value to to UserCredentialController
  UserCredentialsController.schoolId =
      SharedPreferencesHelper.getString(SharedPreferencesHelper.schoolIdKey);
  UserCredentialsController.userRole =
      SharedPreferencesHelper.getString(SharedPreferencesHelper.userRoleKey);
  UserCredentialsController.currentUSerID =
      SharedPreferencesHelper.getString(SharedPreferencesHelper.currenUserKey);

  await Future.delayed(const Duration(seconds: 6));
  log("schoolId:${UserCredentialsController.schoolId}");
  log("userRole:${UserCredentialsController.userRole}");
  log('currentUSerID Auth ${UserCredentialsController.currentUSerID}');

  if (auth.currentUser == null) {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return const FirstScreen();
      },
    ));
  } else {
    if (UserCredentialsController.userRole == 'admin') {
      //getting adminData
      await checkAdmin(context);
    } else if (UserCredentialsController.userRole == 'secondoryAdmin') {
      await checkSecondoryAdmin(context);
    } else if (UserCredentialsController.userRole == 'student') {
      //getting studentData
      await checkStudent(context);
    } else if (UserCredentialsController.userRole == 'teacher') {
      //getting teaccherData
      await checkTeacher(context);
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return const FirstScreen();
        },
      ));
      //Get.offAll(() => const DujoLoginScren());
    }
  }
}

Future<void> checkAdmin(
  context,
) async {
  final adminData = await server
      .collection('DrivingSchoolCollection')
      .doc(serverAuth.currentUser?.uid)
      .get();

  if (adminData.data() != null) {
    UserCredentialsController.adminModel =
        AdminModel.fromMap(adminData.data()!);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const AdminMainHomeScreen();
      },
    ));
  } else {
    showToast(msg: "Please login again");
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const FirstScreen();
      },
    ));
  }
}

Future<void> checkStudent(
  context,
) async {
  final studentData = await server
      .collection('DrivingSchoolCollection')
      .doc(UserCredentialsController.schoolId)
      .collection('Students')
      .doc(serverAuth.currentUser?.uid)
      .get();

  if (studentData.data() != null) {
    UserCredentialsController.studentModel =
        StudentModel.fromMap(studentData.data()!);
    if (UserCredentialsController.studentModel!.status == true) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return StudentsMainHomeScreen();
        },
      ));
    } else if (studentData.data()!['status'] == true) {
      await serverAuth.signOut().then((value) async {
        await SharedPreferencesHelper.clearSharedPreferenceData();
        UserCredentialsController.clearUserCredentials();
        log("account logedout");
        customMessageDialogBox(
          context: context,
          message: 'Your account is Deactivated',
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return const FirstScreen();
              },
            ), (route) => false);
          },
        );
      });
    }
  } else {
    showToast(msg: "Please login again");
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const FirstScreen();
      },
    ));
  }
}

Future<void> checkTeacher(
  context,
) async {
  final teacherData = await server
      .collection('DrivingSchoolCollection')
      .doc(UserCredentialsController.schoolId)
      .collection('Teachers')
      .doc(serverAuth.currentUser?.uid)
      .get();

  if (teacherData.data() != null) {
    UserCredentialsController.studentModel =
        StudentModel.fromMap(teacherData.data()!);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const TeachersMainHomeScreen();
      },
    ));
  } else {
    showToast(msg: "Please login again");
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const FirstScreen();
      },
    ));
  }
}

void userRequestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    log('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    log('User granted provisional permission');
  } else {
    log('User declined or has not accepted permission');
  }
}

Future<void> checkSecondoryAdmin(
  context,
) async {
  log("userlogin ID :  ${FirebaseAuth.instance.currentUser?.uid}");
  log("userrole :  ${UserCredentialsController.userRole}");
  final adminData = await server
      .collection('DrivingSchoolCollection')
      .doc(UserCredentialsController.schoolId)
      .collection('Admins')
      .doc(serverAuth.currentUser!.uid)
      .get();

  if (adminData.data() != null) {
    // UserCredentialsController.adminModel = AdminModel.fromMap(adminData.data()!);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const AdminMainHomeScreen();
      },
    ));
  } else {
    showToast(msg: "Please login again");
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const FirstScreen();
      },
    ));
  }
}
