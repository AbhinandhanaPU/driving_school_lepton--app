import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/controller/fee_controller/fee_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/batch/drop_down/batch_dp_dn.dart';
import 'package:new_project_app/view/users/admin/admin_pages/fees/fees_list.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';

class FeesHomePage extends StatelessWidget {
  FeesHomePage({super.key});

  final FeeController feeController = Get.put(FeeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          foregroundColor: cWhite,
          title: Text(
            feeController.onTapBtach.value == true
                ? 'Batch Student List'
                : "Unpaid Students List".tr,
          ),
          flexibleSpace: const AppBarColorWidget(),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
              child: BatchDropDown(
                onChanged: (batchModel) {
                  feeController.onTapBtach.value = true;
                  feeController.batchId.value = batchModel!.batchId;
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<Map<String, Map<String, dynamic>>>(
                future: feeController.onTapBtach.value == true
                    ? feeController.fetchBatchStudents()
                    : feeController.fetchUnpaidStudents(),
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
      ),
    );
  }
}
