// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/model/teacher_model/teacher_model.dart';
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
                  backgroundImage: NetworkImage(data.profileImageUrl!)
                  // AssetImage("assets/images/profilebg.png"),
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
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: cgrey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: const Text(
                        "Tutor Details",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    kHeight30,
                    ProfileDetailsWidget(
                      title: "Email",
                      content: data.teacheremail!,
                    ),
                    kHeight20,
                    ProfileDetailsWidget(
                      title: "Phone Number",
                      content: data.phoneNumber!,
                    ),
                    kHeight20,
                    ProfileDetailsWidget(
                      title: "Licence Number",
                      content: data.licenceNumber!,
                    ),
                    kHeight20,
                    ProfileDetailsWidget(
                      title: "Date of Birth",
                      content: data.dateofBirth!,
                    ),
                    kHeight20,
                    ProfileDetailsWidget(
                      title: "Address",
                      content: data.address!,
                    ),
                    kHeight20,
                    ProfileDetailsWidget(
                      title: "Place",
                      content: data.place!,
                    ),
                    kHeight20,
                    ProfileDetailsWidget(
                      title: "Guardian Name",
                      content: data.guardianName!,
                    ),
                    kHeight20,
                    ProfileDetailsWidget(
                      title: "RTO Name",
                      content: data.rtoName!,
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
