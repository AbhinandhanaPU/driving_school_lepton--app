import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/model/event_model/events_model.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class EventDisplayAdmin extends StatelessWidget {
  const EventDisplayAdmin({
    super.key,
    required this.data,
  });
  final EventModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Event".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: ListView(
        children: [
          kHeight30,
          Padding(
            padding: EdgeInsets.all(17.h),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.h),
                color: Colors.blue[50],
              ),
              height: 650.h,
              width: 360.w,
              child: Padding(
                padding: EdgeInsets.all(15.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GooglePoppinsWidgets(
                            text: data.eventName, fontsize: 22.h),
                        const Icon(Icons.event_note)
                      ],
                    ),
                    kHeight50,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: GooglePoppinsWidgets(
                            text: "Description",
                            fontsize: 18.h,
                            fontWeight: FontWeight.w200,
                          ),
                        )
                      ],
                    ),
                    kHeight20,
                    GooglePoppinsWidgets(
                        text: data.eventDescription,
                        // "This is to inform all the students that  __________________  will be  conductod __________________  at __________________  .______________ will be grace the occasion .",
                        fontsize: 18.h),
                    kHeight10,
                    Row(
                      children: [
                        GooglePoppinsWidgets(
                            text: "Date : ${data.eventDate}",
                            fontsize: 18.h,
                            fontWeight: FontWeight.w200),
                      ],
                    ),
                    kHeight10,
                    Row(
                      children: [
                        Flexible(
                          child: GooglePoppinsWidgets(
                              text: "Venue : ${data.venue}",
                              fontsize: 18.h,
                              fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                    kHeight30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GooglePoppinsWidgets(
                            text: "Signed by : ${data.signedBy}",
                            fontsize: 18.h,
                            fontWeight: FontWeight.w200),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
