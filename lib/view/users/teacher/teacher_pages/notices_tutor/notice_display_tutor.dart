import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/model/notice_model/notice_model.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class NoticeDisplayTutor extends StatelessWidget {
  const NoticeDisplayTutor({
    super.key,
    required this.noticeModel,
  });
  final NoticeModel noticeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Notice".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: ListView(
        children: [
          Container(
            width: 90.w,
            height: 900.h,
            decoration: const BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                kHeight10,
                const SizedBox(
                  height: 150,
                  width: 150,
                  child: Image(
                    image: NetworkImage(
                        "https://media.istockphoto.com/id/926144358/photo/portrait-of-a-little-bird-tit-flying-wide-spread-wings-and-flushing-feathers-on-white-isolated.jpg?b=1&s=170667a&w=0&k=20&c=DEARMqqAI_YoA5kXtRTyYTYU9CKzDZMqSIiBjOmqDNY="),
                    fit: BoxFit.fill,
                  ),
                ),
                kHeight30,
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.h),
                        child: Container(
                          height: 600.h,
                          width: 360.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 25, right: 25, top: 30, bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GooglePoppinsWidgets(
                                      text: noticeModel.heading,
                                      fontsize: 22.h,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                                kHeight20,
                                GooglePoppinsWidgets(
                                    text:
                                        "This is to inform all the students that  ${noticeModel.subject} will be  conducted .",
                                    fontsize: 19.h),
                                kHeight30,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GooglePoppinsWidgets(
                                      text:
                                          "Date : '${noticeModel.publishedDate}' ",
                                      fontsize: 17.h,
                                    ),
                                  ],
                                ),
                                kHeight10,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GooglePoppinsWidgets(
                                      text:
                                          "Signed by: ${noticeModel.signedBy}",
                                      fontsize: 17.h,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
