import 'dart:io';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/documents_controller/documents_controller.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_montserrat.dart';

class UploadDocuments extends StatefulWidget {
  UploadDocuments({super.key});

  @override
  State<UploadDocuments> createState() => _UploadDocumentsState();
}

DocumentsController documentsController = Get.put(DocumentsController());

class _UploadDocumentsState extends State<UploadDocuments> {
  File? filee;
  String downloadUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Upload Documents".tr,
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
                  key: documentsController.formKey,
                  child: Column(
                    children: [
                      GoogleMontserratWidgets(
                          text: 'Documents upload'.tr,
                          fontsize: 13.h,
                          color: cgrey,
                          fontWeight: FontWeight.w700),
                      kHeight10,
                      DocumentsUploadWidget(),
                      kWidth20,
                      kHeight20,
                      TextFormField(
                        validator: checkFieldEmpty,
                        controller: documentsController.titleController,
                        decoration:
                            const InputDecoration(hintText: 'Enter Name'),
                      ),
                      kHeight20,
                      TextFormField(
                        validator: checkFieldEmpty,
                        controller: documentsController.desController,
                        decoration: const InputDecoration(
                            hintText: 'Enter Description'),
                      ),
                      kHeight20,
                      TextFormField(
                        validator: checkFieldEmpty,
                        controller: documentsController.cateController,
                        decoration:
                            const InputDecoration(hintText: 'Enter Category'),
                      ),
                      kHeight40,
                      GestureDetector(
                        onTap: () async {
                          if (documentsController.formKey.currentState
                                  ?.validate() ??
                              false) {
                            if (documentsController.filee != null) {
                              documentsController.uploadToFirebase();
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
                                if (documentsController.isLoading.value) {
                                  final progress =
                                      (documentsController.progressData.value *
                                              100)
                                          .toInt();
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Center(
                                        child: CircularProgressIndicator(
                                          value: documentsController
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
                                      text: 'Upload Documents',
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

class DocumentsUploadWidget extends StatelessWidget {
  DocumentsUploadWidget({
    super.key,
  });

  final DocumentsController _documentsController =
      Get.put(DocumentsController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _documentsController.pickAFile();
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
                  String textData = _documentsController.fileName.value == ""
                      ? 'Upload file here'
                      : _documentsController.fileName.value;
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
