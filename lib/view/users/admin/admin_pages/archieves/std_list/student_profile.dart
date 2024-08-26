import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/student_controller/student_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/widgets/catagory_table_header_widget/data_container_widget/profile_details_widget.dart';

class StudentProfile extends StatelessWidget {
  final StudentModel data;

  StudentProfile({
    super.key,
    required this.data,
  });

  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Student Profile'),
          foregroundColor: cWhite,
          backgroundColor: themeColor,
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(data.profileImageUrl),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  data.studentName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
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
                      TabBar(
                        labelColor: cblack,
                        unselectedLabelColor: cgrey,
                        indicatorColor: cblue,
                        isScrollable: true,
                        tabs: const [
                          Tab(text: 'Personal Details'),
                          Tab(text: 'Course Details'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  kHeight30,
                                  ProfileDetailsWidget(
                                    title: "Email",
                                    content: data.studentemail,
                                  ),
                                  kHeight20,
                                  ProfileDetailsWidget(
                                    title: "Joining Date",
                                    content: stringTimeToDateConvert(
                                        data.joiningDate),
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
                            StreamBuilder(
                                stream: server
                                    .collection('DrivingSchoolCollection')
                                    .doc(UserCredentialsController.schoolId)
                                    .collection('Archives')
                                    .doc(data.docid)
                                    .collection('CoursesDetails')
                                    .doc(data.docid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (!snapshot.hasData ||
                                      !snapshot.data!.exists) {
                                    return const Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Center(
                                          child: Text(
                                              'No course and batch details found')),
                                    );
                                  }
                                  var courseData = snapshot.data!.data()!;
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        kHeight20,
                                        ProfileDetailsWidget(
                                          title: 'Course Name',
                                          content:
                                              courseData['courseName'] ?? 'N/A',
                                        ),
                                        kHeight20,
                                        ProfileDetailsWidget(
                                          title: 'Batch Name',
                                          content:
                                              courseData['batchName'] ?? 'N/A',
                                        ),
                                        kHeight20,
                                        ProfileDetailsWidget(
                                          title: 'Practice Schedule Name',
                                          content: courseData['practiceName'] ??
                                              'N/A',
                                        ),
                                        kHeight20,
                                        ProfileDetailsWidget(
                                          title: 'Driving Test Date',
                                          content:
                                              courseData['testDate'] ?? 'N/A',
                                        ),
                                        kHeight20,
                                        ProfileDetailsWidget(
                                          title: 'Fee Status',
                                          content:
                                              courseData['feeStatus'] ?? 'N/A',
                                        ),
                                        kHeight20,
                                        ProfileDetailsWidget(
                                            title: 'Pending Amount',
                                            content: courseData['pendingAmount']
                                                .toString()),
                                        kHeight20,
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
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
