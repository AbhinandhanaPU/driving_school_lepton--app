import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/new_admin_model/new_admin_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/create_admin/admin_creation.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';
import 'package:new_project_app/view/widgets/custom_show_dialogbox/custom_showdilog.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class AdminList extends StatelessWidget {
  const AdminList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Secondary Admins".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
        //  backgroundColor: adminePrimayColor,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: server
                      .collection('DrivingSchoolCollection')
                      .doc(UserCredentialsController.schoolId)
                      .collection('Admins')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final data = AdminDetailsModel.fromMap(
                              snapshot.data!.docs[index].data());
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 15,
                                  left: 15,
                                  right: 15,
                                  bottom: 8,
                                ),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: cWhite,
                                  boxShadow: [
                                    BoxShadow(
                                      color: cblack.withOpacity(0.1),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                      // changes position of shadow
                                    ),
                                  ],
                                ),
                                height: 150,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: const NetworkImage(
                                                'https://firebasestorage.googleapis.com/v0/b/vidya-veechi-8-feb-2024.appspot.com/o/important***%2Fteacher-avathar2.png?alt=media&token=3db0d66c-225d-429b-a34e-f71b6b7dde7d'), // : NetworkImage(

                                            onBackgroundImageError:
                                                (exception, stackTrace) {},
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.h),
                                            child: TextFontWidget(
                                              text: data.username,
                                              fontsize: 21.h,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: GestureDetector(
                                              onTap: () {
                                                data.active == true
                                                    ? customShowDilogBox2(
                                                        children: [
                                                          const TextFontWidget(
                                                              text:
                                                                  "Do you want deactive this admin now ?",
                                                              fontsize: 14)
                                                        ],
                                                        doyouwantActionButton:
                                                            true,
                                                        context: context,
                                                        title: "Alert",
                                                        actiononTapfuction:
                                                            () async {
                                                          server
                                                              .collection(
                                                                  'DrivingSchoolCollection')
                                                              .doc(
                                                                  UserCredentialsController
                                                                      .schoolId)
                                                              .collection(
                                                                  'Admins')
                                                              .doc(data.docid)
                                                              .update({
                                                            "active": false
                                                          }).then((value) =>
                                                                  Navigator.pop(
                                                                      context));
                                                        },
                                                      )
                                                    : customShowDilogBox2(
                                                        children: [
                                                            const TextFontWidget(
                                                              text:
                                                                  "Do you want active this admin now ?",
                                                              fontsize: 14,
                                                            )
                                                          ],
                                                        doyouwantActionButton:
                                                            true,
                                                        context: context,
                                                        title: "Alert",
                                                        actiononTapfuction:
                                                            () async {
                                                          server
                                                              .collection(
                                                                  'DrivingSchoolCollection')
                                                              .doc(
                                                                  UserCredentialsController
                                                                      .schoolId)
                                                              .collection(
                                                                  'Admins')
                                                              .doc(data.docid)
                                                              .update({
                                                            "active": true
                                                          }).then((value) =>
                                                                  Navigator.pop(
                                                                      context));
                                                        });
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 15,
                                                    child: Image.asset(
                                                      data.active == true
                                                          ? 'assets/flaticons/active.png'
                                                          : 'assets/flaticons/shape.png',
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: TextFontWidget(
                                                      text: data.active == true
                                                          ? "Active"
                                                          : "Deactive",
                                                      fontsize: 12,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
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
                                              text: '${data.email}',
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
                                              text: ' ${data.phoneNumber}',
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
                            ],
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
                    return CreateSecondaryAdmin();
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
                      text: 'Create Admin',
                      fontsize: 14,
                      fontWeight: FontWeight.bold,
                      color: cWhite,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
