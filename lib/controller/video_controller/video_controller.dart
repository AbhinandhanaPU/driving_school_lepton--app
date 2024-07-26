import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:uuid/uuid.dart';

class VideosController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController videoTitleController = TextEditingController();
  TextEditingController videoDesController = TextEditingController();
  TextEditingController videoCateController = TextEditingController();

  TextEditingController editVideoTitleController = TextEditingController();
  TextEditingController editVideoDesController = TextEditingController();
  TextEditingController editVideoCateController = TextEditingController();
  RxBool isLoading = RxBool(false);
  Uuid uuid = const Uuid();
  String downloadUrl = '';
  final progressData = RxDouble(0.0);
  RxString fileName = "".obs;

  Rxn<File?> file = Rxn();

  clearFields() {
    videoTitleController.clear();
    videoDesController.clear();
    videoCateController.clear();
    editVideoTitleController.clear();
    editVideoDesController.clear();
    editVideoCateController.clear();
  }

  Future<void> uploadToFirebase() async {
    try {
      isLoading.value = true;
      String uid2 = const Uuid().v1();
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("files/recorded_clasees/$uid2")
          .putFile(file.value!);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        progressData.value = progress;
      });

      final taskSnapshot = await uploadTask;
      downloadUrl = await taskSnapshot.ref.getDownloadURL();
      log('downloadUrl: $downloadUrl');

      String uid = uuid.v1();
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Videos')
          .doc(uid)
          .set({
        'videoTitle': videoTitleController.text,
        'videoDes': videoDesController.text,
        'videoCategory': videoCateController.text,
        'downloadUrl': downloadUrl,
        'fileName': fileName.value,
        'docId': uid,
      }).then((value) {
        clearFields();
        file.value = null;
        showToast(msg: "Uploaded Successfully");
        log("Uploaded Successfully");
        Get.back();
      });

      isLoading.value = false;
    } catch (e) {
      log(e.toString(), name: "VideosController");
      showToast(msg: "Something Went Wrong");
      isLoading.value = false;
    }
  }

  Future<void> deletevideo({required String docId}) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Videos')
          .doc(docId)
          .delete()
          .then((value) {
        showToast(msg: "Deleted Successfully");
        log("Deleted Successfully");
        Get.back();
      });
    } catch (e) {
      log(e.toString(), name: "VideosController");
    }
  }

  Future<void> updateVideo(String videoId, BuildContext context) async {
    try {
      server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Videos')
          .doc(videoId)
          .update({
            'videoTitle': editVideoTitleController.text,
            'videoDes': editVideoDesController.text,
            'videoCategory': videoCateController.text,
          })
          .then((value) {
            clearFields();
          })
          .then((value) => Navigator.pop(context))
          .then((value) => showToast(msg: 'Video Updated!'));
    } catch (e) {
      showToast(msg: 'Video  Updation failed.Try Again');
      log("Video Updation failed $e");
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
        fileName.value = result.files.single.name;
      } else {
        log('No file selected', name: "VideosController");
      }
    } catch (e) {
      log(e.toString(), name: "VideosController");
    }
  }
}
