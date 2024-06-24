import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/controller/user_logout_controller/user_logout_controller.dart';
import 'package:new_project_app/language/language_change_drawer.dart';
import 'package:new_project_app/view/pages/general_instructions/general_instructions.dart';
import 'package:new_project_app/view/pages/privacy_policy/dialogs/privacy_policy.dart';
import 'package:new_project_app/view/users/admin/admin_pages/create_tutor/create_new_tutor.dart';

class AdminHeaderDrawer extends StatelessWidget {
  const AdminHeaderDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    UserLogoutController userLogoutController = Get.put(UserLogoutController());
    return Container(
      color: Colors.grey.withOpacity(0.2),
      width: double.infinity,
      height: 300,
      padding: EdgeInsets.only(bottom: 20, top: 15.h),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spacearound,
        children: [
          SizedBox(height: 30.h),
          Container(
            margin: const EdgeInsets.only(bottom: 0),
            height: 90.h,
            width: 150.h,
            decoration: const BoxDecoration(
              // color: cred,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/leptonscipro-31792.appspot.com/o/files%2Fimages%2FL.png?alt=media&token=135e14d0-fb5a-4a21-83a6-411f647ec974"),
              ),
            ),
          ),
          Text(
            'Royal Driving',
            style: GoogleFonts.montserrat(
                color: Colors.black, fontSize: 25.h, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Watch and Guide      \n  Let them Study",
            style: GoogleFonts.poppins(
                color: Colors.black.withOpacity(0.5), fontSize: 10.h, fontWeight: FontWeight.w600),
          ),
          TextButton(
            onPressed: () async {
              await userLogoutController.userLogOut(context);
            },
            child: Text(
              "Logout".tr,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.h),
            ),
          )
        ],
      ),
    );
  }
}

Widget menuItem(int id, String image, String title, bool selected, onTap) {
  return Material(
    color: Colors.white,
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(15.0.h),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 30.h,
                width: double.infinity,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(image))),
              ),
            ),
            Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ))
          ],
        ),
      ),
    ),
  );
}

enum DrawerSections {
  dashboard,
  favourites,
  setting,
  share,
  feedback,
  contact,
  about,
}

// ignore: non_constant_identifier_names
Widget MyDrawerList(context) {
  // void signOut(context) async {
  //   final auth = FirebaseAuth.instance;
  //   try {
  //     await auth.signOut().then((value) => {
  //           // Navigator.pushAndRemoveUntil(
  //           //     context,
  //           //     MaterialPageRoute(builder: (context) => const Gsignin()),
  //           //     (route) => false)
  //         });
  //   } catch (e) {}
  // }

  var currentPage = DrawerSections.dashboard;
  return Container(
    padding: const EdgeInsets.only(top: 15),
    child: Column(
      // show list  of menu drawer.........................
      children: [
        menuItem(1, 'assets/flaticons/books.png', 'Create Tutor'.tr,
            currentPage == DrawerSections.dashboard ? true : false, () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const CreateTutor();
            },
          ));
          // Get.off(() => const PrivacyPolicy());
        }),
        menuItem(2, 'assets/images/information.png', 'General Instructions'.tr,
            currentPage == DrawerSections.dashboard ? true : false, () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const GeneralInstruction();
            },
          ));
          // Get.off(
          //   () => GeneralInstruction(),
        }),
        menuItem(3, 'assets/images/languages.png', 'Change Language'.tr,
            currentPage == DrawerSections.dashboard ? true : false, () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return LanguageChangeDrawerPage();
            },
          ));
          // Get.off(() => LanguageChangeDrawerPage());
        }),
        menuItem(4, 'assets/images/attendance.png', 'Privacy Policy'.tr,
            currentPage == DrawerSections.dashboard ? true : false, () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const PrivacyPolicy();
            },
          ));
          // Get.off(() => const PrivacyPolicy());
        }),
         
        kHeight10,
        kHeight10,
        kHeight10,
        Container(
          color: Colors.grey.withOpacity(0.2),
          height: 200.h,
          width: double.infinity,
          child: Stack(children: [
            const Positioned(
              left: 20,
              top: 15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        "Developed by",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                top: 50.h,
                left: 30.h,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/leptonscipro-31792.appspot.com/o/files%2Fimages%2FL.png?alt=media&token=135e14d0-fb5a-4a21-83a6-411f647ec974'),
                    ),
                    SizedBox(
                      width: 06,
                    ),
                    Text(
                      "Lepton Communications",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 11.5),
                    ),
                  ],
                )),
            Positioned(
              left: 100,
              top: 100,
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.adb_outlined,
                        color: Colors.green,
                      ),
                      Text(
                        " Version",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    "    1.0.0",
                    style: TextStyle(color: Colors.black, fontSize: 11.5.h),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ],
    ),
  );
}

Widget emptyDisplay(String section) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "No $section Found",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.h,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
