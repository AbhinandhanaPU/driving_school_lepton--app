// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/images/images.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/school_controller/school_controller.dart';
import 'package:new_project_app/view/home/create_school/create_school.dart';
import 'package:new_project_app/view/home/user_selection_screen/user_selection_screen.dart';
import 'package:new_project_app/view/widgets/login_button/login_button.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_montserrat.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SchoolController schoolController = Get.put(SchoolController());

    return WillPopScope(
        onWillPop: () => onbackbuttonpressed(context),
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                kHeight30,
                Container(
                  height: 277,
                  width: 359,
                  decoration: const BoxDecoration(
                    //  color: cblue,
                    image: DecorationImage(
                        // Image.asset(""),
                        image: AssetImage("assets/images/driving.jpeg"),
                        fit: BoxFit.contain),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GoogleMontserratWidgets(
                        text: 'Welcome To',
                        letterSpacing: 2,
                        fontsize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                      GoogleMontserratWidgets(
                        text: "Lepton Communications",
                        fontsize: 25,
                        color: const Color.fromARGB(255, 230, 18, 3),
                        fontWeight: FontWeight.bold,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await schoolController.fetchAllSchoolData();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserSelectionScreen(),
                            ),
                          );
                        },
                        child: loginButtonWidget(
                          height: 60,
                          width: 180,
                          text: 'LOGIN',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SchoolProfile(),
                            ),
                          );
                        },
                        child: const Text(
                          'Create School',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GooglePoppinsWidgets(text: "Developed by", fontsize: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 32,
                                width: 32,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(image: AssetImage(officialLogo))),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: GoogleMontserratWidgets(
                                    text: "Lepton Communications",
                                    fontsize: 13,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
