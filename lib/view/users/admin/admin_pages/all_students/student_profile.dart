import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/view/widgets/catagory_table_header_widget/data_container_widget/profile_details_widget.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({super.key});

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
                backgroundImage: AssetImage("assets/flaticons/student.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Akhil N',
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
                    kHeight50,
                    ProfileDetailsWidget(
                      testName: "Permission Status",
                      testDetails: "",
                    ),
                    kHeight20,
                    ProfileDetailsWidget(
                      testName: "Test Status",
                      testDetails: "",
                    ),
                    kHeight20,
                    ProfileDetailsWidget(
                        testName: "Phone Number", testDetails: ""),
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
