import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/event_model/events_model.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

class EventController extends GetxController {
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;
  TextEditingController eventnameController = TextEditingController();
  TextEditingController eventdateController = TextEditingController();
  TextEditingController editeventdateController = TextEditingController();
  TextEditingController eventdescriptionController = TextEditingController();
  TextEditingController eventvenueController = TextEditingController();
  TextEditingController eventsignedByController = TextEditingController();

  TextEditingController editnameController = TextEditingController();
  TextEditingController editdateController = TextEditingController();
  TextEditingController editdescriptionController = TextEditingController();
  TextEditingController editvenueController = TextEditingController();
  TextEditingController editsignedByController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final Rxn<DateTime> dateSelected = Rxn<DateTime>();
  Future<void> createEvent() async {
    final uuid = const Uuid().v1();
    final eventDetails = EventModel(
        eventDate: eventdateController.text,
        eventName: eventnameController.text,
        eventDescription: eventdescriptionController.text,
        venue: eventvenueController.text,
        signedBy: eventsignedByController.text,
        id: uuid);
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('AdminEvents')
          .doc(eventDetails.id)
          .set(eventDetails.toMap())
          .then((value) async {
        clearFields();
        buttonstate.value = ButtonState.success;
        log("Event Created Successfully");
        showToast(msg: "Event Created Successfully");
        await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
          buttonstate.value = ButtonState.idle;
        });
      });
    } catch (e) {
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      log("Event Creation Error .... $e");
    }
  }

  Future<void> updateEvent(String id, BuildContext context) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('AdminEvents')
          .doc(id)
          .update({
        'eventDate': editeventdateController.text,
        'eventName': editnameController.text,
        'eventDescription': editdescriptionController.text,
        'venue': editvenueController.text,
        'signedBy': editsignedByController.text,
      }).then((value) {
        clearFields();
        Navigator.pop(context);
      }).then((value) => showToast(msg: 'Event Updated!'));
    } catch (e) {
      log("Event Updation failed");
    }
  }

  Future<void> deleteEvent(String id, BuildContext context) async {
    try {
      server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('AdminEvents')
          .doc(id)
          .delete()
          .then((value) => showToast(msg: "Event Deleted"));
    } catch (e) {
      log("event delete failed");
    }
  }

  clearFields() {
    eventnameController.clear();
    eventdateController.clear();
    eventdescriptionController.clear();
    eventvenueController.clear();
    eventsignedByController.clear();

    editnameController.clear();
    editeventdateController.clear();
    editdescriptionController.clear();
    editvenueController.clear();
    editsignedByController.clear();
  }
}
