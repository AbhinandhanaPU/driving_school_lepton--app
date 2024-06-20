import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/view/users/student/student_pages/notices/notice_display_page.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // DefaultTabController(
        //   length: 2,
        //  child:
        SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notices".tr),
          flexibleSpace: const AppBarColorWidget(),
          foregroundColor: cWhite,
        ),
        body: SafeArea(
            child: ListView.separated(
          //   reverse: true,
          itemCount: 1,
          // studentNoticeController.schoolLevelNoticeLists.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 10.h, right: 10.w, left: 10.w),
              child: Card(
                child: ListTile(
                  shape: BeveledRectangleBorder(
                      side: BorderSide(color: Colors.grey.withOpacity(0.2))),
                  leading: const Image(
                      image: NetworkImage(
                          "https://media.istockphoto.com/id/926144358/photo/portrait-of-a-little-bird-tit-flying-wide-spread-wings-and-flushing-feathers-on-white-isolated.jpg?b=1&s=170667a&w=0&k=20&c=DEARMqqAI_YoA5kXtRTyYTYU9CKzDZMqSIiBjOmqDNY=")),
                  title: GooglePoppinsWidgets(
                    fontsize: 22.h,
                    text: "Notice head",
                  ),
                  subtitle: GooglePoppinsWidgets(
                    fontsize: 14.h,
                    text: "publishedDate",
                  ),
                  trailing: InkWell(
                    child: GooglePoppinsWidgets(
                        text: "View".tr,
                        fontsize: 16.h,
                        fontWeight: FontWeight.w300,
                        color: Colors.blue),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NoticeDisplayPage(
                                // noticeModel: data
                                // studentNoticeController
                                //     .schoolLevelNoticeLists[index]
                                ),
                          ));
                    },
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Text('');
          },
        )),
      ),
    );
  }
}
