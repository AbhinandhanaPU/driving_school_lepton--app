import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/controller/practice_shedule_controller/practice_shedule_controller.dart';
import 'package:new_project_app/model/practice_shedule_model/practice_shedule_model.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class TutorPracticeSheduleList extends StatelessWidget {
  final PracticeSheduleModel data;

  TutorPracticeSheduleList({
    super.key,
    required this.data,
  });
  final PracticeSheduleController practiceshedulecontroller =
      Get.put(PracticeSheduleController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Get.to(()=>AllPractiseScheduleStudentListTutor(id: data));
      // },
      child: Container(
        margin: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: 8,
        ),
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 15),
        decoration: BoxDecoration(
          color: cWhite,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: cblack.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextFontWidget(
                    text: data.practiceName,
                    fontsize: 21.h,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // PopupMenuButton(
                //   itemBuilder: (context) {
                //     return [
                //       PopupMenuItem(
                //         child: const Text(
                //           "Edit",
                //           style: TextStyle(
                //             fontSize: 16,
                //           ),
                //         ),
                //         onTap: () {
                //           practiceshedulecontroller
                //               .practiceNameController.text = data.practiceName;
                //           practiceshedulecontroller.startTimeController.text =
                //               data.startTime;
                //           practiceshedulecontroller.endTimeController.text =
                //               data.endTime;
                //           editFunctionOfPractice(context, data);
                //         },
                //       ),
                //       PopupMenuItem(
                //         onTap: () {
                //           customDeleteShowDialog(
                //             context: context,
                //             onTap: () {
                //               practiceshedulecontroller
                //                   .deletePractice(
                //                     data.practiceId,
                //                     context,
                //                   )
                //                   .then((value) => Navigator.pop(context));
                //             },
                //           );
                //         },
                //         child: const Text(
                //           " Delete",
                //           style: TextStyle(
                //             fontSize: 16,
                //           ),
                //         ),
                //       )
                //     ];
                //   },
                // ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFontWidget(
                      text: "${data.startTime}",
                      fontsize: 18.h,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                    TextFontWidget(
                      text: 'Start Time',
                      fontsize: 14.h,
                      fontWeight: FontWeight.bold,
                      color: cgrey,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFontWidget(
                      text: "${data.endTime}",
                      fontsize: 18.h,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                    TextFontWidget(
                      text: 'End Time',
                      fontsize: 14.h,
                      fontWeight: FontWeight.bold,
                      color: cgrey,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.group, color: themeColor),
                        kWidth10,
                        StreamBuilder<int>(
                          stream: practiceshedulecontroller
                              .fetchTotalStudents(data.practiceId),
                          builder: (context, snapshot) {
                            return TextFontWidget(
                              text: snapshot.hasData
                                  ? snapshot.data.toString()
                                  : '0',
                              fontsize: 16.h,
                              fontWeight: FontWeight.bold,
                              color: cblack,
                            );
                          },
                        ),
                      ],
                    ),
                    TextFontWidget(
                      text: 'Total Students',
                      fontsize: 14.h,
                      fontWeight: FontWeight.bold,
                      color: cgrey,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
