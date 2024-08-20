import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/controller/student_controller/student_controller.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/requests/approval_func.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';
import 'package:new_project_app/view/widgets/custom_show_dialogbox/custom_showdilog.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class RequstedStudentList extends StatefulWidget {
  final StudentModel data;
  final CourseModel courseModel;

  RequstedStudentList({
    super.key,
    required this.data,
    required this.courseModel,
  });

  @override
  State<RequstedStudentList> createState() => _RequstedStudentListState();
}

class _RequstedStudentListState extends State<RequstedStudentList> {
  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
        bottom: 8,
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: cWhite,
        boxShadow: [
          BoxShadow(
            color: cblack.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      height: 225,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: widget.data.profileImageUrl == ''
                      ? const NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/vidya-veechi-8-feb-2024.appspot.com/o/important***%2Fteacher-avathar2.png?alt=media&token=3db0d66c-225d-429b-a34e-f71b6b7dde7d')
                      : NetworkImage(
                          widget.data.profileImageUrl,
                        ),
                  onBackgroundImageError: (exception, stackTrace) {},
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.h),
                  child: TextFontWidget(
                    text: widget.data.studentName,
                    fontsize: 21.h,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Row(
              children: [
                TextFontWidget(
                  text: 'Requested Course :  ',
                  fontsize: 15.h,
                  fontWeight: FontWeight.bold,
                  color: cblack,
                ),
                TextFontWidget(
                  text: widget.courseModel.courseName,
                  fontsize: 14.h,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Row(
              children: [
                TextFontWidget(
                  text: '✉️  Email :  ',
                  fontsize: 15.h,
                  fontWeight: FontWeight.bold,
                  color: cblack,
                ),
                TextFontWidget(
                  text: widget.data.studentemail,
                  fontsize: 14.h,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Row(
              children: [
                TextFontWidget(
                  text: '📞  Phone No  :  ',
                  fontsize: 15.h,
                  fontWeight: FontWeight.bold,
                  color: cblack,
                ),
                TextFontWidget(
                  text: widget.data.phoneNumber,
                  fontsize: 14.h,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  customShowDilogBox2(
                    context: context,
                    title: 'Approval Status ',
                    children: [
                      const Text(
                          'Are you sure you want to accept offline payment request?')
                    ],
                    doyouwantActionButton: true,
                    actiononTapfuction: () {
                      Navigator.pop(context);
                      approvalDialogBox(
                          context, widget.courseModel, widget.data);
                    },
                  );
                },
                child: ButtonContainerWidget(
                    curving: 30,
                    colorindex: 0,
                    height: 40,
                    width: 140,
                    margin: EdgeInsets.only(top: 20.h),
                    child: const Center(
                      child: TextFontWidgetRouter(
                        text: 'Accept',
                        fontsize: 14,
                        fontWeight: FontWeight.bold,
                        color: cWhite,
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  customShowDilogBox2(
                    context: context,
                    title: 'Approval Status ',
                    children: [
                      const Text(
                          'Are you sure you want to decline offline payment request?')
                    ],
                    doyouwantActionButton: true,
                    actiononTapfuction: () {
                      Navigator.pop(context);
                      studentController.declineStudentToCourse(
                          widget.data, widget.courseModel.courseId);
                    },
                  );
                },
                child: ButtonContainerWidget(
                    curving: 30,
                    colorindex: 0,
                    height: 40,
                    width: 140,
                    margin: EdgeInsets.only(top: 20.h),
                    child: const Center(
                      child: TextFontWidgetRouter(
                        text: 'Decline',
                        fontsize: 14,
                        fontWeight: FontWeight.bold,
                        color: cWhite,
                      ),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
