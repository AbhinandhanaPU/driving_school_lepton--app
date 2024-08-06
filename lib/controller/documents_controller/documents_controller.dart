import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class DocumentsController extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController cateController = TextEditingController();

  RxBool isLoading = RxBool(false);
  Uuid uuid = const Uuid();
  String downloadUrl = '';
  final progressData = RxDouble(0.0);
  RxString fileName = "".obs;
  Rxn<Uint8List> fileBytes = Rxn<Uint8List>();
  File? filee;
  Dio dio = Dio();

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
          .child("files/Documents/${uuid.v1()}_${fileName.value}")
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
          .collection('Students')
          .doc(UserCredentialsController.studentModel!.docid)
          .collection('Documents')
          .doc(uid)
          .set({
        'title': titleController.text,
        'des': desController.text,
        'category': cateController.text,
        'downloadUrl': downloadUrl,
        'fileName': fileName.value,
        'docId': uid,
      }).then((value) {
        filee = null;
        fileBytes.value = null;
        fileName.value = '';
        titleController.clear();
        desController.clear();
        cateController.clear();
        showToast(msg: "Uploaded Successfully");
        log("Uploaded Successfully");
        Get.back();
      });

      isLoading.value = false;
    } catch (e) {
      log(e.toString(), name: "DocumentsController");
      showToast(msg: "Something Went Wrong");
      isLoading.value = false;
    }
  }

  Future<void> deleteDocuments({required String docId}) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .doc(UserCredentialsController.studentModel!.docid)
          .collection('Documents')
          .doc(docId)
          .delete()
          .then((value) {
        showToast(msg: "Deleted Successfully");
        log("Deleted Successfully");
        Get.back();
      });
    } catch (e) {
      log(e.toString(), name: "DocumentsController");
    }
  }

  Future<void> updateDocuments(String docId, BuildContext context) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .doc(UserCredentialsController.studentModel!.docid)
          .collection('Documents')
          .doc(docId)
          .update({
            'title': titleController.text,
            'des': desController.text,
            'category': cateController.text,
          })
          .then((value) => Get.back())
          .then((value) {
            titleController.clear();
            desController.clear();
            cateController.clear();
          })
          .then((value) => showToast(msg: 'Documents Updated!'));
    } catch (e) {
      showToast(msg: 'Documents Updation failed.Try Again');
      log("Documents Updation failed $e");
    }
  }

  Future<void> downloadFile(
    String url,
    String fileName,
    BuildContext context,
  ) async {
    try {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        Directory? appDocDir = await getExternalStorageDirectory();
        if (appDocDir != null) {
          String appDocPath = appDocDir.path;

          String filePath = '$appDocPath/$fileName';

          await dio.download(url, filePath);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('File downloaded'),
            ),
          );
          log(filePath);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not get the storage directory')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Storage permission denied')),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading file: $e')),
      );
    }
  }
}
