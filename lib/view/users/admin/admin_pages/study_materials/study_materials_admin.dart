import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/study_materials/study_materials_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/view/users/admin/admin_pages/study_materials/study_materials_edit.dart';
import 'package:new_project_app/view/users/admin/admin_pages/study_materials/upload_studymaterial.dart';
import 'package:new_project_app/view/users/admin/admin_pages/study_materials/view_study_material/view_st_mtrl.dart';
import 'package:new_project_app/view/users/widgets/listcard_widget/listcard_widget.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';
import 'package:new_project_app/view/widgets/custom_delete_showdialog/custom_delete_showdialog.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class AdminStudyMaterials extends StatelessWidget {
  AdminStudyMaterials({super.key});

  final studyMaterialController = Get.put(StudyMaterialController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: cWhite,
          title: Text(
            "Study Materials".tr,
          ),
          flexibleSpace: const AppBarColorWidget(),
        ),
        body: Stack(
          children: [
            StreamBuilder(
                stream: server
                    .collection('DrivingSchoolCollection')
                    .doc(UserCredentialsController.schoolId)
                    .collection('StudyMaterials')
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
                                      builder: (context) => PDFSectionScreen(
                                            urlPdf: snapshot.data!.docs[index]
                                                ['downloadUrl'],
                                          )));
                            },
                            leading: Icon(
                              Icons.note,
                              color: cblack.withOpacity(0.5),
                            ),
                            title: Row(
                              children: [
                                TextFontWidget(
                                  fontsize: 15.h,
                                  text: data["title"],
                                  fontWeight: FontWeight.bold,
                                ),
                                TextFontWidget(
                                  fontsize: 15.h,
                                  text: " .$fileExtension",
                                  fontWeight: FontWeight.w300,
                                ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFontWidget(
                                    fontsize: 15.h,
                                    text: data['category'],
                                    fontWeight: FontWeight.w400,
                                  ),
                                  TextFontWidget(
                                    fontsize: 15.h,
                                    text: data['des'],
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
                                      studyMaterialController
                                          .studyMTitleController
                                          .text = data['title'];
                                      studyMaterialController
                                          .studyMDesController
                                          .text = data['des'];
                                      studyMaterialController
                                          .studyMCateController
                                          .text = data['category'];
                                      editFunctionOfSM(context, data);
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
                                          studyMaterialController.deleteSM(
                                              docId: data['docId']);
                                        },
                                      );
                                    },
                                    child: const Text(
                                      "Delete",
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
                      },
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Center(
                      child: Text('No Study materiales Uploaded Yet!'.tr));
                }),
            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return UploadStudyMaterial();
                    },
                  ));
                },
                child: ButtonContainerWidget(
                    curving: 30,
                    colorindex: 0,
                    height: 40,
                    width: 155,
                    child: const Center(
                      child: TextFontWidgetRouter(
                        text: 'Upload Study Material',
                        fontsize: 14,
                        fontWeight: FontWeight.bold,
                        color: cWhite,
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
