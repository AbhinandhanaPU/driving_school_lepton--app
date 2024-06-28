import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/recorded_class_controller/recorded_class_controller.dart';
import 'package:new_project_app/view/users/admin/admin_pages/Recorded_vedio/recorded_vedio_uploading.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';

class VideosUploadPage extends StatelessWidget {
  VideosUploadPage({
    super.key,
  });

  final VideosController recordedClsCtr = Get.put(VideosController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Videos'),
        foregroundColor: cWhite,
        backgroundColor: themeColor,
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
                  key: recordedClsCtr.formKey,
                  child: Column(
                    children: [
                      Text(
                        'Recorded class upload',
                        style: GoogleFonts.montserrat(
                            color: Colors.black, fontSize: 13.h, fontWeight: FontWeight.w700),
                      ),
                      kWidth20,
                      RecordedClassUploadWidget(),
                      kWidth20,
                      kHeight20,
                      TextFormField(
                        validator: checkFieldEmpty,
                        controller: recordedClsCtr.videoNameController,
                        decoration: const InputDecoration(hintText: 'Enter Name'),
                      ),
                      kHeight20,
                      TextFormField(
                        validator: checkFieldEmpty,
                        controller: recordedClsCtr.videoDesController,
                        decoration: const InputDecoration(hintText: 'Enter Description'),
                      ),
                      kHeight20,
                      TextFormField(
                        validator: checkFieldEmpty,
                        controller: recordedClsCtr.videoCategoryController,
                        decoration: const InputDecoration(hintText: 'Enter Category'),
                      ),
                      kHeight40,
                      GestureDetector(
                          onTap: () async {
                            if (recordedClsCtr.formKey.currentState?.validate() ?? false) {
                              if (recordedClsCtr.file.value != null) {
                                recordedClsCtr.uploadToFirebase(
                                  context: context,
                                );
                              } else {
                                showToast(msg: "Please Select File");
                              }
                            }
                          },
                          child: ButtonContainerWidget(
                            curving: 18,
                            colorindex: 0,
                            height: 60.w,
                            width: 300.w,
                            child: Center(child: Obx(() {
                              if (recordedClsCtr.isLoading.value) {
                                final progress = (recordedClsCtr.progressData.value * 100).toInt();
                                return Stack(alignment: Alignment.center, children: [
                                  Center(
                                    child: CircularProgressIndicator(
                                      value: recordedClsCtr.progressData.value,
                                      valueColor: const AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '$progress%',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ]);
                              } else {
                                return Text(
                                  "Submit",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                );
                              }
                            })),
                          )),
                      kHeight20,
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecordedClassesShowsPage(),
                            ),
                          );
                        },
                        child: ButtonContainerWidget(
                          curving: 18,
                          colorindex: 0,
                          height: 60.w,
                          width: 300.w,
                          child: Center(
                            child: Text(
                              "Uploaded Videos",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            kHeight30,
          ],
        ),
      ),
    );
  }
}

class RecordedClassUploadWidget extends StatelessWidget {
  RecordedClassUploadWidget({
    super.key,
  });

  final VideosController _recordedClassController = Get.put(VideosController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _recordedClassController.pickFile();
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
              child: Icon(Icons.attach_file_rounded, color: cblue, size: 30.w, weight: 10),
            ),
            FittedBox(
              child: Obx(
                () {
                  String textData = _recordedClassController.file.value == null
                      ? 'Upload file here'
                      : _recordedClassController.file.value!.path.split('/').last;
                  return Text(
                    textData,
                    style: const TextStyle(fontSize: 15, color: cblue, fontWeight: FontWeight.bold),
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
