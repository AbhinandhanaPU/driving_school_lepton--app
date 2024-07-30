import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/video_controller/video_controller.dart';
import 'package:new_project_app/view/widgets/custom_show_dialogbox/custom_show_dialouge.dart';
import 'package:new_project_app/view/widgets/textformfeild_container/textformfiled_blue_container.dart';

editFunctionOfVideo(BuildContext context, Map<String, dynamic> data) {
  final VideosController videosController = Get.put(VideosController());

  customShowDilogBox(
      context: context,
      title: 'Edit',
      children: [
        Form(
          key: videosController.formKey,
          child: Column(
            children: [
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: videosController.editVideoTitleController,
                  hintText: data['videoTitle'],
                  title: 'Name'),
              kHeight10,
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: videosController.editVideoDesController,
                  hintText: data['videoDes'],
                  title: 'Description'),
              kHeight10,
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: videosController.editVideoCateController,
                  hintText: data['videoCategory'],
                  title: 'Category'),
            ],
          ),
        ),
      ],
      doyouwantActionButton: true,
      actiononTapfuction: () {
        if (videosController.formKey.currentState!.validate()) {
          videosController.updateVideo(
            data['docId'],
            context,
          );
        }
      },
      actiontext: 'Update');
}
