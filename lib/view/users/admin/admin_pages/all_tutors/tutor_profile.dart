// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/model/teacher_model/teacher_model.dart';
import 'package:new_project_app/view/colors/colors.dart';
import 'package:new_project_app/view/widgets/catagory_table_header_widget/data_container_widget/profile_details_widget.dart';

class TutorProfile extends StatelessWidget {
  final TeacherModel data;
  const TutorProfile({
    Key? key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutor Profile'),
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
                backgroundImage: AssetImage("assets/images/profilebg.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data.teacherName!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: cgrey1,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "Tutor Details",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    kHeight30,
                    ProfileDetailsWidget(
                      testName: "Email",
                      testDetails: data.teacheremail!,
                    ),
                    kHeight20,
                    ProfileDetailsWidget(
                      testName: "Phone Number",
                      testDetails: data.phoneNumber!,
                    ),
                    kHeight20,
                    ProfileDetailsWidget(
                      testName: "Joining Date",
                      testDetails: "",
                    ),
                    kHeight20,
                    ProfileDetailsWidget(
                      testName: "Salary",
                      testDetails: "",
                    ),
                    kHeight20,
                    ProfileDetailsWidget(
                      testName: "Licence Number",
                      testDetails: data.licenceNumber!,
                    ),
                    kHeight20,
                    ProfileDetailsWidget(
                      testName: "Address",
                      testDetails: data.address!,
                    ),
                    kHeight20,
                    ProfileDetailsWidget(
                      testName: "Place",
                      testDetails: data.place!,
                    ),
                    kHeight20,
                    ProfileDetailsWidget(
                      testName: "Guardian Name",
                      testDetails: data.guardianName!,
                    ),
                    kHeight20,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
