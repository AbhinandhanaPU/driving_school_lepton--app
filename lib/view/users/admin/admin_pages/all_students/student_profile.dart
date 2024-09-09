import 'dart:developer';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/student_controller/student_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/batch_model/batch_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/widgets/catagory_table_header_widget/data_container_widget/profile_details_widget.dart';
import 'package:new_project_app/view/widgets/loading_widget/lottie_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class StudentProfile extends StatelessWidget {
  final StudentModel studentModel;

  StudentProfile({
    super.key,
    required this.studentModel,
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
                  backgroundImage: NetworkImage(studentModel.profileImageUrl)
                  // AssetImage("assets/images/profilebg.png"),
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                studentModel.studentName,
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
                        content: studentModel.studentemail,
                      ),
                      kHeight20,
                      FutureBuilder<List<String>>(
                        future:
                            studentController.fetchStudentsCourse(studentModel),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const LottieLoadingWidet();
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
                      studentModel.batchId.isEmpty
                          ? TextFontWidget(
                              text: 'Batch NOt Assigned',
                              fontsize: 14.h,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            )
                          : FutureBuilder(
                              future: server
                                  .collection('DrivingSchoolCollection')
                                  .doc(UserCredentialsController.schoolId)
                                  .collection('Batch')
                                  .doc(studentModel.batchId)
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const LottieLoadingWidet();
                                } else if (snapshot.hasError) {
                                  log('Error fetching batch data: ${snapshot.error}');
                                  return Text('Error: ${snapshot.error}');
                                } else if (!snapshot.hasData ||
                                    !snapshot.data!.exists) {
                                  log('No data found for batchId: ${studentModel.batchId}');
                                  return const Text('Batch Not Found');
                                } else {
                                  final batchData = BatchModel.fromMap(
                                      snapshot.data!.data()!);
                                  String batchName = batchData.batchName.isEmpty
                                      ? "Not found"
                                      : batchData.batchName;
                                  log('Batch name for batchId ${studentModel.batchId}: $batchName');
                                  return ProfileDetailsWidget(
                                    title: "Batch",
                                    content: batchName,
                                  );
                                }
                              },
                            ),
                      kHeight20,
                      ProfileDetailsWidget(
                        title: "Status",
                        content: studentModel.status.toString(),
                      ),
                      kHeight20,
                      ProfileDetailsWidget(
                        title: "Joining Date",
                        content:
                            stringTimeToDateConvert(studentModel.joiningDate),
                      ),
                      kHeight20,
                      ProfileDetailsWidget(
                        title: "Phone Number",
                        content: studentModel.phoneNumber,
                      ),
                      kHeight20,
                      ProfileDetailsWidget(
                        title: "Date of Birth",
                        content: studentModel.dateofBirth,
                      ),
                      kHeight20,
                      ProfileDetailsWidget(
                        title: "Address",
                        content: studentModel.address,
                      ),
                      kHeight20,
                      ProfileDetailsWidget(
                        title: "Place",
                        content: studentModel.place,
                      ),
                      kHeight20,
                      ProfileDetailsWidget(
                        title: "Guardian Name",
                        content: studentModel.guardianName,
                      ),
                      kHeight20,
                      ProfileDetailsWidget(
                        title: "RTO Name",
                        content: studentModel.rtoName,
                      ),
                      kHeight20,
                      ProfileDetailsWidget(
                        title: "Licence Number",
                        content: studentModel.licenceNumber,
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
