import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/course_controller/course_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/courses/course_list/course_details.dart';

class CarouselSliderAdmin extends StatelessWidget {
  CarouselSliderAdmin({super.key});

  final CourseController courseController = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Courses')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var courses = snapshot.data!.docs.map((doc) {
            CourseModel data = CourseModel.fromMap(doc.data());
            return Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      courseController.setCourseData(data);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseDetails(
                            data: data,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 20),
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: cblack,
                            ),
                          ],
                          color: cWhite,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  '${data.courseName}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Icon(
                                Icons.group,
                                color: themeColor,
                                size: 28,
                              )
                            ],
                          ),
                          // Text(
                          //   '${data.courseDes}',
                          //   style: TextStyle(
                          //       color: cblack.withOpacity(0.5),
                          //       fontSize: 15.sp,
                          //       fontWeight: FontWeight.bold),
                          // ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '${data.duration} Days',
                                    style: TextStyle(
                                        color: themeColor,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Duration',
                                    style: TextStyle(
                                        color: cgrey,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text(
                                    '${data.rate} /-',
                                    style: TextStyle(
                                        color: themeColor,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Fee',
                                    style: TextStyle(
                                        color: cgrey,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList();

          return CarouselSlider(
            items: courses,
            options: CarouselOptions(
              enableInfiniteScroll: true,
              height: 200.w,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: Text('No Courses Available Yet!'.tr),
          );
        }
      },
    );
  }
}
