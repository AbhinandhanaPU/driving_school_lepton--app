import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/view/pages/chat/admin_section/admin_chat-screen.dart';
import 'package:new_project_app/view/users/admin/admin_pages/all_students/all_students_homepage.dart';
import 'package:new_project_app/view/users/admin/admin_pages/all_tutors/all_tutor_home_page.dart';
import 'package:new_project_app/view/users/admin/admin_pages/archieves/std_list/all_archieves.dart';
import 'package:new_project_app/view/users/admin/admin_pages/attendence/attendence_book_status_month.dart';
import 'package:new_project_app/view/users/admin/admin_pages/batch/batch_home.dart';
import 'package:new_project_app/view/users/admin/admin_pages/courses/course_list/courses_list.dart';
import 'package:new_project_app/view/users/admin/admin_pages/create_admin/admin_list.dart';
import 'package:new_project_app/view/users/admin/admin_pages/driving_test_page/driving_test_home.dart';
import 'package:new_project_app/view/users/admin/admin_pages/events/events_admin.dart';
import 'package:new_project_app/view/users/admin/admin_pages/fees/fees_home_page.dart';
import 'package:new_project_app/view/users/admin/admin_pages/login_history/login_history.dart';
import 'package:new_project_app/view/users/admin/admin_pages/notices/notices_admin.dart';
import 'package:new_project_app/view/users/admin/admin_pages/notifications/notifications.dart';
import 'package:new_project_app/view/users/admin/admin_pages/practice_shedule/practice_schedule/practice_shedule_home.dart';
import 'package:new_project_app/view/users/admin/admin_pages/requests/request_homepage.dart';
import 'package:new_project_app/view/users/admin/admin_pages/study_materials/study_materials_admin.dart';
import 'package:new_project_app/view/users/admin/admin_pages/videos/video_list_admin.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class QuickActionPartAdmin extends StatelessWidget {
  const QuickActionPartAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
          border: Border.all(color: cblack.withOpacity(0.1)),
          color: themeColor.withOpacity(0.2),
          // const Color.fromARGB(255, 80, 200, 120).withOpacity(0.2),
          borderRadius: BorderRadius.circular(20.sp)),
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'QUICK ACTIONS',
              style: TextStyle(
                  color: const Color.fromARGB(255, 11, 2, 74),
                  // const Color.fromARGB(255, 48, 88, 86),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                viewallMenus(context);
              },
              child: Text(
                "View all",
                style: TextStyle(color: cblack.withOpacity(0.8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

viewallMenus(BuildContext context) {
  double w = MediaQuery.of(context).size.width;
  int columnCount = 3;
  final screenNavigationOfAdmin = [
    const AllTutorsHomePage(), // All Tutors
    AllStudentsHomePage(), // All Students
    AdminList(), // All admins
    CourseList(), // Course
    StudentRequest(), // Course std request
    BatchHome(), // batch
    DrivingHomePage(), // Driving Test
    PracticeSheduleHome(), // Practice shedule
    FeesHomePage(), // Fee
    const AttendenceBookScreenSelectMonth(), // Attendance
    AdminStudyMaterials(), // Study Materials
    VideosListAdmin(), // Videos
    NoticePageAdmin(), // Notice
    EventsListAdmin(), // Events
    Notifications(), // notifications
    const AdminChatScreen(), // Chat
    //const LearnersHomePage(), // Learners Test
    const LoginHistory(), // Login history
    ArchivedStudents(), // Archives
  ];

  Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          color: cWhite,
          height: 420,
          width: double.infinity,
          child: Wrap(
            children: <Widget>[
              Container(
                color: cWhite,
                height: 400,
                child: AnimationLimiter(
                  child: GridView.count(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.all(w / 40),
                    crossAxisCount: columnCount,
                    children: List.generate(
                      18,
                      (int index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 750),
                          columnCount: columnCount,
                          child: ScaleAnimation(
                            duration: const Duration(milliseconds: 900),
                            curve: Curves.fastLinearToSlowEaseIn,
                            scale: 1.5,
                            child: FadeInAnimation(
                              child: GestureDetector(
                                onTap: () =>
                                    Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return screenNavigationOfAdmin[index];
                                  },
                                )),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: w / 25,
                                      left: w / 30,
                                      right: w / 30,
                                      top: w / 25),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: cblack.withOpacity(0.1)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(7)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 40,
                                        spreadRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 80.h,
                                        width: 80.w,
                                        decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: cWhite,
                                                  //adminePrimayColor,
                                                  spreadRadius: 1,
                                                  offset: Offset(
                                                    2,
                                                    2,
                                                  )),
                                            ],
                                            color: themeColor,
                                            // cWhite,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: themeColor
                                                    .withOpacity(0.5))),
                                        child: Center(
                                          child: Image.asset(
                                            imageStd[index],
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.contain,
                                            scale: 2,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: GooglePoppinsWidgets(
                                          text: stdtext[index],
                                          fontsize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white);
}

List<String> imageStd = [
  'assets/flaticons/books.png', // tutor
  'assets/flaticons/students.png', // students
  'assets/flaticons/createadmin.png', // admin
  'assets/flaticons/setting.png', // course
  'assets/flaticons/add.png', // course student request
  'assets/flaticons/batch-processing.png', //bacth
  'assets/flaticons/cone.png', // Driving Test
  'assets/flaticons/calendar.png', // practice shedule
  'assets/flaticons/hand.png', // fees
  'assets/flaticons/attendance.png', // Attendance
  'assets/flaticons/books.png', // study Materials
  'assets/flaticons/video.png', // videos
  'assets/flaticons/icons8-notice-100.png', // Notice
  'assets/flaticons/events.png', // events
  'assets/flaticons/mobile-notification.png', // Notification
  'assets/flaticons/icons8-chat-100.png', // chats
  // 'assets/flaticons/exam.png', // Leaners test
  'assets/flaticons/user-access.png', // Login History
  'assets/flaticons/file.png', // Login History
];
List<String> stdtext = [
  'All Tutors',
  'All Students',
  'All Admins',
  'Courses',
  'Student Requests',
  'Batches',
  'Driving Test',
  'Practice Shedule',
  'Fees',
  'Attendance',
  'Study Materials',
  'Videos',
  'Notices',
  'Events',
  'Notification',
  'Chats',
  // 'Leaners Test',
  'Login History',
  'Archives',
];
