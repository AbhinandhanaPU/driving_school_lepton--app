import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/notification_controller/notification_controller.dart';
import 'package:new_project_app/controller/practice_shedule_controller/practice_shedule_controller.dart';
import 'package:new_project_app/view/widgets/back_button/back_button.dart';
import 'package:new_project_app/view/widgets/blue_container_widget/blue_container_widget.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';
import 'package:new_project_app/view/widgets/progess_button/progress_button.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';
import 'package:progress_state_button/progress_button.dart';

sendPracticeScheduleNotification(BuildContext context) {
  final PracticeSheduleController practiceSheduleController =
      Get.put(PracticeSheduleController());
  final NotificationController notificationController =
      Get.put(NotificationController());
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButtonContainerWidget(),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextFontWidget(
                text: "Select Schedule",
                fontsize: 15,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        content: SizedBox(
          height: 380,
          width: 300,
          child: Form(
            key: practiceSheduleController.formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlueContainerWidget(
                        title: "Selecet All",
                        fontSize: 12,
                        color: cblack,
                        width: 100),
                    const SizedBox(
                      width: 10,
                    ),
                    Obx(() =>
                        practiceSheduleController.selectAllSchedule.value ==
                                false
                            ? Checkbox(
                                value: practiceSheduleController
                                    .selectAllSchedule.value,
                                onChanged: (value) {
                                  practiceSheduleController.selectedScheduleList
                                      .addAll(practiceSheduleController
                                          .allScheduleList);
                                  practiceSheduleController
                                      .selectAllSchedule.value = true;
                                },
                              )
                            : Checkbox(
                                checkColor: cWhite,
                                activeColor: cblue,
                                value: practiceSheduleController
                                    .selectAllSchedule.value,
                                onChanged: (value) {
                                  practiceSheduleController
                                      .selectAllSchedule.value = false;
                                  practiceSheduleController.selectedScheduleList
                                      .clear();
                                },
                              ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20),
                  child: SizedBox(
                    height: 300,
                    child: FutureBuilder(
                      future: practiceSheduleController.fetchPracticeSchdule(),
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? ListView.separated(
                                itemBuilder: (context, index) {
                                  final data = snapshot.data![index];
                                  return Obx(
                                    () => Container(
                                      color: practiceSheduleController
                                              .selectedScheduleList
                                              .where((element) =>
                                                  element.practiceId.contains(
                                                      practiceSheduleController
                                                          .allScheduleList[
                                                              index]
                                                          .practiceId))
                                              .isNotEmpty
                                          ? Colors.green.withOpacity(0.1)
                                          : Colors.blue.withOpacity(0.2),
                                      height: 35,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            TextFontWidget(
                                                text: data.practiceName,
                                                fontsize: 12),
                                            const Spacer(),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                      cblack.withOpacity(0.1),
                                                ),
                                              ),
                                              height: 30,
                                              child: practiceSheduleController
                                                      .selectedScheduleList
                                                      .where(
                                                        (element) => element
                                                            .practiceId
                                                            .contains(
                                                                practiceSheduleController
                                                                    .allScheduleList[
                                                                        index]
                                                                    .practiceId),
                                                      )
                                                      .isNotEmpty
                                                  ? Checkbox(
                                                      checkColor: cWhite,
                                                      activeColor: cgreen,
                                                      value: true,
                                                      onChanged: (value) {
                                                        final indexx = practiceSheduleController
                                                            .selectedScheduleList
                                                            .indexWhere((element) =>
                                                                element
                                                                    .practiceId ==
                                                                practiceSheduleController
                                                                    .allScheduleList[
                                                                        index]
                                                                    .practiceId);

                                                        if (indexx != -1) {
                                                          practiceSheduleController
                                                              .selectedScheduleList
                                                              .removeAt(indexx);
                                                        } else {
                                                          practiceSheduleController
                                                              .selectedScheduleList
                                                              .add(practiceSheduleController
                                                                      .allScheduleList[
                                                                  index]);
                                                        }
                                                      },
                                                    )
                                                  : GestureDetector(
                                                      onTap: () {
                                                        practiceSheduleController
                                                            .selectedScheduleList
                                                            .add(practiceSheduleController
                                                                    .allScheduleList[
                                                                index]);
                                                      },
                                                      child:
                                                          const TextFontWidget(
                                                        text: 'Select',
                                                        fontsize: 12,
                                                        color: cblack,
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 05,
                                  );
                                },
                                itemCount: snapshot.data!.length,
                              )
                            : const LoadingWidget();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Obx(
            () => Center(
              child: ProgressButtonWidget(
                  function: () async {
                    if (practiceSheduleController
                        .selectedScheduleList.isNotEmpty) {
                      log('selected schedule : ${practiceSheduleController.selectedScheduleList.length}');
                      practiceSheduleController.buttonstate.value =
                          ButtonState.loading;
                      notificationController
                          .sendNotificationParticeSchedule(
                              bodyText: 'practice schedule',
                              titleText: 'Practice Scedule Notification',
                              selectedListDocID: practiceSheduleController
                                  .selectedScheduleList)
                          .then((value) {
                        Get.back();
                      });
                    } else {
                      showToast(msg: 'select any schedule');
                    }
                  },
                  buttonstate: practiceSheduleController.buttonstate.value,
                  text: 'Sent Notification'),
            ),
          ),
        ],
      );
    },
  );
}
