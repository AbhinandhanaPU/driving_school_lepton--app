import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/view/login/student_login_screen.dart';
import 'package:new_project_app/view/login/teacher_loginscreen.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';
import 'package:new_project_app/view/widgets/user_select_container/user_select_container.dart';

class UserSelectionScreen extends StatelessWidget {
  const UserSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GooglePoppinsWidgets(
              fontsize: 28,
              fontWeight: FontWeight.w700,
              text: 'Welcome..'.tr,
            ),
            kHeight10,
            GooglePoppinsWidgets(
              fontsize: 23,
              fontWeight: FontWeight.w500,
              text: 'Select who you are ?'.tr,
            ),
            kHeight20,
            // Center(
            //   child: AssetContainerImage(
            //     height: 300.h,
            //     width: double.infinity.w,
            //     imagePath: 'assets/images/user.png',
            //   ),
            // ),
            Expanded(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                  3,
                  (int index) {
                    return GestureDetector(
                      onTap: () async {
                        if (index == 0) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return StudentLoginScreen();
                            },
                          ));
                        }
                        else {
                            Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return TeacherLoginScreen();
                            },
                          ));
                        }
                      },
                      child: UserContainer(
                          width: width,
                          imagePath: userIcons[index],
                          imageText: userList[index]),
                    );
                  },
                ),
              ),
            )),
          ],
        ),
      ),
    ));
  }
}

List<String> userList = [
  'Student'.tr,
  'Teacher'.tr,
  'Admin'.tr,
];

var userIcons = [
  'assets/images/student.png',
  'assets/images/teacher.png',
  'assets/images/admin.png',
];
