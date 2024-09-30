import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/fonts/text_widget.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/event_controller/event_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/event_model/events_model.dart';
import 'package:new_project_app/view/users/teacher/teacher_pages/events_tutor/event_display_tutor.dart';
import 'package:new_project_app/view/users/widgets/listcard_widget/listcard_widget.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class EventsListOfTutor extends StatelessWidget {
  EventsListOfTutor({super.key});
  final EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Events".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: Stack(
        children: [
          StreamBuilder(
            stream: server
                .collection('DrivingSchoolCollection')
                .doc(UserCredentialsController.schoolId)
                .collection('AdminEvents')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    'No Events',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                );
              }
              if (snapshot.hasData) {
                return ListView.separated(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    EventModel data =
                        EventModel.fromMap(snapshot.data!.docs[index].data());

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 10, left: 10),
                          child: ListTileCardWidget(
                            leading: const Icon(Icons.event_sharp),
                            title: GooglePoppinsWidgets(
                                text: data.eventName, fontsize: 19.h),
                            subtitle: GooglePoppinsWidgets(
                                text: data.eventDate, fontsize: 14.h),
                            trailing: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EventDisplayTutor(data: data),
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
                        ),
                        kHeight10
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 1);
                  },
                );
              } else {
                return const LoadingWidget();
              }
            },
          ),
        ],
      ),
    );
  }
}
