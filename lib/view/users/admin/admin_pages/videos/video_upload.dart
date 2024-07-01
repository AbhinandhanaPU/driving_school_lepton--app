import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/video_controller/video_controller.dart';
import 'package:new_project_app/view/users/admin/admin_pages/videos/video_list_admin.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';

class VideosUploadPage extends StatelessWidget {
  VideosUploadPage({super.key});

  final VideosController videosController = Get.put(VideosController());

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
                  key: videosController.formKey,
                  child: Column(
                    children: [
                      Text(
                        'Video Upload',
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 13.h,
                            fontWeight: FontWeight.w700),
                      ),
                      kWidth20,
                      VideosUploadWidget(),
                      kWidth20,
                      kHeight20,
                      TextFormField(
                        validator: checkFieldEmpty,
                        controller: videosController.videoNameController,
                        decoration:
                            const InputDecoration(hintText: 'Enter Name'),
                      ),
                      kHeight20,
                      TextFormField(
                        validator: checkFieldEmpty,
                        controller: videosController.videoDesController,
                        decoration: const InputDecoration(
                            hintText: 'Enter Description'),
                      ),
                      kHeight20,
                      TextFormField(
                        validator: checkFieldEmpty,
                        controller: videosController.videoCategoryController,
                        decoration:
                            const InputDecoration(hintText: 'Enter Category'),
                      ),
                      kHeight40,
                      GestureDetector(
                          onTap: () async {
                            if (videosController.formKey.currentState
                                    ?.validate() ??
                                false) {
                              if (videosController.file.value != null) {
                                videosController.uploadToFirebase(
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
                              if (videosController.isLoading.value) {
                                final progress =
                                    (videosController.progressData.value * 100)
                                        .toInt();
                                return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Center(
                                        child: CircularProgressIndicator(
                                          value:
                                              videosController.progressData.value,
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                  Color>(
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
                              builder: (context) => VideosListAdmin(),
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
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700),
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

class VideosUploadWidget extends StatelessWidget {
  VideosUploadWidget({
    super.key,
  });

  final VideosController _videosController = Get.put(VideosController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _videosController.pickFile();
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
                  String textData = _videosController.file.value == null
                      ? 'Upload file here'
                      : _videosController.file.value!.path
                          .split('/')
                          .last;
                  return Text(
                    textData,
                    style: const TextStyle(
                        fontSize: 15,
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
