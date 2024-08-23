import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/documents_controller/documents_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/view/users/student/drawer/drawer_items/documents/crud/documnets_edit.dart';
import 'package:new_project_app/view/users/student/drawer/drawer_items/documents/crud/upload_doc.dart';
import 'package:new_project_app/view/users/widgets/file_viewer/file_viewer.dart';
import 'package:new_project_app/view/users/widgets/listcard_widget/listcard_widget.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';
import 'package:new_project_app/view/widgets/custom_delete_showdialog/custom_delete_showdialog.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class DocumentsStd extends StatelessWidget {
  DocumentsStd({super.key});

  final documentsController = Get.put(DocumentsController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: cWhite,
          title: Text(
            "Documents".tr,
          ),
          flexibleSpace: const AppBarColorWidget(),
        ),
        body: Stack(
          children: [
            StreamBuilder(
                stream: server
                    .collection('DrivingSchoolCollection')
                    .doc(UserCredentialsController.schoolId)
                    .collection('Students')
                    .doc(UserCredentialsController.studentModel!.docid)
                    .collection('Documents')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingWidget();
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: TextFontWidget(
                        text: 'No Documents Uploaded Yet!',
                        fontsize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  } else {
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
                                  builder: (context) => FileViewerPage(
                                    pdfUrl: data['downloadUrl'],
                                    pdfName: data["title"],
                                  ),
                                ),
                              );
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
                            trailing: SizedBox(
                              width: 72,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      String url = data['downloadUrl'];
                                      String fileName = data['title'];
                                      documentsController.downloadFile(
                                        url,
                                        fileName,
                                        context,
                                      );
                                    },
                                    child: Icon(Icons.download),
                                  ),
                                  PopupMenuButton(
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          onTap: () {
                                            documentsController.titleController
                                                .text = data['title'];
                                            documentsController.desController
                                                .text = data['des'];
                                            documentsController.cateController
                                                .text = data['category'];
                                            editFunctionOfDocuments(
                                                context, data);
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
                                                documentsController
                                                    .deleteDocuments(
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
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UploadDocuments();
                      },
                    ),
                  );
                },
                child: ButtonContainerWidget(
                    curving: 30,
                    colorindex: 0,
                    height: 40,
                    width: 155,
                    child: const Center(
                      child: TextFontWidgetRouter(
                        text: 'Upload Documents',
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
