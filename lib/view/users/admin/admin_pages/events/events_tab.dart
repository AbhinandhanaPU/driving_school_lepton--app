import 'package:flutter/material.dart';
import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/view/users/admin/admin_pages/events/events_home.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class SchoolLevelPage extends StatelessWidget {
  const SchoolLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      body: ListView.separated(
        itemCount: 10, // Number of dummy items
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: Card(
                  child: ListTile(
                    shape: BeveledRectangleBorder(
                        side: BorderSide(color: Colors.grey.withOpacity(0.2))),
                    leading: const Icon(Icons.event_sharp),
                    trailing: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventsHomePage(
                              // eventData: {
                              //   'eventName': 'Dummy Event $index',
                              //   'eventDate': '2023-12-31'
                              // },
                            ),
                          ),
                        );
                      },
                      child: GooglePoppinsWidgets(
                        text: "View".tr,
                        fontsize: 16.h,
                        color: Colors.green,
                      ),
                    ),
                    title: GooglePoppinsWidgets(text: 'Dummy Event $index', fontsize: 19.h),
                    subtitle: GooglePoppinsWidgets(text: '2023-12-31', fontsize: 14.h),
                  ),
                ),
              ),
              kHeight10
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 5,);
        },
      ),
    );
  }
}
