import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/group_chat_controller/group_StudentsAdmin_chat_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/view/pages/chat/select_teachers.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

showStudentsGroupAppBar(
  String groupName,
  String totalStudents,
  String groupID,
  BuildContext context,
) async {
  Navigator.push(context, MaterialPageRoute(
    builder: (context) {
      return BootomSheet(
          groupID: groupID, groupName: groupName, totalStudents: totalStudents);
    },
  ));
}

class BootomSheet extends StatefulWidget {
  final String groupName;
  final String totalStudents;
  final String groupID;
  BootomSheet(
      {required this.groupID,
      required this.groupName,
      required this.totalStudents,
      super.key});

  @override
  State<BootomSheet> createState() => _BootomSheetState();
}

class _BootomSheetState extends State<BootomSheet> {
  final AdminGroupChatController teacherGroupChatController =
      Get.put(AdminGroupChatController());

  bool showAdminList = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection('ChatGroups')
              .doc('ChatGroups')
              .collection("Students")
              .doc(widget.groupID)
              .collection('Participants')
              .snapshots(),
          builder: (context, snaps) {
            if (!snaps.hasData || snaps.data == null) {
              return circularProgressIndicatotWidget;
            }
            return ListView(
              children: [
                Container(
                  height: 300,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                      ),
                      TextFontWidget(
                        text: widget.groupName,
                        fontsize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      Text("${snaps.data!.docs.length} Students & Admins"),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible:false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                          'Select admin to Transfer group'),
                                      content: const SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            GetSchoolAdminListDropDownButton()
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Ok'),
                                          onPressed: () async {
                                            FirebaseFirestore.instance
                                                .collection( 'DrivingSchoolCollection')
                                                .doc(UserCredentialsController.schoolId)
                                                .collection('ChatGroups')
                                                .doc('ChatGroups')
                                                .collection("Students")
                                                .doc(widget.groupID)
                                                .update({
                                              'adminId': adminNameListValue!['docid']
                                            }).then((value) {
                                              Navigator.of(context).pop();
                                              showToast( msg: "Transfer Group Successfully");
                                            });
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
                              child: Container(
                                decoration: BoxDecoration(
                                    color: adminePrimayColor.withOpacity(0.3),
                                    border:  Border.all(color: adminePrimayColor),
                                    borderRadius: BorderRadius.circular(30)),
                                height: 40,
                                width: 140,
                                child: const Center(
                                  child: TextFontWidget(
                                    text: 'Transfer Group',
                                    fontsize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('DrivingSchoolCollection')
                                  .doc(UserCredentialsController.schoolId)
                                  .collection('ChatGroups')
                                  .doc('ChatGroups')
                                  .collection("Students")
                                  .doc(widget.groupID)
                                  .snapshots(),
                              builder: (context, groupSnapShot) {
                                if (groupSnapShot.hasData) {
                                  if (groupSnapShot.data!.data()!['activate'] == true) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: GestureDetector(
                                        onTap: () async {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false, // user must tap button!
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text('Alert'),
                                                  content: const SingleChildScrollView(
                                                    child: ListBody(
                                                      children: <Widget>[
                                                        Text('Do you want to Deactivate this group ?')
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: const Text('ok'),
                                                      onPressed: () async {
                                                        await FirebaseFirestore.instance
                                                            .collection( 'DrivingSchoolCollection')
                                                            .doc(UserCredentialsController.schoolId)
                                                            .collection('ChatGroups')
                                                            .doc('ChatGroups')
                                                            .collection( "Students")
                                                            .doc(widget.groupID)
                                                            .update({'activate': false
                                                        }).then((value) {
                                                          Navigator.pop( context);
                                                          showToast( msg:'Deactivated');
                                                        });
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
                                              });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:  Colors.red.withOpacity(0.3),
                                              border: Border.all(color: Colors.red),
                                              borderRadius: BorderRadius.circular(30)),
                                          height: 40,
                                          width: 140,
                                          child: const Center(
                                            child: TextFontWidget(
                                              text: 'Deactivate',
                                              fontsize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: GestureDetector(
                                        onTap: () async {
                                          showDialog(
                                              context: context,
                                              barrierDismissible:   false, // user must tap button!
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text('Alert'),
                                                  content:const SingleChildScrollView(
                                                    child: ListBody(
                                                      children: <Widget>[
                                                        Text( 'Do you want to Activate this group ?')
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: const Text('ok'),
                                                      onPressed: () async {
                                                        await FirebaseFirestore.instance
                                                            .collection('DrivingSchoolCollection')
                                                            .doc(UserCredentialsController .schoolId)
                                                            .collection('ChatGroups')
                                                            .doc('ChatGroups')
                                                            .collection("Students")
                                                            .doc(widget.groupID)
                                                            .update({
                                                          'activate': true
                                                        }).then((value) {
                                                          Navigator.pop(context);
                                                          showToast(msg: 'Activated');
                                                        });
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: const Text('cancel'),
                                                      onPressed: () {
                                                        Navigator.of(context) .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:  Colors.green.withOpacity(0.3),
                                              border: Border.all( color: Colors.green),
                                              borderRadius: BorderRadius.circular(30)),
                                          height: 40,
                                          width: 140,
                                          child: const Center(
                                            child: TextFontWidget(
                                              text: 'Activate',
                                              fontsize: 12,fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  return const Center( child: circularProgressIndicatotWidget, );
                                }
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox( height: 20,),
                Container(
                  height: 500,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showAdminList = false;
                                  });
                                },
                                child: TextFontWidget(
                                  text: '${snaps.data!.docs.length}  Students',
                                  fontsize: 15,fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              IconButton(
                                  onPressed: () async {
                                    teacherGroupChatController
                                        //batchwiseStudent(widget.groupID);
                                        .customAddStudentInGroup( widget.groupID);
                                  },
                                  icon: const Icon(Icons.person_add)),
                              Spacer(),
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          showAdminList = true; // Show admin list when clicked
                                        });
                                      },
                                      child: TextFontWidget(
                                        text: "Add Others", fontsize: 13,
                                      )),
                                  IconButton(
                                      onPressed: () async {
                                        teacherGroupChatController
                                            .customAddAdminInGroup(  widget.groupID,widget.groupName);
                                        // addteacherTopaticipance(groupID,groupName,adminParameter:  UserCredentialsController.adminModel!.adminName);
                                      },
                                      icon: const Icon(Icons.person_4)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [// Conditionally stream data
                              showAdminList  == false
                                  ? SizedBox(
                                      height: 380,
                                      child: StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection( 'DrivingSchoolCollection')
                                            .doc(UserCredentialsController  .schoolId)
                                            .collection('ChatGroups')
                                            .doc('ChatGroups')
                                            .collection('Students')
                                            .doc(widget.groupID)
                                            .collection('Participants')
                                            .snapshots(),
                                        builder: (context, studentssnapshots) {
                                          if (studentssnapshots.hasData) {
                                            return ListView.separated(
                                                itemBuilder: (context, index) {
                                                  if (studentssnapshots.data!.docs.length ==index) {
                                                    return SizedBox( height: 80.h, );
                                                  }
                                                  return GestureDetector(
                                                    onLongPress: () async {
                                                      showDialog(
                                                        context: context,
                                                        barrierDismissible: false, // user must tap button!
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            title: const Text( 'Alert'),
                                                            content:const SingleChildScrollView(
                                                              child: ListBody(
                                                                children: <Widget>[
                                                                  Text('Do you want to remove this student ?')
                                                                ],
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child:const Text('ok'),
                                                                onPressed:() async {
                                                                  await teacherGroupChatController.removeStudentToGroup(
                                                                      studentssnapshots.data!.docs[index] [ 'docid'],
                                                                      widget.groupID, context);
                                                                },
                                                              ),
                                                              TextButton(
                                                                child: const Text('cancel'),
                                                                onPressed:() async {
                                                                  Navigator.pop( context);
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.only( left: 10, right: 10),
                                                      child: Container(
                                                        height: 50,
                                                        color: Colors.blue .withOpacity(0.1),
                                                        child: Row(
                                                          children: [
                                                            Text("  ${index + 1}"),
                                                            const SizedBox(width: 07,),
                                                            const CircleAvatar(),
                                                            const SizedBox( width: 20,),
                                                            TextFontWidget(
                                                                text: studentssnapshots.data?.docs[index] ['studentName']??"",
                                                                fontsize: 12)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                separatorBuilder:(context, index) {
                                                  return const SizedBox( height: 10,);
                                                },
                                                itemCount: studentssnapshots .data!.docs.length);
                                          } else {
                                            return const Center( child: CircularProgressIndicator.adaptive(),
                                            );
                                          }
                                        },
                                      ),
                                    ) /////student
                                  :  Container( 
                                      height: 500,
                                      width: double.infinity,
                                      child: DefaultTabController(
                                        length: 2,
                                        child: Container(
                                          child: Column(
                                            children: [
                                              TabBar(
                                                labelColor: Color.fromARGB(
                                                    255, 28, 64, 93),
                                                unselectedLabelColor: cblack,
                                                tabs: [
                                                  Tab(text: 'Admins'),
                                                  Tab(text: 'Teachers'),
                                                ],
                                              ),
                                              Expanded(
                                                child: TabBarView(
                                                  children: [
                                                    Container(
                                                      height: 380,
                                                      child: StreamBuilder(
                                                        stream: FirebaseFirestore .instance
                                                            .collection( 'DrivingSchoolCollection')
                                                            .doc( UserCredentialsController.schoolId)
                                                            .collection('ChatGroups')
                                                            .doc('ChatGroups')
                                                            .collection('Admins')
                                                            .doc(widget.groupID)
                                                            .collection( 'Participants')
                                                            .snapshots(),
                                                        builder: (context,adminsnapshots) {
                                                          if (adminsnapshots .hasData) {
                                                            return ListView.separated(
                                                                    itemBuilder: (context, index) {
                                                                      if (adminsnapshots.data!.docs.length == index) {
                                                                        return SizedBox( height:80.h,);
                                                                      }
                                                                      String username;
                                                                      if (adminsnapshots .data! .docs[index] .data()
                                                                          .containsKey('username')) {
                                                                        username = adminsnapshots.data!.docs[index]['username'];
                                                                      } else if (adminsnapshots .data!.docs[index]
                                                                          .data().containsKey('adminName')) {
                                                                        username = adminsnapshots.data! .docs[index]['adminName'];
                                                                      } else {username = 'Unknown';}
                                                                      return GestureDetector(
                                                                        onLongPress:() async {
                                                                          showDialog(
                                                                            context:context,
                                                                            barrierDismissible: false, // user must tap button!
                                                                            builder: (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: const Text('Alert'),
                                                                                content: const SingleChildScrollView(
                                                                                  child: ListBody(
                                                                                    children: <Widget>[
                                                                                      Text('Do you want to remove this Admin ?')
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                actions: <Widget>[
                                                                                  TextButton(
                                                                                    child: const Text('ok'),
                                                                                    onPressed: () async {
                                                                                      await teacherGroupChatController.removeAdminToGroup(adminsnapshots.data!.docs[index]['docid'], widget.groupID, context);
                                                                                    },
                                                                                  ),
                                                                                  TextButton(
                                                                                    child: const Text('cancel'),
                                                                                    onPressed: () async {
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.only( left: 10,  right: 10),
                                                                          child: Container(
                                                                            height: 50,
                                                                            color: Colors.blue.withOpacity(0.1),
                                                                            child: Row(
                                                                              children: [
                                                                                Text("  ${index + 1}"),
                                                                                const SizedBox(width: 07,),
                                                                                const CircleAvatar(),
                                                                                const SizedBox( width: 20, ),
                                                                                TextFontWidget( text: username,fontsize: 12)
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    separatorBuilder: (context, index) {
                                                                      return const SizedBox( height: 10,);
                                                                    },
                                                                    itemCount: adminsnapshots.data! .docs.length);
                                                          } else {
                                                            return const Center(child: CircularProgressIndicator.adaptive(),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ), /////////////////////////////////////////////////////
                                                    Container(
                                                      height: 380,
                                                      child: StreamBuilder(
                                                        stream: FirebaseFirestore .instance
                                                            .collection( 'DrivingSchoolCollection')
                                                            .doc( UserCredentialsController .schoolId)
                                                            .collection( 'ChatGroups')
                                                            .doc('ChatGroups')
                                                            .collection( 'Teachers')
                                                            .doc(widget.groupID)
                                                            .collection( 'Participants')
                                                            .snapshots(),
                                                        builder: (context, tutorsnaps) {
                                                          if (tutorsnaps.hasData) {
                                                            return ListView.separated(
                                                                    itemBuilder: (context, index) {
                                                                      if (tutorsnaps .data! .docs.length ==
                                                                          index) {
                                                                        return SizedBox( height: 80.h, );
                                                                      }
                                                                      String teacherName;
                                                                      if (tutorsnaps.data! .docs[ index].data()
                                                                          .containsKey(  'teacherName')) {
                                                                        teacherName = tutorsnaps.data!.docs[index]['teacherName'];
                                                                      } else {
                                                                        teacherName ='Unknown';
                                                                      }
                                                                      return GestureDetector(
                                                                        onLongPress:  () async {
                                                                          showDialog(
                                                                            context: context,
                                                                            barrierDismissible:false, // user must tap button!
                                                                            builder: (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: const Text('Alert'),
                                                                                content: const SingleChildScrollView(
                                                                                  child: ListBody(
                                                                                    children: <Widget>[
                                                                                      Text('Do you want to remove this Admin ?')
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                actions: <Widget>[
                                                                                  TextButton(
                                                                                    child: const Text('ok'),
                                                                                    onPressed: () async {
                                                                                      await teacherGroupChatController.removeAdminToGroup(tutorsnaps.data!.docs[index]['docid'], widget.groupID, context);
                                                                                    },
                                                                                  ),
                                                                                  TextButton( child: const Text('cancel'),
                                                                                    onPressed: () async {
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.only( left: 10, right: 10),
                                                                          child:Container(
                                                                            height:  50,
                                                                            color: Colors.blue.withOpacity(0.1),
                                                                            child:  Row(
                                                                              children: [
                                                                                Text("  ${index + 1}"),
                                                                                const SizedBox( width: 07),
                                                                                const CircleAvatar(),
                                                                                const SizedBox(width: 20,),
                                                                                TextFontWidget( text: teacherName, fontsize: 12)
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    separatorBuilder: (context, index) {
                                                                      return const SizedBox( height: 10, );
                                                                    },
                                                                    itemCount: tutorsnaps.data!.docs .length);
                                                          } else {
                                                            return const Center(
                                                              child:CircularProgressIndicator.adaptive(),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
