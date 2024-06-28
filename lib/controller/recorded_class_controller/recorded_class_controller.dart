import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:uuid/uuid.dart';

class VideosController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController videoNameController = TextEditingController();
  TextEditingController videoDesController = TextEditingController();
  TextEditingController videoCategoryController = TextEditingController();

  RxBool isLoading = RxBool(false);
  RxBool chapterIsLoading = RxBool(false);
  Uuid uuid = const Uuid();
  String downloadUrl = '';
  final progressData = RxDouble(0.0);

  Rxn<File?> file = Rxn();

  Future<void> uploadToFirebase({
    required BuildContext context,
  }) async {
    try {
      isLoading.value = true;
      String uid2 = const Uuid().v1();
      UploadTask uploadTask =
          FirebaseStorage.instance.ref().child("files/recorded_clasees/$uid2").putFile(file.value!);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        progressData.value = progress;
      });

      final taskProgress = await uploadTask;

      downloadUrl = await taskProgress.ref.getDownloadURL();
      String uid = const Uuid().v1();
      FirebaseFirestore.instance
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('RecordedClass')
          .doc(uid)
          .set({
        'topicName': videoNameController.text,
        'title': videoDesController.text,
        'downloadUrl': downloadUrl,
        'fileId': "$uid2",
        'docid': uid,
      }).then((value) {
        file.value = null;
        videoNameController.clear();
        videoDesController.clear();
        videoCategoryController.clear();

        showToast(msg: "Uploaded Successfully");
        Get.back();
      });

      isLoading.value = false;
    } catch (e) {
      log(e.toString(), name: "RecordedClassController");
      showToast(msg: "Something Went Wrong");
    }
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowedExtensions: ['mkv', 'mp4', 'mov', 'avi'],
          type: FileType.custom,
          allowCompression: true);

      if (result != null) {
        file.value = File(result.files.single.path!);
      } else {
        log('No file selected', name: "RecordedClassController");
      }
    } catch (e) {
      log(e.toString(), name: "RecordedClassController");
    }
  }
}
