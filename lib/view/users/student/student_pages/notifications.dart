import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/push_notificationController/pushnotificationController.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:shimmer/shimmer.dart';

class NotificationPartOfStd extends StatelessWidget {
  NotificationPartOfStd({super.key});

  final PushNotificationController pushNotificationController =
      Get.put(PushNotificationController());
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
                          await pushNotificationController
                              .removeAllNotification();
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
          child: StreamBuilder(
              stream: server
                  .collection('DrivingSchoolCollection')
                  .doc(UserCredentialsController.schoolId)
                  .collection('AllUsersDeviceID')
                  .doc(UserCredentialsController.currentUSerID)
                  .collection("Notification_Message")
                  .orderBy('dateTime', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final data = snapshot.data!.docs[index].data();
                      return InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            shape: const BeveledRectangleBorder(),
                            context: context,
                            builder: (context) {
                              server
                                  .collection("DrivingSchoolCollection")
                                  .doc(UserCredentialsController.schoolId)
                                  .collection('AllUsersDeviceID')
                                  .doc(UserCredentialsController.currentUSerID)
                                  .collection("Notification_Message")
                                  .doc(data['docid'])
                                  .update({'open': true});
                              return SingleChildScrollView(
                                child: Container(
                                  color: //cbluelight,
                                      Color(data['whiteshadeColor']),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        // color: cblue,
                                        color: Color(data['containerColor']),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Row(
                                          children: [
                                            Icon(
                                              // Icons.alarm,
                                              IconData(
                                                data['icon'],
                                                fontFamily: 'MaterialIcons',
                                              ),
                                              size: 25,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Text(
                                                data['headerText'],
                                                //  "Holiday",
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
                                          data['messageText'],
                                          //   " Tommorow is Holiday  ",
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
                          leading: CircleAvatar(
                            backgroundColor: //cbluelight,
                                Color(data['containerColor']),
                            radius: 25,
                            child: Center(
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    // cbluelight,
                                    Color(data['whiteshadeColor']),
                                child: Center(
                                  child: Icon(
                                    //  Icons.alarm,
                                    IconData(data['icon'],
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          title: data['open'] == true
                              ? Text(
                                  data['headerText'],
                                  // "Holiday",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 48, 88, 86),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              : Shimmer.fromColors(
                                  baseColor: Colors.black,
                                  highlightColor: Colors.grey.withOpacity(0.1),
                                  child: Text(
                                    data['headerText'],
                                    //  "Holiday",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 48, 88, 86),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                          subtitle: Text(
                            data['messageText'],
                            // "Tommorow is Holiday",
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
                                        await pushNotificationController
                                            .removeSingleNotification(
                                                data['docid']);
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
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox();
                    },
                    itemCount: snapshot.data!.docs.length,
                  );
                } else if (snapshot.data == null) {
                  return Text(
                    "NO Notifications",
                    style:
                        TextStyle(fontSize: 20, color: cblack.withOpacity(0.5)),
                  );
                } else {
                  return circularProgressIndicatotWidget;
                }
              }),
        )
      ],
    );
  }
}
