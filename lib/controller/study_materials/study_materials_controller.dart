import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:uuid/uuid.dart';

class StudyMaterialController extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController videoTitleController = TextEditingController();
  TextEditingController videoDesController = TextEditingController();
  TextEditingController videoCateController = TextEditingController();

  RxBool isLoading = RxBool(false);
  Uuid uuid = const Uuid();
  String downloadUrl = '';
  final progressData = RxDouble(0.0);
  RxString fileName = "".obs;
  Rxn<Uint8List> fileBytes = Rxn<Uint8List>();
  File? filee;

  Future<void> pickAFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: [
          'pdf',
          'txt',
          'doc',
          'docx',
          'jpg',
          'jpeg',
          'png',
        ],
        type: FileType.custom,
        allowCompression: true,
      );

      if (result != null) {
        filee = File(result.files.single.path!);
        fileBytes.value = result.files.single.bytes;
        fileName.value = result.files.single.name;
      } else {
        log('No file selected', name: "StudyMaterials");
      }
    } catch (e) {
      log(e.toString(), name: "StudyMaterials");
    }
  }

  Future<void> uploadToFirebase() async {
    try {
      isLoading.value = true;

      if (filee == null) {
        throw Exception('No file selected');
      }

      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("files/StudyMaterials/${uuid.v1()}_${fileName.value}")
          .putFile(filee!);

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
          .collection('StudyMaterials')
          .doc(uid)
          .set({
        'title': videoTitleController.text,
        'des': videoDesController.text,
        'category': videoCateController.text,
        'downloadUrl': downloadUrl,
        'fileName': fileName.value,
        'docId': uid,
      }).then((value) {
        filee = null;
        fileBytes.value = null;
        fileName.value = '';
        videoTitleController.clear();
        videoDesController.clear();
        videoCateController.clear();
        showToast(msg: "Uploaded Successfully");
        log("Uploaded Successfully");
        Get.back();
      });

      isLoading.value = false;
    } catch (e) {
      log(e.toString(), name: "StudyMaterialsController");
      showToast(msg: "Something Went Wrong");
      isLoading.value = false;
    }
  }
}
