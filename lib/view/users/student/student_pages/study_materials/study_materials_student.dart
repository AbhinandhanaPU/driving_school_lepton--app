import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/view/users/widgets/file_viewer/file_viewer.dart';
import 'package:new_project_app/view/users/widgets/listcard_widget/listcard_widget.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class StudyMaterialsStudent extends StatelessWidget {
  const StudyMaterialsStudent({super.key});

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
        body: StreamBuilder(
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
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 10),
                      child: ListTileCardWidget(
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
                        trailing: GestureDetector(
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
                          child: TextFontWidget(
                            fontsize: 15.h,
                            text: 'View',
                            color: cbluelight,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Center(
                  child: Text('No Study materiales Uploaded Yet!'.tr));
            }),
      ),
    );
  }
}
