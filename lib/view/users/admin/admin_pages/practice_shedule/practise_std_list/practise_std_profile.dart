import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/controller/student_controller/student_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/widgets/catagory_table_header_widget/data_container_widget/profile_details_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class PractiseScheduleStudentProfile extends StatelessWidget {
  final StudentModel stdata;
  PractiseScheduleStudentProfile({super.key, required this.stdata});

  @override
  Widget build(BuildContext context) {
    StudentController studentController = Get.put(StudentController());

    String formatDate(String? dateTimeString) {
      if (dateTimeString == null) {
        return "Not Found";
      }
      try {
        DateTime dateTime = DateTime.parse(dateTimeString);
        return DateFormat('yyyy-MM-dd').format(dateTime);
      } catch (e) {
        return "Invalid Date";
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
        foregroundColor: cWhite,
        backgroundColor: themeColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: stdata.profileImageUrl == ''
                      ? const NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/vidya-veechi-8-feb-2024.appspot.com/o/important***%2Fteacher-avathar2.png?alt=media&token=3db0d66c-225d-429b-a34e-f71b6b7dde7d')
                      : NetworkImage(
                          stdata.profileImageUrl,
                        ),
                  onBackgroundImageError: (exception, stackTrace) {},
                  //  backgroundImage: AssetImage("assets/flaticons/student.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  stdata.studentName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 500,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: cgreylite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 200),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      kHeight10,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          "Student Details",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      kHeight30,
                      ProfileDetailsWidget(
                        title: "Permission Status",
                        content: stdata.status.toString(),
                      ),
                      kHeight20,
                      ProfileDetailsWidget(
                        title: "Joining Date",
                        content: formatDate(stdata.joiningDate),
                      ),
                      kHeight20,
                      FutureBuilder<List<String>>(
                        future: studentController.fetchStudentsCourse(stdata),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return TextFontWidget(
                              text: 'No Course',
                              fontsize: 14.h,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            );
                          } else {
                            String courses = snapshot.data!.join(', ');
                            return ProfileDetailsWidget(
                              title: "Course",
                              content: courses,
                            );
                          }
                        },
                      ),
                      kHeight20,
                      ProfileDetailsWidget(
                          title: "Phone Number", content: stdata.phoneNumber),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
