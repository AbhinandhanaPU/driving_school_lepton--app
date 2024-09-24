import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/notification_controller/notification_controller.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/blue_container_widget/blue_container_widget.dart';
import 'package:new_project_app/view/widgets/notification_color/notification_color_widget.dart';
import 'package:new_project_app/view/widgets/progess_button/progress_button.dart';
import 'package:new_project_app/view/widgets/textformfeild_container/textformfiled_blue_container.dart';

class Notifications extends StatelessWidget {
  Notifications({super.key});

  final NotificationController notificationCntrl =
      Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Send Notifiaction".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: Form(
        key: notificationCntrl.formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Category :",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    kWidth20,
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              BlueContainerWidget(
                                  title: "Students",
                                  fontSize: 12,
                                  color: themeColor,
                                  width: 150),
                              notificationCntrl.selectStudent.value == false
                                  ? Checkbox(
                                      value:
                                          notificationCntrl.selectStudent.value,
                                      onChanged: (value) {
                                        notificationCntrl.selectStudent.value =
                                            true;
                                      },
                                      checkColor: cWhite,
                                      activeColor: cgreen,
                                    )
                                  : Checkbox(
                                      value:
                                          notificationCntrl.selectStudent.value,
                                      onChanged: (value) {
                                        notificationCntrl.selectStudent.value =
                                            false;
                                      },
                                      checkColor: cWhite,
                                      activeColor: cgreen,
                                    ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              BlueContainerWidget(
                                  title: "Teachers",
                                  fontSize: 12,
                                  color: themeColor,
                                  width: 150),
                              notificationCntrl.selectTeacher.value == false
                                  ? Checkbox(
                                      value:
                                          notificationCntrl.selectTeacher.value,
                                      onChanged: (value) {
                                        notificationCntrl.selectTeacher.value =
                                            true;
                                      },
                                      checkColor: cWhite,
                                      activeColor: cgreen,
                                    )
                                  : Checkbox(
                                      value:
                                          notificationCntrl.selectTeacher.value,
                                      onChanged: (value) {
                                        notificationCntrl.selectTeacher.value =
                                            false;
                                      },
                                      checkColor: cWhite,
                                      activeColor: cgreen,
                                    ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                TextFormFiledHeightnoColor(
                  width: double.infinity,
                  validator: checkFieldEmpty,
                  controller: notificationCntrl.headingController,
                  title: 'Heading',
                  hintText: ' Enter Messages',
                ),
                kHeight20,
                TextFormFiledHeightnoColor(
                  width: double.infinity,
                  validator: checkFieldEmpty,
                  controller: notificationCntrl.messageController,
                  title: 'Content',
                  hintText: ' Enter Messages',
                  maxLines: 10,
                ),
                kHeight50,
                Obx(
                  () => Center(
                    child: ProgressButtonWidget(
                        function: () async {
                          notificationCntrl.selectedUSerUIDList.clear();
                          if (notificationCntrl.formKey.currentState!
                              .validate()) {
                            Future<void> sendNotificationsForRole(
                                String role) async {
                              await notificationCntrl.fetchUsersID(role: role);
                              await notificationCntrl
                                  .sendNotificationSelectedUsers(
                                icon: Icons.warning_rounded,
                                whiteshadeColor:
                                    InfoNotifierSetup().whiteshadeColor,
                                containerColor:
                                    InfoNotifierSetup().containerColor,
                              )
                                  .then((value) {
                                notificationCntrl.headingController.clear();
                                notificationCntrl.messageController.clear();
                              });
                            }

                            if (notificationCntrl.selectStudent.value &&
                                notificationCntrl.selectTeacher.value) {
                              // Fetch and send notifications for both students and teachers
                              await sendNotificationsForRole('student');
                              await sendNotificationsForRole('teacher');
                            } else if (notificationCntrl.selectStudent.value) {
                              // Fetch and send notifications for students only
                              await sendNotificationsForRole('student');
                            } else if (notificationCntrl.selectTeacher.value) {
                              // Fetch and send notifications for teachers only
                              await sendNotificationsForRole('teacher');
                            }
                          }
                        },
                        buttonstate: notificationCntrl.buttonstate.value,
                        text: 'Send Message'),
                  ),
                ),
                kHeight10
              ],
            ),
          ),
        ),
      ),
    );
  }
}
