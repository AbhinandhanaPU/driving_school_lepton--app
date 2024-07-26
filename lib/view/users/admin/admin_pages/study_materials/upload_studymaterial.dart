import 'dart:io';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/study_materials/study_materials_controller.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_montserrat.dart';

// ignore: must_be_immutable
class UploadStudyMaterial extends StatefulWidget {
  UploadStudyMaterial({super.key});

  @override
  State<UploadStudyMaterial> createState() => _UploadStudyMaterialState();
}

StudyMaterialController studyMaterialController =
    Get.put(StudyMaterialController());

class _UploadStudyMaterialState extends State<UploadStudyMaterial> {
  File? filee;
  String downloadUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Upload Study Materials".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            kHeight10,
            SizedBox(
              height: 680.w,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: studyMaterialController.formKey,
                  child: Column(
                    children: [
                      GoogleMontserratWidgets(
                          text: 'Study material upload'.tr,
                          fontsize: 13.h,
                          color: cgrey,
                          fontWeight: FontWeight.w700),
                      kHeight10,
                      StudyMaterialUploadWidget(),
                      kWidth20,
                      kHeight20,
                      TextFormField(
                        validator: checkFieldEmpty,
                        controller:
                            studyMaterialController.studyMTitleController,
                        decoration:
                            const InputDecoration(hintText: 'Enter Name'),
                      ),
                      kHeight20,
                      TextFormField(
                        validator: checkFieldEmpty,
                        controller: studyMaterialController.studyMDesController,
                        decoration: const InputDecoration(
                            hintText: 'Enter Description'),
                      ),
                      kHeight20,
                      TextFormField(
                        validator: checkFieldEmpty,
                        controller:
                            studyMaterialController.studyMCateController,
                        decoration:
                            const InputDecoration(hintText: 'Enter Category'),
                      ),
                      kHeight40,
                      GestureDetector(
                        onTap: () async {
                          if (studyMaterialController.formKey.currentState
                                  ?.validate() ??
                              false) {
                            if (studyMaterialController.filee != null) {
                              studyMaterialController.uploadToFirebase();
                            } else {
                              showToast(msg: "Please Select File");
                            }
                          }
                        },
                        child: ButtonContainerWidget(
                          curving: 30,
                          colorindex: 0,
                          height: 40,
                          width: 180,
                          child: Center(
                            child: Obx(
                              () {
                                if (studyMaterialController.isLoading.value) {
                                  final progress = (studyMaterialController
                                              .progressData.value *
                                          100)
                                      .toInt();
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Center(
                                        child: CircularProgressIndicator(
                                          value: studyMaterialController
                                              .progressData.value,
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                  Color>(
                                            Colors.white,
                                          ),
                                        ),
                                      ),
                                      TextFontWidgetRouter(
                                        text: '$progress%',
                                        fontsize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: cWhite,
                                      ),
                                    ],
                                  );
                                } else {
                                  return const Center(
                                    child: TextFontWidgetRouter(
                                      text: 'Upload Study Material',
                                      fontsize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: cWhite,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudyMaterialUploadWidget extends StatelessWidget {
  StudyMaterialUploadWidget({
    super.key,
  });

  final StudyMaterialController _studyMaterialsController =
      Get.put(StudyMaterialController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _studyMaterialsController.pickAFile();
      },
      child: Container(
        height: 130.h,
        width: double.infinity - 20.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: cblue,
            width: 2.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Icon(Icons.attach_file_rounded,
                  color: cblue, size: 30.w, weight: 10),
            ),
            FittedBox(
              child: Obx(
                () {
                  String textData =
                      _studyMaterialsController.fileName.value == ""
                          ? 'Upload file here'
                          : _studyMaterialsController.fileName.value;
                  return Text(
                    textData,
                    style: TextStyle(
                        fontSize: 15.h,
                        color: cblue,
                        fontWeight: FontWeight.bold),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
