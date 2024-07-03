import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/notice_model/notice_model.dart';
import 'package:new_project_app/view/users/student/student_pages/notices/notice_display_std.dart';
import 'package:new_project_app/view/users/widgets/listcard_widget/listcard_widget.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class NoticePageStudent extends StatelessWidget {
  const NoticePageStudent({super.key});

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
      body: SafeArea(
        child: StreamBuilder(
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ));
            }
            return ListView.separated(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                NoticeModel data =
                    NoticeModel.fromMap(snapshot.data!.docs[index].data());

                return Padding(
                  padding: EdgeInsets.only(right: 10.w, left: 10.w, top: 10.w),
                  child: ListTileCardWidget(
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
                            builder: (context) =>
                                NoticeDisplayPageStudent(noticeModel: data),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return kHeight10;
              },
            );
          },
        ),
      ),
    );
  }
}
