import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/controller/admin_controller/admin_controller.dart';
import 'package:new_project_app/controller/student_controller/student_controller.dart';
import 'package:new_project_app/model/course_model/course_model.dart';
import 'package:new_project_app/model/student_model/student_model.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';
import 'package:shimmer/shimmer.dart';

class NotificationPartOfAdmin extends StatelessWidget {
  NotificationPartOfAdmin({super.key});
  final StudentController studentController = Get.put(StudentController());
  final AdminController adminController = Get.put(AdminController());


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'NOTIFICATIONS',
              style: TextStyle(
                  color: const Color.fromARGB(255, 11, 2, 74),
                  //const Color.fromARGB(255, 48, 88, 86),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 1.h,
                  color: const Color.fromARGB(255, 11, 2, 74).withOpacity(0.1),
                  // const Color.fromARGB(255, 48, 88, 86).withOpacity(0.1),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      "Do you want to clear all notifications ?",
                      style: TextStyle(fontSize: 16),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "No",
                          style: TextStyle(color: cblack),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          // await pushNotificationController
                          //     .removeAllNotification();
                        },
                        child: const Text(
                          "yes",
                          style: TextStyle(color: cblack),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                "Clear All",
                style: TextStyle(color: cblack.withOpacity(0.8)),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 350.h,
          child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: studentController.streamStudentsFromAllCourses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text("No students requested to join courses."));
                } else {
                  final studentCourseList = snapshot.data!;

                    if (adminController.openedNotifications.length != studentCourseList.length) {
                  adminController.openedNotifications.value =
                      List<bool>.filled(studentCourseList.length, false);
                }
                  return ListView.separated(
                    itemCount: studentCourseList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final course =
                          studentCourseList[index]["course"] as CourseModel;
                      final student =
                          studentCourseList[index]["student"] as StudentModel;
                      return Obx(() =>
                      InkWell(
                        onTap: () {
                          adminController.openedNotifications[index] = true;
                          showModalBottomSheet(
                            shape: const BeveledRectangleBorder(),
                            context: context,
                            builder: (context) {
                              return SingleChildScrollView(
                                child: Container(
                                  color: cbluelight,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        color: cblue,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: const Row(
                                          children: [
                                            Icon(
                                              Icons.group_add,
                                              size: 25,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "New Student Request",
                                                style: TextStyle(
                                                    color: cWhite,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Text(
                                          "${student.studentName} Requested to Join ${course.courseName} Course ",
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: cWhite,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: cbluelight,
                            radius: 25,
                            child: Center(
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: cbluelight,
                                child: Center(
                                  child: Icon(
                                    Icons.group_add_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          title: 
                          //Obx(() =>
                            adminController.openedNotifications[index]
                              ? const Text(
                                  "New Student Request",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 48, 88, 86),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ): Shimmer.fromColors(
                            baseColor: Colors.black,
                            highlightColor: Colors.grey.withOpacity(0.1),
                            child: const Text(
                              "New Student Request",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 48, 88, 86),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                         //  ),
                          subtitle: Text(
                            "${student.studentName} Requested to Join` ${course.courseName} Course ",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Color.fromARGB(255, 48, 88, 86),
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                    "Do you want to remove the notification ?",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "No",
                                        style: TextStyle(color: cblack),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        // await pushNotificationController
                                        //     .removeSingleNotification(
                                        //         data['docid']);
                                      },
                                      child: const Text(
                                        "yes",
                                        style: TextStyle(color: cblack),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Icon(
                              Icons.close,
                              size: 20,
                              color: cblack.withOpacity(0.8),
                            ),
                          ),
                        ),),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox();
                    },
                  );
                }
              }),
        )
      ],
    );
  }
}
