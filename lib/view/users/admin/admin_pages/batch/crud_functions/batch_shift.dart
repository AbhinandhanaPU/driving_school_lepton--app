import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/batch_controller/batch_controller.dart';
import 'package:new_project_app/view/users/admin/admin_pages/batch/drop_down/batch_dp_dn.dart';
import 'package:new_project_app/view/users/admin/admin_pages/batch/drop_down/batch_std_drpdwn.dart';
import 'package:new_project_app/view/widgets/back_button/back_button.dart';
import 'package:new_project_app/view/widgets/progess_button/progress_button.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

batchShift(BuildContext context) {
  final BatchController batchController = Get.put(BatchController());
  String? selectedOldBatchId;
  String? selectedNewBatchId;
  String? selectedStudentDocId;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Form(
          key: batchController.formKey,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButtonContainerWidget(),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: TextFontWidget(
                  text: "Batch Shift ",
                  fontsize: 15,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        content: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:
                      EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                  child: TextFontWidget(text: 'Old Batch *', fontsize: 12.5),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, left: 10, right: 10, bottom: 15),
                  child: BatchDropDown(
                    onChanged: (batch) {
                      selectedOldBatchId = batch?.batchId;
                      log("old id$selectedOldBatchId");
                    },
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:
                      EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                  child: TextFontWidget(text: 'New Batch *', fontsize: 12.5),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, left: 10, right: 10, bottom: 15),
                  child: BatchDropDown(
                    onChanged: (batch) {
                      selectedNewBatchId = batch?.batchId;
                      log("new id$selectedNewBatchId");
                    },
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:
                      EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                  child:
                      TextFontWidget(text: 'Select Student *', fontsize: 12.5),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, left: 10, right: 10, bottom: 15),
                  child: AllStudentDropDownBatch(
                    onChanged: (student) {
                      selectedStudentDocId = student?.docid;
                      log("Student id$selectedStudentDocId");
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Center(
                child: Obx(
                  () => ProgressButtonWidget(
                    function: () async {
                      if (batchController.formKey.currentState!.validate() &&
                          selectedOldBatchId != null &&
                          selectedNewBatchId != null &&
                          selectedStudentDocId != null) {
                        await batchController
                            .shiftStudentToAnotherBatch(
                          studentDocId: selectedStudentDocId!,
                          oldBatchId: selectedOldBatchId!,
                          newBatchId: selectedNewBatchId!,
                        )
                            .then((value) {
                          Navigator.pop(context);
                        });
                      } else {
                        showToast(msg: "Please fill all fields");
                      }
                    },
                    buttonstate: batchController.buttonstate.value,
                    text: 'Shift Student',
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}
