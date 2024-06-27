import 'package:adaptive_ui_layout/flutter_responsive_layout.dart'; 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/view/colors/colors.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart'; 
 

class RecordedClassesShowsPage extends StatelessWidget {
  const RecordedClassesShowsPage(
      {super.key,   this.subjectID,   this.chapterID});

  final String? subjectID;
  final String? chapterID;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: Row(
            children: [
              Text("Recorded Class List".tr),
            ],
          ),
          backgroundColor: adminePrimayColor,
        ),
        body:
        //  StreamBuilder(
        //   stream: FirebaseFirestore.instance
        //       .collection('SchoolListCollection')
        //       .doc(UserCredentialsController.schoolId)
        //       .collection(UserCredentialsController.batchId!)
        //       .doc(UserCredentialsController.batchId)
        //       .collection('classes')
        //       .doc(UserCredentialsController.classId)
        //       .collection('subjects')
        //       .doc(subjectID)
        //       .collection('recorded_classes_chapters')
        //       .doc(chapterID)
        //       .collection('RecordedClass')
        //       .snapshots(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return 
              ListView.separated(
                  itemCount:5,
                  separatorBuilder: ((context, index) {
                    return kHeight10;
                  }),
                  itemBuilder: (BuildContext context, int index) {
                    return ListileCardChapterWidget(
                      leading: const Image(
                          image: NetworkImage(
                              "https://media.istockphoto.com/id/926144358/photo/portrait-of-a-little-bird-tit-flying-wide-spread-wings-and-flushing-feathers-on-white-isolated.jpg?b=1&s=170667a&w=0&k=20&c=DEARMqqAI_YoA5kXtRTyYTYU9CKzDZMqSIiBjOmqDNY=")),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: GooglePoppinsWidgets(
                              fontsize: 15.h,
                              text: 'chapterName',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: GooglePoppinsWidgets(
                                fontsize: 15.h,
                                text:  'topicName',
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: GooglePoppinsWidgets(
                                fontsize: 14.h,
                                text: 'Video',
                                fontWeight: FontWeight.bold),
                          ),
                          kHeight10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GooglePoppinsWidgets(
                                  text: "Posted By :", fontsize: 15.h),
                              GooglePoppinsWidgets(
                                text: 'uploadedBy',
                                fontsize: 15.h,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ],
                      ),
                      title: Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: GooglePoppinsWidgets(
                          fontsize: 20.h,
                          text:  'title',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // trailing:
                      //  InkWell(
                      //   child: GooglePoppinsWidgets(
                      //       text: "View".tr,
                      //       fontsize: 16.h,
                      //       fontWeight: FontWeight.w500,
                      //       color: adminePrimayColor),
                      //   onTap: () {
                      //     // Get.to(() => Videoplayer(
                      //     //       videoUrl: snapshot.data!.docs[index]
                      //     //           ['downloadUrl'],
                      //     //     ));
                      //   },
                      // ),
                    );
//                   });
//             } else if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             return Center(child: Text('No Recorded Classes Uploaded Yet!'.tr));
//           },
//         ),
//       ),
//     );
  }
              )
              ));
}
}





class ListileCardChapterWidget extends StatelessWidget {
  const ListileCardChapterWidget({
    required this.leading,
    required this.title,
    required this.subtitle,
    this.trailing,
    super.key,
  });

 final Widget leading;
 final Widget title;
 final Widget subtitle;
 final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        shape: const BeveledRectangleBorder(side: BorderSide(color: cWhite)),
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
      ),
    );
  }
}
