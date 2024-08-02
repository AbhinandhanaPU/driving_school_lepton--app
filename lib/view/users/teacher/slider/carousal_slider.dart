import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class CarouselSliderTcr extends StatelessWidget {
  const CarouselSliderTcr({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Container(
          height: 100.h,
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: cblack,
                ),
              ],
              color: cWhite,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 08),
                      child: Row(
                        children: [
                          // SizedBox(
                          //   height: 40.h,
                          //   child: Image.asset(
                          //       'assets/flaticons/icons8-attendance-100.png'),
                          // ),
                          Text(
                            '  Cource Number',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 11, 2, 74),
                                //const Color.fromARGB(255, 48, 88, 86),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 05, left: 20),
                      child: Text(
                        'Type',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 228, 173, 21),
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 05, left: 25),
                      child: Text(
                        '2000/-',
                        style: TextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 05),
                      child: GooglePoppinsWidgets(
                          text: "Click To View",
                          fontsize: 13,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.asset("assets/images/2wheeler.jpg"),
                ),
              ),
            ],
          ),
        ),

        // GraphShowingPartStdAttendance(),
        // GraphShowingPartStdExamResult(),
        // GraphShowingPartStdHomework(),
        // GraphShowingPartStdAssignProject()
      ],
      options: CarouselOptions(
        height: 200.w,
        enlargeCenterPage: true,
        autoPlay: false,
        autoPlayInterval: const Duration(seconds: 2),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
    );
  }
}
