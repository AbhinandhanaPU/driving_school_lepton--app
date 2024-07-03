import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/event_controller/event_controller.dart';
import 'package:new_project_app/model/event_model/events_model.dart';
import 'package:new_project_app/view/widgets/custom_show_dialogbox/custom_show_dialouge.dart';
import 'package:new_project_app/view/widgets/textformfeild_container/textformfiled_blue_container.dart';

editFunctionOfEvent(BuildContext context, EventModel data) {
  final EventController eventController = Get.put(EventController());
  customShowDilogBox(
      context: context,
      title: 'Edit',
      children: [
        Form(
          key: eventController.formKey,
          child: Column(
            children: [
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: eventController.editnameController,
                  hintText: data.eventName,
                  title: 'Event'),
              kHeight10,
              TextFormFiledHeightnoColor(
                  onTap: () async {
                    eventController.editeventdateController.text =
                        await dateTimePicker(context);
                  },
                  controller: eventController.editeventdateController,
                  hintText: data.eventDate,
                  validator: checkFieldDateIsValid,
                  title: 'Date'),
              kHeight10,
              TextFormFiledHeightnoColor(
                  controller: eventController.editvenueController,
                  hintText: data.venue,
                  validator: checkFieldEmpty,
                  title: 'Venue'),
              kHeight10,
              TextFormFiledHeightnoColor(
                  controller: eventController.editdescriptionController,
                  hintText: data.eventDescription,
                  validator: checkFieldEmpty,
                  title: 'Description'),
              kHeight10,
              TextFormFiledHeightnoColor(
                  controller: eventController.editsignedByController,
                  hintText: data.signedBy,
                  validator: checkFieldEmpty,
                  title: 'Signed by')
            ],
          ),
        ),
      ],
      doyouwantActionButton: true,
      actiononTapfuction: () {
        if (eventController.formKey.currentState!.validate()) {
          eventController.updateEvent(data.id, context);
        }
      },
      actiontext: 'Update');
}
