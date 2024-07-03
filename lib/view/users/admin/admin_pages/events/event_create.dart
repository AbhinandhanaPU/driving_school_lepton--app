// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/event_controller/event_controller.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/progess_button/progress_button.dart';
import 'package:new_project_app/view/widgets/textformfeild_container/textformfiled_blue_container.dart';

class EventCreate extends StatelessWidget {
  EventCreate({super.key});
  EventController eventController = Get.put(EventController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Event".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: SingleChildScrollView(
          child: Form(
            key: eventController.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormFiledHeightnoColor(
                  width: double.infinity,
                  validator: checkFieldEmpty,
                  controller: eventController.eventnameController,
                  title: 'Event Name',
                  hintText: 'Event Name',
                ),
                kHeight20,
                TextFormFiledHeightnoColor(
                  onTap: () async {
                    eventController.eventdateController.text =
                        await dateTimePicker(context);
                  },
                  width: double.infinity,
                  validator: checkFieldDateIsValid,
                  controller: eventController.eventdateController,
                  title: 'Date',
                  hintText: 'Date',
                ), ////////////////////////////////////////////////////////1
                kHeight20,
                TextFormFiledHeightnoColor(
                  width: double.infinity,
                  validator: checkFieldEmpty,
                  controller: eventController.eventvenueController,
                  title: 'Venue',
                  hintText: 'Venue',
                ), ///////////////////////////////////////////////2
                kHeight20,
                TextFormFiledHeightnoColor(
                  width: double.infinity,
                  validator: checkFieldEmpty,
                  controller: eventController.eventdescriptionController,
                  title: 'Description',
                  hintText: 'Description',
                ), ////////////////////////////////////3
                kHeight20,
                TextFormFiledHeightnoColor(
                  width: double.infinity,
                  validator: checkFieldEmpty,
                  controller: eventController.eventsignedByController,
                  title: 'Signed by',
                  hintText: 'Signed by',
                ), ////////////////////////////////////4
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 10),
                  child: Center(
                    child: Obx(
                      () => ProgressButtonWidget(
                          function: () async {
                            if (eventController.formKey.currentState!
                                .validate()) {
                              eventController
                                  .createEvent()
                                  .then((value) => Navigator.pop(context));
                            }
                          },
                          buttonstate: eventController.buttonstate.value,
                          text: 'Create Event'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
