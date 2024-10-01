import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/controller/fee_controller/fee_controller.dart';
import 'package:new_project_app/controller/notification_controller/notification_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/fees/batch_drop_down/batch_dp_dn.dart';
import 'package:new_project_app/view/users/admin/admin_pages/fees/fees_list.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class FeesHomePage extends StatelessWidget {
  FeesHomePage({super.key});

  final FeeController feeController = Get.put(FeeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          foregroundColor: cWhite,
          title: Text("Unpaid Students List".tr),
          flexibleSpace: const AppBarColorWidget(),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: UnpaidBatchDropDown(
                    onChanged: (batchModel) {
                      feeController.onTapBtach.value = true;
                      if (batchModel!.batchId == 'all') {
                        feeController.batchId.value = '';
                      } else {
                        feeController.batchId.value = batchModel.batchId;
                      }
                    },
                  ),
                ),
                Expanded(
                  child: FutureBuilder<Map<String, Map<String, dynamic>>>(
                    future: feeController.batchId.value.isEmpty
                        ? feeController.fetchUnpaidStudents()
                        : feeController.fetchBatchStudents(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingWidget();
                      }
                      if (snapshot.hasError) {
                        return Center(
                            child: Text('Error: ${snapshot.error.toString()}'));
                      }

                      final studentsWithFeeData =
                          snapshot.data?.values.toList() ?? [];
                      if (studentsWithFeeData.isNotEmpty) {
                        return ListView.builder(
                          itemCount: studentsWithFeeData.length,
                          itemBuilder: (context, index) {
                            final studentData = studentsWithFeeData[index];
                            final studentModel =
                                studentData['studentModel'] as StudentModel;
                            final amountPaid =
                                (studentData['amountPaid'] as num).toDouble();
                            final totalAmount =
                                (studentData['totalAmount'] as num).toDouble();
                            final pendingAmount = totalAmount - amountPaid;
                            return FeesList(
                              stdData: studentModel,
                              amountPaid: amountPaid,
                              pendingAmount: pendingAmount,
                              totalAmount: totalAmount,
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text( 
                              "No students added to fees collection",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
            feeController.onTapBtach.value == true
                ? Positioned(
                    bottom: 20,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        Get.find<NotificationController>().fetchUnpaidUsers(
                          batchID: feeController.batchId.value,
                          bodyText:
                              'Your fee payment of your course is due. Please make the payment to avoid any late fees. Thank you!',
                          titleText: 'Fees Reminder',
                        );
                      },
                      child: ButtonContainerWidgetRed(
                        curving: 30,
                        height: 40,
                        width: 180,
                        child: const Center(
                          child: TextFontWidgetRouter(
                            text: 'Notify Students',
                            fontsize: 14,
                            fontWeight: FontWeight.bold,
                            color: cWhite,
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
