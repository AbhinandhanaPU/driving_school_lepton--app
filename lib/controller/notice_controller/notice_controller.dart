import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/notice_model/notice_model.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

class NoticeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;

  TextEditingController noticeHeadingController = TextEditingController();
  TextEditingController noticePublishedDateController = TextEditingController();
  TextEditingController noticeSubjectController = TextEditingController();
  TextEditingController noticeSignedByController = TextEditingController();

  Future<void> createNotice() async {
    final uuid = const Uuid().v1();
    final noticeDetails = NoticeModel(
        subject: noticeSubjectController.text,
        publishedDate: noticePublishedDateController.text,
        heading: noticeHeadingController.text,
        signedBy: noticeSignedByController.text,
        noticeId: uuid);
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('AdminNotices')
          .doc(noticeDetails.noticeId)
          .set(noticeDetails.toMap())
          .then((value) async {
        noticeSubjectController.clear();
        noticePublishedDateController.clear();
        noticeHeadingController.clear();
        noticeSignedByController.clear();
        buttonstate.value = ButtonState.success;

        showToast(msg: "Notice Created Successfully");
        await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
          buttonstate.value = ButtonState.idle;
        });
      });
    } catch (e) {
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      log("Error .... $e");
    }
  }

  Future<void> updateNotice(String noticeId, BuildContext context) async {
    try {
      server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('AdminNotices')
          .doc(noticeId)
          .update({
            'subject': noticeSubjectController.text,
            'publishedDate': noticePublishedDateController.text,
            'heading': noticeHeadingController.text,
            'signedBy': noticeSignedByController.text,
          })
          .then((value) {
            noticeSubjectController.clear();
            noticePublishedDateController.clear();
            noticeHeadingController.clear();
            noticeSignedByController.clear();
          })
          .then((value) => Navigator.pop(context))
          .then((value) => showToast(msg: 'Notice Updated!'));
    } catch (e) {
      showToast(msg: 'Notice  Updation failed.Try Again');
      log("Notice Updation failed $e");
    }
  }

  Future<void> deleteNotice(String noticeId, BuildContext context) async {
    log("noticeId -----------$noticeId");
    server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('AdminNotices')
        .doc(noticeId)
        .delete()
        .then((value) => showToast(msg: 'Notice deleted'));
  }
}
