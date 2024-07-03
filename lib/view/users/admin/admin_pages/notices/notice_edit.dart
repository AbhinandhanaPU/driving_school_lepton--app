import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/notice_controller/notice_controller.dart';
import 'package:new_project_app/model/notice_model/notice_model.dart';
import 'package:new_project_app/view/widgets/custom_show_dialogbox/custom_show_dialouge.dart';
import 'package:new_project_app/view/widgets/textformfeild_container/textformfiled_blue_container.dart';

editFunctionOfNotice(BuildContext context, NoticeModel data) {
  final NoticeController noticeController = Get.put(NoticeController());
  customShowDilogBox(
      context: context,
      title: 'Edit',
      children: [
        Form(
          key: noticeController.formKey,
          child: Column(
            children: [
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: noticeController.noticeHeadingController,
                  hintText: data.heading,
                  title: 'Heading'),
              kHeight10,
              TextFormFiledHeightnoColor(
                  onTap: () async {
                    noticeController.noticePublishedDateController.text =
                        await dateTimePicker(context);
                  },
                  validator: checkFieldDateIsValid,
                  controller: noticeController.noticePublishedDateController,
                  hintText: data.publishedDate,
                  title: 'Published Date'),
              kHeight10,
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: noticeController.noticeSubjectController,
                  hintText: data.subject,
                  title: 'Subject'),
              kHeight10,
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: noticeController.noticeSignedByController,
                  hintText: data.signedBy,
                  title: 'Signed by'),
            ],
          ),
        ),
      ],
      doyouwantActionButton: true,
      actiononTapfuction: () {
        if (noticeController.formKey.currentState!.validate()) {
          noticeController.updateNotice(
            data.noticeId,
            context,
          );
        }
      },
      actiontext: 'Update');
}
