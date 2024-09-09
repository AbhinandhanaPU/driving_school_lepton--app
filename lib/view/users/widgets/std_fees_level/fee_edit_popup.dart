import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/fonts/text_widget.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/fee_controller/fee_controller.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';

pendingAmountFunction(
  BuildContext context,
  StudentModel studentModel,
  String status,
  CourseModel course,
) {
  FeeController feecontroller = Get.put(FeeController());

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: cWhite,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back)),
            const TextFontWidget(
              text: "Amount collected",
              fontsize: 17,
              fontWeight: FontWeight.bold,
            )
          ],
        ),
        content: Form(
          key: feecontroller.formKey,
          child: SizedBox(
            height: 160,
            width: 250,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextFontWidget(text: "Amount *", fontsize: 12.5),
                        const SizedBox(
                          height: 05,
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: feecontroller.amountController,
                              validator: checkFieldEmpty,
                              decoration: const InputDecoration(
                                  hintText: "Enter Amount",
                                  hintStyle: TextStyle(
                                    fontSize: 13,
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (feecontroller.formKey.currentState!.validate()) {
                        feecontroller.addStudentFeeColl(
                            studentModel, status, course);
                      }
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          color: themeColor,
                          border: Border.all(color: themeColor),
                          borderRadius: BorderRadius.circular(05)),
                      child: const Center(
                        child: TextFontWidgetRouter(
                          text: "Set",
                          fontsize: 14,
                          color: cWhite,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
