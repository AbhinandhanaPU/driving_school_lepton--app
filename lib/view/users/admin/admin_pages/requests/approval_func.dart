import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/users/widgets/std_fees_level/std_fees_level.dart';
import 'package:new_project_app/view/widgets/loading_widget/lottie_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

approvalDialogBox(
  BuildContext context,
  CourseModel courseModel,
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
                stream: data.batchId.isNotEmpty && data.docid.isNotEmpty
                    ? server
                        .collection('DrivingSchoolCollection')
                        .doc(UserCredentialsController.schoolId)
                        .collection('FeesCollection')
                        .doc(data.batchId)
                        .collection('Courses')
                        .doc(courseModel.courseId)
                        .collection('Students')
                        .doc(data.docid)
                        .snapshots()
                    : null,
                builder: (context, snapshot) {
                  if (data.batchId.isEmpty || data.docid.isEmpty) {
                    return const Center(
                      child: Text('Batch Not Assigned'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LottieLoadingWidet();
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  String? feeStatus;
                  if (snapshot.hasData && snapshot.data?.data() != null) {
                    final feeData = snapshot.data!.data();
                    feeStatus = feeData!['feeStatus'] ?? 'not paid';
                  }

                  return StdFeesLevelDropDown(
                    data: data,
                    course: courseModel,
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
