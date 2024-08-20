import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/users/widgets/std_fees_level/std_fees_level.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

approvalDialogBox(
  BuildContext context,
  CourseModel modelData,
  StudentModel data,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: cWhite,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back)),
            const SizedBox(
              width: 10,
            ),
            const TextFontWidget(
              text: "Payement Status",
              fontsize: 17,
              fontWeight: FontWeight.bold,
            )
          ],
        ),
        content: SizedBox(
          height: 80,
          width: 150,
          child: Column(
            children: [
              StreamBuilder(
                stream: server
                    .collection('DrivingSchoolCollection')
                    .doc(UserCredentialsController.schoolId)
                    .collection('FeeCollection')
                    .doc(modelData.courseId)
                    .collection('Students')
                    .doc(data.docid)
                    .snapshots(),
                builder: (context, snapshot) {
                  String feeStatus = 'not paid';
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData && snapshot.data?.data() != null) {
                    final feeData = snapshot.data!.data();
                    feeStatus = feeData!['feeStatus'] ?? 'not paid';
                  }
                  return StdFeesLevelDropDown(
                    data: data,
                    courseID: modelData.courseId,
                    feeData: feeStatus,
                  );
                },
              ),
            ],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 30,
              width: 80,
              decoration: const BoxDecoration(
                color: themeColor,
              ),
              child: Center(
                child: GooglePoppinsWidgets(
                    text: 'Cancel',
                    color: cWhite,
                    fontsize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      );
    },
  );
}
