import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/images/images.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/profile_edit_controllers/secondary_admin_edit_controller.dart';
import 'package:new_project_app/controller/push_notificationController/pushnotificationController.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/view/users/admin/notifications/notifications.dart';
import 'package:new_project_app/view/users/admin/quick_action/quick_action_part_admin.dart';
import 'package:new_project_app/view/users/admin/quick_action/quick_action_widgets.dart';
import 'package:new_project_app/view/users/admin/slider_admin/carousal_slider_admin.dart';
import 'package:new_project_app/view/users/widgets/profile_edit_widgets/admin_edit_profile.dart';
import 'package:new_project_app/view/widgets/custom_show_dialogbox/custom_show_dialouge.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';
import 'package:new_project_app/view/widgets/textformfeild_container/textformfiled_blue_container.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final SecondaryAdminProfileEditController secondaryadminController =
      Get.put(SecondaryAdminProfileEditController());
  final PushNotificationController pushNotificationController =
      Get.put(PushNotificationController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pushNotificationController.getUserDeviceID().then((value) {
      pushNotificationController.allUSerDeviceID(
          UserCredentialsController.userRole!, UserCredentialsController.currentUSerID!);
    });
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
                      topLeft: Radius.circular(15.sp), topRight: Radius.circular(15.sp)),
                ),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 120.sp, right: 20.sp, left: 20.sp),
                      child: const QuickActionPartAdmin(),
                    ),
                    ////////////////////////////////////////////////////////all tab part
                    Padding(
                      padding: EdgeInsets.only(top: 80.sp, right: 20.sp, left: 20.sp),
                      child: NotificationPartOfAdmin(),
                    ),
                    //////////////////////////////////////////////////////// notifications
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 60.sp, right: 10.sp, left: 10.sp),
              child: CarouselSliderAdmin(),
            ),
            //////////////////////////////////////////////////////details showing graph
            StreamBuilder(
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
                  final data = snapshot.data!.data()!;
                  return SizedBox(
                    height: 100.h,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.sp, left: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['username'],
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                data['phoneNumber'],
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: cblack.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: () {
                                  secondaryadminController.nameEditingController.text =
                                      data['username'];
                                  secondaryadminController.phoneEditingController.text =
                                      data['phoneNumber'];
                                  customShowDilogBox(
                                      context: context,
                                      title: 'Edit',
                                      children: [
                                        Form(
                                          key: secondaryadminController.formKey,
                                          child: Column(
                                            children: [
                                              TextFormFiledHeightnoColor(
                                                  validator: checkFieldEmpty,
                                                  controller: secondaryadminController
                                                      .nameEditingController,
                                                  hintText: 'user name',
                                                  title: 'Name'),
                                              TextFormFiledHeightnoColor(
                                                  controller: secondaryadminController
                                                      .phoneEditingController,
                                                  hintText: 'phone Number',
                                                  validator: checkFieldEmpty,
                                                  title: 'Phone Number'),
                                            ],
                                          ),
                                        ),
                                      ],
                                      doyouwantActionButton: true,
                                      actiononTapfuction: () {
                                        if (secondaryadminController.formKey.currentState!
                                            .validate()) {
                                          secondaryadminController.updateprofile();
                                        }
                                      },
                                      actiontext: 'update');
                                },
                                child: Icon(Icons.edit)),
                          )
                        ],
                      ),
                    ),
                  );
                } else if (UserCredentialsController.schoolId == serverAuth.currentUser!.uid) {
                  return SizedBox(
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
                                backgroundImage:
                                    UserCredentialsController.adminModel?.profileImageUrl == null ||
                                            UserCredentialsController
                                                .adminModel!.profileImageUrl.isEmpty
                                        ? const NetworkImage(assetImagePathPerson)
                                        : NetworkImage(
                                            UserCredentialsController.adminModel?.profileImageUrl ??
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
                                    UserCredentialsController.adminModel?.adminName ?? "",
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
                                      return const AdminProfileEditPage();
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
                  );
                } else {
                  return LoadingWidget();
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 340.sp, left: 40),
              child: Row(
                children: [
                  // QuestionWidget(),
                  QuickActionsWidgetDrivingTestAdmin(),
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
