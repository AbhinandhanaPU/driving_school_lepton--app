import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/view/users/widgets/listcard_widget/listcard_widget.dart';
import 'package:new_project_app/view/users/widgets/video_player/play_video.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class VideosListStudent extends StatelessWidget {
  const VideosListStudent({super.key});

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
        body: StreamBuilder(
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
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 10),
                      child: ListTileCardWidget(
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
                        trailing: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlayVideoFlicker(
                                    videoUrl: data['downloadUrl']),
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
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(child: Text('No Videos Uploaded Yet!'.tr));
          },
        ),
      ),
    );
  }
}
