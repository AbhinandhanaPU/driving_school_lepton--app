import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/view/users/widgets/listcard_study_materials_widget/listcard_study_materials_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class AdminStudyMaterials extends StatelessWidget {
  const AdminStudyMaterials({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.blue[50],
          appBar: AppBar(
            title: Row(
              children: [
                Text("Study Materials".tr),
              ],
            ),
            backgroundColor: themeColor,
          ),
          body: ListView.separated(
            itemCount: 2,
            separatorBuilder: ((context, index) {
              return kHeight10;
            }),
            itemBuilder: (BuildContext context, int index) {
              return ListileCardStudyMaterialsWidget(
                leading: const Image(
                    image: NetworkImage(
                        "https://media.istockphoto.com/id/926144358/photo/portrait-of-a-little-bird-tit-flying-wide-spread-wings-and-flushing-feathers-on-white-isolated.jpg?b=1&s=170667a&w=0&k=20&c=DEARMqqAI_YoA5kXtRTyYTYU9CKzDZMqSIiBjOmqDNY=")),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: GooglePoppinsWidgets(
                        fontsize: 15.h,
                        text: "chapterName",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: GooglePoppinsWidgets(
                          fontsize: 15.h,
                          text: "topicName",
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: GooglePoppinsWidgets(
                          fontsize: 14.h,
                          text: 'Pdf',
                          fontWeight: FontWeight.bold),
                    ),
                    kHeight10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GooglePoppinsWidgets(
                            text: "Posted By :", fontsize: 15.h),
                        GooglePoppinsWidgets(
                          text: 'uploadedBy',
                          fontsize: 15.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
                title: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: GooglePoppinsWidgets(
                    fontsize: 20.h,
                    text: 'title',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: InkWell(
                  child: GooglePoppinsWidgets(
                      text: "View".tr,
                      fontsize: 16.h,
                      fontWeight: FontWeight.w500,
                      color: themeColor),
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const PDFSectionScreen(
                    //               urlPdf: 'downloadUrl',
                    //             )));
                  },
                ),
              );
            },
          )),
    );
  }
}
