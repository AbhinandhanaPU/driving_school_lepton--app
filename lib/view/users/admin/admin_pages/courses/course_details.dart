import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({super.key, required this.data});
  final CourseModel data;

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
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Name
              Text(
                data.courseName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: cblack,
                ),
              ),
              SizedBox(height: 20),

              // Course Rate
              Text(
                "Rate: ${data.rate}/-",
                style: TextStyle(
                  fontSize: 18,
                  color: cblack,
                ),
              ),
              SizedBox(height: 10),

              // Course Duration
              Text(
                "Duration: ${data.duration} Days",
                style: TextStyle(
                  fontSize: 18,
                  color: cblack,
                ),
              ),
              SizedBox(height: 10),

              // Course Description
              Text(
                "Description:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: cblack,
                ),
              ),
              SizedBox(height: 5),
              Text(
                data.courseDes,
                style: TextStyle(
                  fontSize: 16,
                  color: cgrey,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
