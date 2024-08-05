// ignore_for_file: must_be_immutable

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/notice_controller/notice_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/notice_model/notice_model.dart';
import 'package:new_project_app/view/users/teacher/teacher_pages/notices_tutor/notice_display_tutor.dart';
import 'package:new_project_app/view/users/widgets/listcard_widget/listcard_widget.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class NoticePageTutor extends StatelessWidget {
  NoticePageTutor({super.key});

  NoticeController noticeController = Get.put(NoticeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Notices".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            StreamBuilder(
              stream: server
                  .collection('DrivingSchoolCollection')
                  .doc(UserCredentialsController.schoolId)
                  .collection('AdminNotices')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Notices',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    NoticeModel data =
                        NoticeModel.fromMap(snapshot.data!.docs[index].data());

                    return Padding(
                      padding:
                          EdgeInsets.only(right: 10.w, left: 10.w, top: 10.w),
                      child: ListTileCardWidget(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NoticeDisplayTutor(noticeModel: data),
                            ),
                          );
                        },
                        leading: const Image(
                            image: NetworkImage(
                                "https://media.istockphoto.com/id/926144358/photo/portrait-of-a-little-bird-tit-flying-wide-spread-wings-and-flushing-feathers-on-white-isolated.jpg?b=1&s=170667a&w=0&k=20&c=DEARMqqAI_YoA5kXtRTyYTYU9CKzDZMqSIiBjOmqDNY=")),
                        title: GooglePoppinsWidgets(
                          fontsize: 22.h,
                          text: data.heading,
                        ),
                        subtitle: GooglePoppinsWidgets(
                          fontsize: 14.h,
                          text: data.publishedDate,
                        ),
                        // trailing: PopupMenuButton(
                        //   itemBuilder: (context) {
                        //     return [
                        //       PopupMenuItem(
                        //         onTap: () {
                        //           noticeController.noticeHeadingController
                        //               .text = data.heading;
                        //           noticeController.noticePublishedDateController
                        //               .text = data.publishedDate;
                        //           noticeController.noticeSubjectController
                        //               .text = data.subject;
                        //           noticeController.noticeSignedByController
                        //               .text = data.signedBy;
                        //           editFunctionOfNotice(context, data);
                        //         },
                        //         child: const Text(
                        //           "Edit",
                        //           style: TextStyle(
                        //             fontSize: 16,
                        //           ),
                        //         ),
                        //       ),
                        //       PopupMenuItem(
                        //         onTap: () {
                        //           customDeleteShowDialog(
                        //             context: context,
                        //             onTap: () {
                        //               noticeController
                        //                   .deleteNotice(data.noticeId, context)
                        //                   .then((value) =>
                        //                       Navigator.pop(context));
                        //             },
                        //           );
                        //         },
                        //         child: const Text(
                        //           " Delete",
                        //           style: TextStyle(
                        //             fontSize: 16,
                        //           ),
                        //         ),
                        //       )
                        //     ];
                        //   },
                        // ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return kHeight10;
                  },
                );
              },
            ),
            // Positioned(
            //   bottom: 20,
            //   right: 20,
            //   child: GestureDetector(
            //     onTap: () {
            //       Navigator.push(context, MaterialPageRoute(
            //         builder: (context) {
            //           return NoticeCreate();
            //         },
            //       ));
            //     },
            //     child: ButtonContainerWidget(
            //       curving: 30,
            //       colorindex: 0,
            //       height: 40,
            //       width: 140,
            //       child: const Center(
            //         child: TextFontWidgetRouter(
            //           text: 'Create Notice',
            //           fontsize: 14,
            //           fontWeight: FontWeight.bold,
            //           color: cWhite,
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
