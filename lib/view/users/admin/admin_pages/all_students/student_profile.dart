import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/student_controller/student_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/widgets/catagory_table_header_widget/data_container_widget/profile_details_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class StudentProfile extends StatelessWidget {
  final StudentModel data;

  StudentProfile({
    super.key,
    required this.data,
  });
  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
        foregroundColor: cWhite,
        backgroundColor: themeColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(data.profileImageUrl)
                  // AssetImage("assets/images/profilebg.png"),
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data.studentName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: cgrey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      kHeight30,
                      ProfileDetailsWidget(
                        title: "Email",
                        content: data.studentemail,
                      ),
                      kHeight20,
                      StreamBuilder<List<String>>(
                        stream: studentController.fetchStudentsCourse(data),
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
                        title: "Joining Date",
                        content: stringTimeToDateConvert(data.joiningDate),
                      ),
                      kHeight20,
                      ProfileDetailsWidget(
                        title: "Status",
                        content: data.status.toString(),
                      ),
                      kHeight20,
                      ProfileDetailsWidget(
                        title: "Phone Number",
                        content: data.phoneNumber,
                      ),
                      kHeight20,
                      ProfileDetailsWidget(
                        title: "Date of Birth",
                        content: data.dateofBirth,
                      ),
                      kHeight20,
                      ProfileDetailsWidget(
                        title: "Address",
                        content: data.address,
                      ),
                      kHeight20,
                      ProfileDetailsWidget(
                        title: "Place",
                        content: data.place,
                      ),
                      kHeight20,
                      ProfileDetailsWidget(
                        title: "Guardian Name",
                        content: data.guardianName,
                      ),
                      kHeight20,
                      ProfileDetailsWidget(
                        title: "RTO Name",
                        content: data.rtoName,
                      ),
                      kHeight20,
                      ProfileDetailsWidget(
                        title: "Licence Number",
                        content: data.licenceNumber,
                      ),
                      kHeight20,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
