// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/notice_controller/notice_controller.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/progess_button/progress_button.dart';
import 'package:new_project_app/view/widgets/textformfeild_container/textformfiled_blue_container.dart';

class NoticeCreate extends StatelessWidget {
  NoticeCreate({super.key});
  NoticeController noticeController = Get.put(NoticeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Create Event".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: noticeController.formKey,
                child: Column(
                  children: [
                    TextFormFiledHeightnoColor(
                      width: double.infinity,
                      controller: noticeController.noticeHeadingController,
                      validator: checkFieldEmpty,
                      title: 'Heading',
                      hintText: 'Heading',
                    ),
                    kHeight20,
                    TextFormFiledHeightnoColor(
                      onTap: () async {
                        noticeController.noticePublishedDateController.text =
                            await dateTimePicker(context);
                      },
                      width: double.infinity,
                      controller:
                          noticeController.noticePublishedDateController,
                      validator: checkFieldDateIsValid,
                      title: 'Published Date',
                      hintText: 'Published Date',
                    ),
                    kHeight20,
                    TextFormFiledHeightnoColor(
                      width: double.infinity,
                      validator: checkFieldEmpty,
                      controller: noticeController.noticeSubjectController,
                      title: 'Subject',
                      hintText: 'Subject',
                    ),
                    kHeight20,
                    TextFormFiledHeightnoColor(
                      width: double.infinity,
                      validator: checkFieldEmpty,
                      controller: noticeController.noticeSignedByController,
                      title: 'Signed by',
                      hintText: 'Signed by',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: Center(
                    child: Obx(() => ProgressButtonWidget(
                        function: () async {
                          if (noticeController.formKey.currentState!
                              .validate()) {
                            noticeController
                                .createNotice()
                                .then((value) => Navigator.pop(context));
                          }
                        },
                        buttonstate: noticeController.buttonstate.value,
                        text: 'Create Notice'))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
