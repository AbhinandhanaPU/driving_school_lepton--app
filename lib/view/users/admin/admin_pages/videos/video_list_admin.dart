import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/controller/video_controller/video_controller.dart';
import 'package:new_project_app/view/users/admin/admin_pages/videos/video_edit.dart';
import 'package:new_project_app/view/users/admin/admin_pages/videos/video_upload.dart';
import 'package:new_project_app/view/users/widgets/listcard_widget/listcard_widget.dart';
import 'package:new_project_app/view/users/widgets/video_player/play_video.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';
import 'package:new_project_app/view/widgets/custom_delete_showdialog/custom_delete_showdialog.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class VideosListAdmin extends StatelessWidget {
  VideosListAdmin({super.key});
  final VideosController videosController = Get.put(VideosController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: cWhite,
          title: Text(
            "Videos".tr,
          ),
          flexibleSpace: const AppBarColorWidget(),
        ),
        body: Stack(
          children: [
            StreamBuilder(
              stream: server
                  .collection('DrivingSchoolCollection')
                  .doc(UserCredentialsController.schoolId)
                  .collection('Videos')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                      itemCount: snapshot.data!.docs.length,
                      separatorBuilder: ((context, index) {
                        return kHeight10;
                      }),
                      itemBuilder: (BuildContext context, int index) {
                        final data = snapshot.data!.docs[index].data();
                        String fileName = data['fileName'];
                        String fileExtension = fileName.split('.').last;
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 10),
                          child: ListTileCardWidget(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlayVideoFlicker(
                                      videoUrl: data['downloadUrl']),
                                ),
                              );
                            },
                            leading: Icon(Icons.ondemand_video_outlined),
                            title: Row(
                              children: [
                                TextFontWidget(
                                  fontsize: 15.h,
                                  text: data['videoTitle'],
                                  fontWeight: FontWeight.bold,
                                ),
                                TextFontWidget(
                                  fontsize: 15.h,
                                  text: ' .$fileExtension',
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFontWidget(
                                    fontsize: 15.h,
                                    text: "Category: ${data['videoCategory']}",
                                    fontWeight: FontWeight.w400,
                                  ),
                                  kHeight10,
                                  TextFontWidget(
                                    fontsize: 15.h,
                                    text: data['videoDes'],
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ),
                            trailing: PopupMenuButton(
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    onTap: () {
                                      videosController.editVideoTitleController
                                          .text = data['videoTitle'];
                                      videosController.editVideoCateController
                                          .text = data['videoCategory'];
                                      videosController.editVideoDesController
                                          .text = data['videoDes'];
                                      editFunctionOfVideo(context, data);
                                    },
                                    child: const Text(
                                      "Edit",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      customDeleteShowDialog(
                                        context: context,
                                        onTap: () {
                                          videosController
                                              .deletevideo(docId: data['docId'])
                                              .then((value) =>
                                                  Navigator.pop(context));
                                        },
                                      );
                                    },
                                    child: const Text(
                                      " Delete",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                ];
                              },
                            ),
                          ),
                        );
                      });
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Center(child: Text('No Videos Uploaded Yet!'.tr));
              },
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return VideosUploadPage();
                    },
                  ));
                },
                child: ButtonContainerWidget(
                  curving: 30,
                  colorindex: 0,
                  height: 40,
                  width: 140,
                  child: const Center(
                    child: TextFontWidgetRouter(
                      text: 'Upload Videos',
                      fontsize: 14,
                      fontWeight: FontWeight.bold,
                      color: cWhite,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
