import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/responsive.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/student_controller/student_controller.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';
import 'package:new_project_app/view/widgets/catagory_table_header_widget/data_container_widget/profile_details_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class CourseDetailsStd extends StatelessWidget {
  CourseDetailsStd({super.key, required this.data});
  final CourseModel data;
  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    studentController.checkStudentPresence(data.courseId);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Course Details".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // course details
                Container(
                  padding:
                      EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 20),
                  decoration: BoxDecoration(
                    color: themeColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Course Name
                      Center(
                        child: Text(
                          data.courseName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: cblack,
                          ),
                        ),
                      ),
                      kHeight30,
                      // Course Rate
                      ProfileDetailsWidget(
                        title: 'Fee',
                        content: data.rate.toString(),
                      ),
                      kHeight10,
                      // Course Duration
                      ProfileDetailsWidget(
                        title: 'Duration',
                        content: "${data.duration} Days",
                      ),
                      kHeight20,
                      // Course Description
                      Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        data.courseDes,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: ResponsiveApp.width * .04,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Obx(
              () {
                final isInStudents =
                    studentController.isInStudentsCollection.value;
                final isInRequestedStudents =
                    studentController.isInRequestedStudentsCollection.value;

                return Positioned(
                  bottom: 30,
                  right: 40,
                  left: 40,
                  child: GestureDetector(
                    onTap: () async {
                      if (!isInStudents) {
                        if (!isInRequestedStudents) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              title: Center(
                                child: Text(
                                  'Payment Mode',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              actions: [
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        studentController
                                            .addStudentToCourseOnline(
                                                data.courseId, context);
                                      },
                                      child:
                                          _buildPaymentOption('Online Payment'),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        studentController.addStudentReqToCourse(
                                            data.courseId, context);
                                      },
                                      child: _buildPaymentOption(
                                          'Sent Offline Payment Request'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Message'),
                                content: const SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text(
                                          'You are already requested for ofline payment. Try Online Payment')
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Pay Online'),
                                    onPressed: () {
                                      studentController
                                          .addStudentToCourseOnline(
                                              data.courseId, context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } else {
                        showToast2(msg: 'You are already Added');
                      }
                    },
                    child: ButtonContainerWidget(
                      curving: 30,
                      colorindex: isInStudents
                          ? 8
                          : isInRequestedStudents
                              ? 2
                              : 0,
                      height: 60,
                      width: 140,
                      child: Center(
                        child: TextFontWidgetRouter(
                          text: isInStudents
                              ? 'Joined Course'
                              : isInRequestedStudents
                                  ? 'Requested to Join'
                                  : 'Join Course',
                          fontsize: 20,
                          fontWeight: FontWeight.bold,
                          color: cWhite,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildPaymentOption(String text) {
  return Container(
    height: 40,
    width: 250,
    decoration: const BoxDecoration(color: themeColor),
    child: Center(
      child: GooglePoppinsWidgets(
        text: text,
        color: cWhite,
        fontsize: 15,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
