import 'dart:developer';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/form_controller/form_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/admin_model/data_base_model_ad.dart';
import 'package:new_project_app/model/student_model/data_base_model.dart';
import 'package:new_project_app/view/pages/chat/group_chats/group_chat.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

import '../../model/chat_model/chat_model.dart';
import 'model/create_group_chat_model.dart';

class TeacherGroupChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  RxBool isLoading = false.obs;
  messageTitles(Size size, String chatId, String message, String docid,
      String time, BuildContext context, String groupID, String adminName) {
    if (FirebaseAuth.instance.currentUser!.uid == chatId) {
      //to get which <<<< DD//Month//Year   >>>>>
      DateTime parseDatee = DateTime.parse(time.toString());
      final DateFormat dayformatterr = DateFormat('dd MMMM yyy');
      String dayformattedd = dayformatterr.format(parseDatee);
      ///////////////////////
      DateTime parseTime = DateTime.parse(time.toString());
      final DateFormat timeformatterr = DateFormat('h:mm a');
      String timeformattedd = timeformatterr.format(parseTime);
////
      return GestureDetector(
        onLongPress: () async {
          return showDialog(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Alert'),
                content: const SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Do you want Delete this message ?')
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () async {
                      log(docid);
                      await FirebaseFirestore.instance
                          .collection("DrivingSchoolCollection")
                          .doc(UserCredentialsController.schoolId)
                          .collection('ChatGroups')
                          .doc('ChatGroups')
                          .collection('Students')
                          .doc(groupID)
                          .collection('chats')
                          .doc(docid)
                          .delete()
                          .then((value) => Navigator.pop(context));
                    },
                  ),
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            width: size.width,
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: TextFontWidget(
                    text: 'You',
                    fontsize: 12,
                    color: adminePrimayColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 194, 243, 189),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$message              ',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Text(
                        timeformattedd,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 90, 90, 90),
                            fontSize: 10),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 05,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    dayformattedd,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 90, 90, 90), fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      //to get which <<<< DD//Month//Year   >>>>>
      DateTime parseDatee = DateTime.parse(time.toString());
      final DateFormat dayformatterr = DateFormat('dd MMMM yyy');
      String dayformattedd = dayformatterr.format(parseDatee);
      ///////////////////////
      DateTime parseTime = DateTime.parse(time.toString());
      final DateFormat timeformatterr = DateFormat('h:mm a');
      String timeformattedd = timeformatterr.format(parseTime);
////
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          width: size.width,
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextFontWidget(text: adminName, fontsize: 10)),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$message              ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    Text(
                      timeformattedd,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 90, 90, 90), fontSize: 10),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 05,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  dayformattedd,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 90, 90, 90), fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  sendMessage(String groupID, String adminName) async {
    final id = uuid.v1();
    final sendMessage = OnlineChatModel(
        message: messageController.text,
        messageindex: 1,
        chatid: FirebaseAuth.instance.currentUser!.uid,
        docid: id,
        sendTime: DateTime.now().toString(),
        username: '$adminName T r');
    await FirebaseFirestore.instance
        .collection("DrivingSchoolCollection")
        .doc(UserCredentialsController.schoolId)
        .collection('ChatGroups')
        .doc('ChatGroups')
        .collection('Students')
        .doc(groupID)
        .collection('chats')
        .doc(id)
        .set(sendMessage.toMap())
        .then((value) async {
      await sendMessageIndexToAllUsers(groupID);
      messageController.clear();
    });
  }

  Future<void> sendMessageIndexToAllUsers(String groupID) async {
    final firebase = await FirebaseFirestore.instance
        .collection("DrivingSchoolCollection")
        .doc(UserCredentialsController.schoolId)
        .collection('ChatGroups')
        .doc('ChatGroups')
        .collection('Students')
        .doc(groupID)
        .collection('Participants')
        .get();

    for (var i = 0; i < firebase.docs.length; i++) {
      await FirebaseFirestore.instance
          .collection("DrivingSchoolCollection")
          .doc(UserCredentialsController.schoolId)
          .collection('ChatGroups')
          .doc('ChatGroups')
          .collection('Students')
          .doc(groupID)
          .collection('Participants')
          .doc(firebase.docs[i].data()['docid'])
          .set({
        'messageIndex': await fetchCurrentIndexByUser(
                groupID, firebase.docs[i].data()['docid']) +
            1
      }, SetOptions(merge: true));
    }
  }

  Future<int> fetchCurrentIndexByUser(String groupID, String userDocid) async {
    final firebase = await FirebaseFirestore.instance
        .collection("DrivingSchoolCollection")
        .doc(UserCredentialsController.schoolId)
        .collection('ChatGroups')
        .doc('ChatGroups')
        .collection('Students')
        .doc(groupID)
        .collection('Participants')
        .doc(userDocid)
        .get();

    if (firebase.data()!['messageIndex'] == null) {
      return 0;
    } else {
      return firebase.data()!['messageIndex'];
    }
  }

  Future<void> addAllStudents(
    String groupID,
  ) async {
    isLoading.value = true;
    final firabase = await FirebaseFirestore.instance
        .collection("DrivingSchoolCollection")
        .doc(UserCredentialsController.schoolId)
        .collection('Students')
        .get();

    for (var i = 0; i < firabase.docs.length; i++) {
      final studentDetails = AddStudentModel.fromMap(firabase.docs[i].data());

      await FirebaseFirestore.instance
          .collection("DrivingSchoolCollection")
          .doc(UserCredentialsController.schoolId)
          .collection('ChatGroups')
          .doc('ChatGroups')
          .collection('Students')
          .doc(groupID)
          .collection('Participants')
          .doc(studentDetails.docid)
          .set(studentDetails.toMap());
    }
    userIndexBecomeZero(groupID, 'Students', adminParameter: 'studentName');
    isLoading.value = false;
  }

  Future<void> addAllStudentsOnBatch(
    String groupID,
  ) async {
    isLoading.value = true;
    final firabase = await FirebaseFirestore.instance
        .collection("DrivingSchoolCollection")
        .doc(UserCredentialsController.schoolId)
        .collection('Students')
        .get();

    for (var i = 0; i < firabase.docs.length; i++) {
      final studentDetails = AddStudentModel.fromMap(firabase.docs[i].data());

      await FirebaseFirestore.instance
          .collection("DrivingSchoolCollection")
          .doc(UserCredentialsController.schoolId)
          .collection('ChatGroups')
          .doc('ChatGroups')
          .collection('Students')
          .doc(groupID)
          .collection('Participants')
          .doc(studentDetails.docid)
          .set(studentDetails.toMap());
    }
    userIndexBecomeZero(groupID, 'Students', adminParameter: 'studentName');
    isLoading.value = false;
  }

  batchwiseStudent(groupID) {
    Get.bottomSheet(Container(
      color: cWhite,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 15,
            ),
            child: TextFontWidget(text: "All Batches", fontsize: 14,fontWeight: FontWeight.w500,),
          ),
          SizedBox(height: 15.h),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("DrivingSchoolCollection")
                    .doc(UserCredentialsController.schoolId)
                    .collection('Batch')
                    .snapshots(),
                builder: (context, batchsnapshot) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final batchData = batchsnapshot.data!.docs[index].data();
                      return GestureDetector(
                        onTap: () {
                          customBatchAddStudentInGroup(
                              groupID, batchData['batchId']);
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 221, 235, 246),
                              border: Border.all(color: cblack)),
                          child: Row(
                            children: [
                              TextFontWidget(
                                  text: "${index + 1}", fontsize: 12),
                              const SizedBox(width: 5),
                              SizedBox(
                                width: 200.w,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: TextFontWidget(
                                    text: '${batchData['batchName']}',
                                    fontsize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: batchsnapshot.data?.docs.length ?? 0,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5,
                    ),
                    // child:
                  );
                }),
          )
        ],
      ),
    ));
  }

  customBatchAddStudentInGroup(groupID, batchId) {
     Future<void> addAllStudentsOnBatch(
                      String groupID,
                    ) async {
                      isLoading.value = true;
                      final firabase = await FirebaseFirestore.instance
                          .collection("DrivingSchoolCollection")
                          .doc(UserCredentialsController.schoolId)
                          .collection('Batch')
                          .doc(batchId)
                          .collection('Students')
                          .get();

                      for (var i = 0; i < firabase.docs.length; i++) {
                        final studentDetailsofBatch =
                            AddStudentModel.fromMap(firabase.docs[i].data());

                        await FirebaseFirestore.instance
                            .collection("DrivingSchoolCollection")
                            .doc(UserCredentialsController.schoolId)
                            .collection('ChatGroups')
                            .doc('ChatGroups')
                            .collection('Students')
                            .doc(groupID)
                            .collection('Participants')
                            .doc(studentDetailsofBatch.docid)
                            .set(studentDetailsofBatch.toMap());
                      }
                      userIndexBecomeZero(groupID, 'Students',
                          adminParameter: 'studentName');
                      isLoading.value = false;
                      showToast(msg: ' students added successfully');
                    }
    userIndexBecomeZero(groupID, 'Students', adminParameter: 'studentName');
    RxMap<String, bool?> addStudentList = <String, bool?>{}.obs;

    List<AddStudentModel> featchingStudentList = [];

    Get.bottomSheet(Container(
      color: Colors.white,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFontWidget(
                  text: "Add students in custom",
                  fontsize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () async{
                  await addAllStudentsOnBatch(groupID);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        TextFontWidget(
                          text: "Add All",
                          fontsize: 14,
                          fontWeight: FontWeight.w500,
                        ), Icon(Icons.person),
                      ],
                    ),
                  ))
            ],
          ),
          SizedBox(height: 15.h),
          Expanded(
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("DrivingSchoolCollection")
                  .doc(UserCredentialsController.schoolId)
                  .collection('Batch')
                  .doc(batchId)
                  .collection('Students')
                  .get(),
              builder: (context, studentsSnaps) {
                 if (studentsSnaps.data!.docs.length == 0) {
                      return const Center(
                        child: Text(
                         'No Students',
                          style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                         ));
                      }
                if (studentsSnaps.hasData) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final studentDetails = AddStudentModel.fromMap(
                        studentsSnaps.data!.docs[index].data(),
                      );
                      featchingStudentList.add(studentDetails);
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Obx(() => Container(
                                  color: addStudentList[studentsSnaps.data!
                                              .docs[index]['studentName']] ==
                                          null
                                      ? Colors.transparent
                                      : addStudentList[studentsSnaps
                                                      .data!.docs[index]
                                                  ['studentName']] ==
                                              true
                                          ? Colors.green.withOpacity(0.4)
                                          : Colors.red.withOpacity(0.4),
                                  height: 60.h,
                                  child: Row(
                                    children: [
                                      Text("${index + 1}"),
                                      const SizedBox(width: 5),
                                      SizedBox(
                                        width: 200.w,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: TextFontWidget(
                                            text: studentDetails.studentName!,
                                            fontsize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            const Spacer(),
                            IconButton(
                              onPressed: () async {
                                addStudentToGroup(studentDetails.docid!,
                                        groupID, studentDetails)
                                    .then((value) {
                                  showToast(msg: 'Added');
                                  addStudentList[studentsSnaps.data!.docs[index]
                                      ['studentName']] = true;
                                });
                              },
                              icon: const Icon(Icons.add),
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: () async {
                                await removeStudentToGroup(
                                        studentDetails.docid!, groupID, context)
                                    .then((value) {
                                  showToast(msg: "Removed");
                                  addStudentList[studentsSnaps.data!.docs[index]
                                      ['studentName']] = false;
                                });
                              },
                              icon: const Icon(Icons.remove),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: studentsSnaps.data!.docs.length,
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    ));

    
  }

  customAddStudentInGroup(groupID) {
    userIndexBecomeZero(groupID, 'Students', adminParameter: 'studentName');
    RxMap<String, bool?> addStudentList = <String, bool?>{}.obs;

    List<AddStudentModel> featchingStudentList = [];

    Get.bottomSheet(Container(
      color: Colors.white,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFontWidget(
                  text: "Add students in custom",
                  fontsize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          Expanded(
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("DrivingSchoolCollection")
                  .doc(UserCredentialsController.schoolId)
                  .collection('Students')
                  .get(),
              builder: (context, studentsSnaps) {
                if (studentsSnaps.hasData) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final studentDetails = AddStudentModel.fromMap(
                        studentsSnaps.data!.docs[index].data(),
                      );
                      featchingStudentList.add(studentDetails);
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Obx(() => Container(
                                  color: addStudentList[studentsSnaps.data!
                                              .docs[index]['studentName']] ==
                                          null
                                      ? Colors.transparent
                                      : addStudentList[studentsSnaps
                                                      .data!.docs[index]
                                                  ['studentName']] ==
                                              true
                                          ? Colors.green.withOpacity(0.4)
                                          : Colors.red.withOpacity(0.4),
                                  height: 60.h,
                                  child: Row(
                                    children: [
                                      Text("${index + 1}"),
                                      const SizedBox(width: 5),
                                      SizedBox(
                                        width: 200.w,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: TextFontWidget(
                                            text: studentDetails.studentName!,
                                            fontsize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            const Spacer(),
                            IconButton(
                              onPressed: () async {
                                addStudentToGroup(studentDetails.docid!,
                                        groupID, studentDetails)
                                    .then((value) {
                                  showToast(msg: 'Added');
                                  addStudentList[studentsSnaps.data!.docs[index]
                                      ['studentName']] = true;
                                });
                              },
                              icon: const Icon(Icons.add),
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: () async {
                                await removeStudentToGroup(
                                        studentDetails.docid!, groupID, context)
                                    .then((value) {
                                  showToast(msg: "Removed");
                                  addStudentList[studentsSnaps.data!.docs[index]
                                      ['studentName']] = false;
                                });
                              },
                              icon: const Icon(Icons.remove),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: studentsSnaps.data!.docs.length,
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    ));
  }

  customAddAdminInGroup(groupID) {
    userIndexBecomeZero(groupID, 'Admins', adminParameter: 'adminName');
    RxMap<String, bool?> addAdminList = <String, bool?>{}.obs;

    List<AddAdminModel> featchingAdminList = [];

    Get.bottomSheet(Container(
      color: Colors.white,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFontWidget(
                  text: "Add Admins in custom",
                  fontsize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          Expanded(
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("DrivingSchoolCollection")
                  .doc(UserCredentialsController.schoolId)
                  .collection('Admins')
                  .get(),
              builder: (context, adminsSnaps) {
                if (adminsSnaps.hasData) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final adminDetails = AddAdminModel.fromMap(
                        adminsSnaps.data!.docs[index].data(),
                      );
                      featchingAdminList.add(adminDetails);
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Obx(() => Container(
                                  color: addAdminList[adminsSnaps
                                              .data!.docs[index]['username']] ==
                                          null
                                      ? Colors.transparent
                                      : addAdminList[adminsSnaps.data!
                                                  .docs[index]['username']] ==
                                              true
                                          ? Colors.green.withOpacity(0.4)
                                          : Colors.red.withOpacity(0.4),
                                  height: 60.h,
                                  child: Row(
                                    children: [
                                      Text("${index + 1}"),
                                      const SizedBox(width: 5),
                                      SizedBox(
                                        width: 200.w,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: TextFontWidget(
                                            text: adminDetails.username,
                                            fontsize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            const Spacer(),
                            IconButton(
                              onPressed: () async {
                                addAdminToGroup(adminDetails.docid, groupID,
                                        adminDetails)
                                    .then((value) {
                                  showToast(msg: 'Added');
                                  addAdminList[adminsSnaps.data!.docs[index]
                                      ['username']] = true;
                                });
                              },
                              icon: const Icon(Icons.add),
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: () async {
                                await removeAdminToGroup(
                                        adminDetails.docid, groupID, context)
                                    .then((value) {
                                  showToast(msg: "Removed");
                                  addAdminList[adminsSnaps.data!.docs[index]
                                      ['username']] = false;
                                });
                              },
                              icon: const Icon(Icons.remove),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: adminsSnaps.data!.docs.length,
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> addStudentToGroup(String studentDocID, String groupID,
      AddStudentModel studentDetails) async {
    await FirebaseFirestore.instance
        .collection("DrivingSchoolCollection")
        .doc(UserCredentialsController.schoolId)
        .collection('ChatGroups')
        .doc('ChatGroups')
        .collection('Students')
        .doc(groupID)
        .collection('Participants')
        .doc(studentDocID)
        .set(studentDetails.toMap());
  }

  Future<void> addAdminToGroup(
      String adminDocID, String groupID, AddAdminModel adminDetails) async {
    await FirebaseFirestore.instance
        .collection("DrivingSchoolCollection")
        .doc(UserCredentialsController.schoolId)
        .collection('ChatGroups')
        .doc('ChatGroups')
        .collection('Admins')
        .doc(groupID)
        .collection('Participants')
        .doc(adminDocID)
        .set(adminDetails.toMap());
  }

  Future<void> removeStudentToGroup(
      String studentDocID, String groupID, BuildContext context) async {
    await FirebaseFirestore.instance
        .collection("DrivingSchoolCollection")
        .doc(UserCredentialsController.schoolId)
        .collection('ChatGroups')
        .doc('ChatGroups')
        .collection('Students')
        .doc(groupID)
        .collection('Participants')
        .doc(studentDocID)
        .delete()
        .then((value) => Navigator.pop(context));
  }

  Future<void> removeAdminToGroup(
      String adminDocID, String groupID, BuildContext context) async {
    await FirebaseFirestore.instance
        .collection("DrivingSchoolCollection")
        .doc(UserCredentialsController.schoolId)
        .collection('ChatGroups')
        .doc('ChatGroups')
        .collection('Admins')
        .doc(groupID)
        .collection('Participants')
        .doc(adminDocID)
        .delete()
        .then((value) => Navigator.pop(context));
  }

  addParticipants(String groupID) async {
    Get.bottomSheet(Container(
      color: Colors.white,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async {
                  await batchwiseStudent(groupID);
                  //  await customAddStudentInGroup(groupID);
                },
                child: Container(
                  decoration:
                      BoxDecoration(color: adminePrimayColor.withOpacity(0.3)),
                  height: 60.h,
                  width: 150.w,
                  child: const Center(
                    child: TextFontWidget(
                        text: 'Batch Wise',
                        fontsize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Obx(
                () => isLoading.value
                    ? circularProgressIndicatotWidget
                    : GestureDetector(
                        onTap: () async {
                          await addAllStudents(
                            groupID,
                          ).then((value) => showToast(
                              msg: "All students added in this groups"));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: adminePrimayColor.withOpacity(0.3)),
                          height: 60.h,
                          width: 150.w,
                          child: const Center(
                            child: TextFontWidget(
                                text: 'Add All Students',
                                fontsize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
              )
            ],
          ),
          GestureDetector(
            onTap: () async {
              await customAddStudentInGroup(groupID);
            },
            child: Container(
              decoration:
                  BoxDecoration(color: adminePrimayColor.withOpacity(0.3)),
              height: 60.h,
              width: 150.w,
              child: const Center(
                child: TextFontWidget(
                    text: 'Custom', fontsize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    ));
  }

  createGroupChatForWho(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Groups For ?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            createChatGroups(context, 'Students'.tr);
                          },
                          child: Container(
                              height: 60,
                              width: 100,
                              color: Colors.green.withOpacity(0.4),
                              child: const Center(child: Text('Students')))),
                      GestureDetector(
                          onTap: () {
                            createChatGroups(context, 'Parents'.tr);
                          },
                          child: Container(
                              height: 60,
                              width: 100,
                              color: Colors.green.withOpacity(0.4),
                              child: const Center(child: Text('Parents')))),
                    ],
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

createChatGroups(BuildContext context, String chatValue) async {
  // final formKey = GlobalKey<FormState>();
  final GroupFormController groupFormController =
      Get.put(GroupFormController());
  TextEditingController groupNameController = TextEditingController();
  showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return Form(
        key: groupFormController.formKey,
        child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('DrivingSchoolCollection')
                .doc(UserCredentialsController.schoolId)
                .get(),
            builder: (context, futureData) {
              return AlertDialog(
                title: const Text('Enter Group Name'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Invalid';
                          }
                          return null;
                        },
                        controller: groupNameController,
                        decoration:
                            const InputDecoration(hintText: 'Enter Name'),
                      )
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('ok'),
                    onPressed: () async {
                      if (groupFormController.formKey.currentState!
                          .validate()) {
                        final docid = uuid.v1();
                        final groupInfoDetails = CreateGroupChatModel(
                            activate: true,
                            docid: docid,
                            admin: true,
                            groupName: groupNameController.text,
                            teacherId: FirebaseAuth.instance.currentUser!.uid);
                        await FirebaseFirestore.instance
                            .collection('DrivingSchoolCollection')
                            .doc(UserCredentialsController.schoolId)
                            .collection('ChatGroups')
                            .doc('ChatGroups')
                            .set({'docid': "ChatGroups"}).then((value) async {
                          ////////////////ariyilla
                          await FirebaseFirestore.instance
                              .collection('DrivingSchoolCollection')
                              .doc(UserCredentialsController.schoolId)
                              .collection('ChatGroups')
                              .doc('ChatGroups')
                              .collection(chatValue)
                              .doc(docid)
                              .set(groupInfoDetails.toMap())
                              .then((value) async {
                            Navigator.pop(context);

                            return showToast(msg: 'Group Created Successfully');
                          });
                        });
                      }
                    },
                  ),
                  TextButton(
                    child: const Text('cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }),
      );
    },
  );
}
