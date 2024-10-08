import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/view/pages/chat/tutor_section/tutor_chat_screeen.dart';
import 'package:new_project_app/view/users/teacher/teacher_pages/Tutor_batch/tutor_batch_home.dart';
import 'package:new_project_app/view/users/teacher/teacher_pages/driving_test_tutor/driving_test_home.dart';
import 'package:new_project_app/view/users/teacher/teacher_pages/events_tutor/events_tutor.dart';
import 'package:new_project_app/view/users/teacher/teacher_pages/notices_tutor/notices_tutor.dart';
import 'package:new_project_app/view/users/teacher/teacher_pages/practice_shedule_tutor/practice_schedule_tr/practice_shedule_home_tr.dart';
import 'package:new_project_app/view/users/teacher/teacher_pages/student_review/student_review_home.dart';
import 'package:new_project_app/view/users/teacher/teacher_pages/study_materials/study_materials_teacher.dart';
import 'package:new_project_app/view/users/teacher/teacher_pages/videos/video_list_teacher.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class QuickActionPartTeacher extends StatelessWidget {
  const QuickActionPartTeacher({super.key});

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
  final screenNavigationOfTutor = [
    StudentReviewHome(), //Notice
    TutorDrivingHomePage(), //dr
    TutorPracticeSheduleHome(),
    AllBatchHomeOfTutor(),
    const StudyMaterialsTeacher(), // Study Materials
  //  const StudyMaterialsTeacher(), // Study Materials
    EventsListOfTutor(), //event
    const VideosListTeacher(), // Video
   // const VideosListTeacher(), // Video
    NoticePageTutor(),//Notice
    TutorChatScreen(),//chat
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
                      9,
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
                                onTap: () => Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return screenNavigationOfTutor[index];
                                  },
                                )),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: w / 25, left: w / 30, right: w / 30, top: w / 25),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: cblack.withOpacity(0.1)),
                                    borderRadius: const BorderRadius.all(Radius.circular(7)),
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
                                            border: Border.all(color: themeColor.withOpacity(0.5))),
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
  'assets/flaticons/students.png', // students
  'assets/flaticons/cone.png', // Driving Test
  'assets/flaticons/calendar.png', // practice shedule
  'assets/flaticons/batch-processing.png', //bacth
  'assets/flaticons/books.png', // study Materials
  'assets/flaticons/events.png', // events
 // 'assets/flaticons/exam.png', // Leaners test
  'assets/flaticons/video.png', // videos
  'assets/flaticons/icons8-notice-100.png', // Notice
//  'assets/flaticons/hand.png', // fees
 'assets/flaticons/icons8-chat-100.png', // chats
];
List<String> stdtext = [
  'Student Review',
  'Driving Test',
  'Practice Shedule',
  'Batches',
  'Study Materials',
 
  'Events',
 // 'Leaners Test',
  'Videos',
  'Notices',
 // 'Fees',
  'Chats',
];
