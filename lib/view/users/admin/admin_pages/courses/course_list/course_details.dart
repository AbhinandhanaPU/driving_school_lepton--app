import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/responsive.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/controller/course_controller/course_controller.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/courses/course_std_list/course_std_list.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';
import 'package:new_project_app/view/widgets/catagory_table_header_widget/data_container_widget/profile_details_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class CourseDetails extends StatelessWidget {
  CourseDetails({super.key, required this.data});
  final CourseModel data;
  final CourseController courseController = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Course Details".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // course details
                Container(
                  padding:
                      EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 20),
                  decoration: BoxDecoration(
                    color: themeColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Course Name
                      Center(
                        child: Text(
                          data.courseName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: cblack,
                          ),
                        ),
                      ),
                      kHeight30,
                      // Course Rate
                      ProfileDetailsWidget(
                        title: 'Fee',
                        content: '${data.rate}',
                      ),
                      kHeight10, // Course Duration
                      ProfileDetailsWidget(
                        title: 'Duration',
                        content: "${data.duration} Days",
                      ),
                      kHeight20, // Course Description
                      Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        data.courseDes,
                        style: TextStyle(
                          fontSize: ResponsiveApp.width * .04,
                        ),
                      ),
                    ],
                  ),
                ),
                //  Students details
                kHeight40,
                Center(
                  child: Text(
                    "Students Details",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                    ),
                  ),
                ),
                kHeight40,
                StreamBuilder(
                  stream: courseController
                      .fetchStudentsWithStatusTrue(data.courseId),
                  builder: (context, snapshot) {
                    final studentCount =
                        snapshot.hasData ? snapshot.data!.length : 0;
                    return ProfileDetailsWidget(
                      title: "Total students",
                      content: studentCount.toString(),
                    );
                  },
                ),
              ],
            ),
            Positioned(
              bottom: 30,
              right: 40,
              left: 40,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CourseStudentsList(data: data);
                      },
                    ),
                  );
                },
                child: ButtonContainerWidget(
                  curving: 30,
                  colorindex: 0,
                  height: 60,
                  width: 140,
                  child: const Center(
                    child: TextFontWidgetRouter(
                      text: 'Subscribers',
                      fontsize: 20,
                      fontWeight: FontWeight.bold,
                      color: cWhite,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
