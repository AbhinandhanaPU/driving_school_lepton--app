import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class GeneralInstruction extends StatelessWidget {
  const GeneralInstruction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: const AppBarColorWidget(),
          foregroundColor: cWhite,
          //backgroundColor: adminePrimayColor,
          title: GooglePoppinsWidgets(
              text: "General Instructions".tr, fontsize: 20.h),
        ),
        body:
            // StreamBuilder(
            //     stream:FirebaseFirestore.instance
            //     .collection('SchoolListCollection')
            //                       .doc(UserCredentialsController.schoolId)
            //                       .collection(UserCredentialsController.batchId!)
            //                       .doc(UserCredentialsController.batchId!)
            //                       .collection('Admin_general_instructions')
            //                       .snapshots(),
            //     // generalInstructionsController.getInstruction(),
            //     builder: (context, snapshot)
            //     {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //                       return const Center(child: CircularProgressIndicator());
            //                     }
            // ignore: prefer_is_empty
            // if (snapshot.data!.docs.length == 0) {
            //   return Center(
            //       child: Text(
            //     'No General_instructions',
            //     style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
            //   ));
            // }

            ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Container(
              height: 200,
              color: Colors.lightBlue[900],
              child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // child: ClipPath(
                    //   clipper: WaveClipper(),
                    //   child: Container(
                    //     color: Colors.white,
                    //     height: 150,
                    //   ),
                    // )

                    // ClipPath(
                    //   clipper: WaveClipper(),
                    //   child: Container(
                    //     color: Colors.blueGrey,
                    //     height: 130,
                    //     alignment: Alignment.bottomCenter,
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 20),
                      child: CircleAvatar(
                        maxRadius: 40,
                      ),
                    ),
                    // Obx(() => Align(
                    //       alignment: Alignment.bottomCenter,
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(bottom: 20),
                    //         child: Text(
                    //           '=======',
                    //           style: GoogleFonts.adamina(fontSize: 20, color: Colors.white),
                    //         ),
                    //       ),
                    //     )),
                  ]),
            ),
            kHeight40,
            Center(
                child: Text(
              "General Instructions",
              style: GoogleFonts.poppins(
                  fontSize: 20, decoration: TextDecoration.underline),
            )),
            kHeight20,
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: SingleChildScrollView(
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const SizedBox(width: 10),
                          Row(children: [
                            Icon(
                              Icons.circle,
                              size: 8.h,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.h),
                                child: const Text(
                                  "Tomorrow class will start at 6AM ",
                                  // .instruction,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  softWrap: true,
                                ),
                              ),
                            ),
                          ]),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return kHeight20;
                    },
                    itemCount: 1),
              ),
            ),
            kHeight20,
            Container(
              width: double.infinity,
              color: themeColor,
              child: const Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(""),
                  )),
            )
          ],
        )

        //   }),
        );
  }
}
