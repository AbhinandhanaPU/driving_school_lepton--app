import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/teacher_model/teacher_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/all_tutors/create_new_tutor.dart';
import 'package:new_project_app/view/users/admin/admin_pages/all_tutors/tutor_profile.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class AllTutorsHomePage extends StatelessWidget {
  const AllTutorsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Tutors'),
          foregroundColor: cWhite,
          backgroundColor: themeColor,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                kHeight10,
                Expanded(
                  child: StreamBuilder(
                    stream: server
                        .collection('DrivingSchoolCollection')
                        .doc(UserCredentialsController.schoolId)
                        .collection('Teachers')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          itemCount: snapshot.data!.docs.length,
                          separatorBuilder: ((context, index) {
                            return kHeight10;
                          }),
                          itemBuilder: (BuildContext context, int index) {
                            final data = TeacherModel.fromMap(snapshot.data!.docs[index].data());
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return TutorProfile(
                                      data: data,
                                    );
                                  },
                                ));
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15, right: 15),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: cblack.withOpacity(0.2))),
                                      height: 150,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage: data.profileImageUrl == ''
                                                      ? const NetworkImage(
                                                          'https://firebasestorage.googleapis.com/v0/b/vidya-veechi-8-feb-2024.appspot.com/o/important***%2Fteacher-avathar2.png?alt=media&token=3db0d66c-225d-429b-a34e-f71b6b7dde7d')
                                                      : NetworkImage(
                                                          data.profileImageUrl!,
                                                        ),
                                                  onBackgroundImageError:
                                                      (exception, stackTrace) {},
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 10.h),
                                                  child: TextFontWidget(
                                                    text: data.teacherName!,
                                                    fontsize: 21.h,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 10.h),
                                              child: Row(
                                                children: [
                                                  TextFontWidget(
                                                    text: '✉️  Email :  ',
                                                    fontsize: 15.h,
                                                    fontWeight: FontWeight.bold,
                                                    color: cblack,
                                                  ),
                                                  TextFontWidget(
                                                    text: data.teacheremail!,
                                                    fontsize: 14.h,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 10.h),
                                              child: Row(
                                                children: [
                                                  TextFontWidget(
                                                    text: '📞  Phone No  :  ',
                                                    fontsize: 15.h,
                                                    fontWeight: FontWeight.bold,
                                                    color: cblack,
                                                  ),
                                                  TextFontWidget(
                                                    text: data.phoneNumber!,
                                                    fontsize: 14.h,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return const LoadingWidget();
                      }
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return CreateTutor();
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
                        text: 'Create Tutor',
                        fontsize: 14,
                        fontWeight: FontWeight.bold,
                        color: cWhite,
                      ),
                    )),
              ),
            )
          ],
        ));
  }
}
