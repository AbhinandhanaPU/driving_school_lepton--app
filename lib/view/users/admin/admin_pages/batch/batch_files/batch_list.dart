import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/controller/batch_controller/batch_controller.dart';
import 'package:new_project_app/model/batch_model/batch_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/batch/crud_functions/batch_edit.dart';
import 'package:new_project_app/view/widgets/custom_delete_showdialog/custom_delete_showdialog.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class BatchList extends StatelessWidget {
  final BatchModel data;

  BatchList({
    super.key,
    required this.data,
  });
  
 final BatchController batchController =Get.put(BatchController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Get.to(()=>AllPractiseScheduleStudentList(id: data));
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
                    text: data.batchName,
                    fontsize: 21.h,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          batchController
                              .batchNameController.text = data.batchName;
                          batchController.dateController.text =
                              data.date;
                          editFunctionOfBatch(context, data);
                        },
                      ),
                      PopupMenuItem(
                        onTap: () {
                          customDeleteShowDialog(
                            context: context,
                            onTap: () {
                              batchController
                                  .deleteBatch(
                                    data.batchId,
                                    context,
                                  )
                                  .then((value) => Navigator.pop(context));
                            },
                          );
                        },
                        child: const Text(
                          " Delete",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      )
                    ];
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFontWidget(
                      text: "${data.date}",
                      fontsize: 18.h,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                    TextFontWidget(
                      text: 'Date',
                      fontsize: 14.h,
                      fontWeight: FontWeight.bold,
                      color: cgrey,
                    ),
                  ],
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     TextFontWidget(
                //       text: "${data.endTime}",
                //       fontsize: 18.h,
                //       fontWeight: FontWeight.bold,
                //       color: themeColor,
                //     ),
                //     TextFontWidget(
                //       text: 'End Time',
                //       fontsize: 14.h,
                //       fontWeight: FontWeight.bold,
                //       color: cgrey,
                //     ),
                //   ],
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.group, color: themeColor),
                        kWidth10,
                        StreamBuilder<int>(
                          stream: batchController
                              .fetchTotalStudents(data.batchId),
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
