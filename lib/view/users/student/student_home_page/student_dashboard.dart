import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/images/images.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/view/users/student/quick_action/quick_action_part_std.dart';
import 'package:new_project_app/view/users/student/quick_action/quick_action_widgets.dart';
import 'package:new_project_app/view/users/student/slider/carousal_slider_std.dart';
import 'package:new_project_app/view/users/student/student_pages/notifications.dart';
import 'package:new_project_app/view/users/widgets/profile_edit_widgets/student_edit_profile.dart';

class StudentDashboard extends StatefulWidget {
  StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  // final PushNotificationController pushNotificationController =
  //     Get.put(PushNotificationController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // pushNotificationController.getUserDeviceID().then((value) {
    //   pushNotificationController.allUSerDeviceID(
    //       UserCredentialsController.userRole!,
    //       UserCredentialsController.currentUSerID!);
    // });
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 160.sp),
              child: Container(
                decoration: BoxDecoration(
                  color: themeColor.withOpacity(0.1),
                  // const Color.fromARGB(255, 218, 247, 229),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.sp),
                      topRight: Radius.circular(15.sp)),
                ),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 120.sp, right: 20.sp, left: 20.sp),
                      child: const QuickActionPartStudent(),
                    ),
                    ////////////////////////////////////////////////////////all tab part
                    Padding(
                      padding: EdgeInsets.only(
                          top: 80.sp, right: 20.sp, left: 20.sp),
                      child:  NotificationPartOfStd(),
                    ),
                    //////////////////////////////////////////////////////// notifications
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 60.sp, right: 10.sp, left: 10.sp),
              child: CarouselSliderStd(),
            ),
            //////////////////////////////////////////////////////details showing graph
            SizedBox(
              height: 100.h,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 05.sp,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: CircleAvatar(
                          backgroundImage: UserCredentialsController
                                          .studentModel?.profileImageUrl ==
                                      null ||
                                  UserCredentialsController
                                      .studentModel!.profileImageUrl.isEmpty
                              ? const NetworkImage(assetImagePathPerson)
                              : NetworkImage(UserCredentialsController
                                      .studentModel?.profileImageUrl ??
                                  " ") as ImageProvider,
                          onBackgroundImageError: (exception, stackTrace) {},
                          radius: 25,
                        ),
                      ),
                    ),
                    /////////////////////////////////////image
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, top: 10),
                        child: SizedBox(
                            width: 200,
                            child: Text(
                              UserCredentialsController
                                      .studentModel?.studentName ??
                                  "",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                    ),
                    /////////////////////////////////////////name
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const StudentProfileEditPage();
                              },
                            ),
                          );
                        },
                        icon: const Icon(Icons.now_widgets),
                      ),
                    ),
                    ////////////////////////////////edit profile
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 340.sp, left: 40),
              child: const Row(
                children: [
                  QuickActionsWidgetDrivingTest(),
                  QuickActionsWidgetPractice(),
                  QuickActionsWidgetSM(),
                  QuickActionsWidgetChat(),
                ],
              ),
            ), /////////////////////////////////////quick action
          ],
        ),
      )),
    );
  }
}
