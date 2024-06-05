import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/helper/shared_pref_helper.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/school_list_model/school_model.dart';

class SchoolController extends GetxController {
  List<SchoolModel> schoolModelList = [];

  Future<void> fetchAllSchoolData() async {
    schoolModelList.clear();
    try {
      final QuerySnapshot<Map<String, dynamic>> data =
          await server.collection('DrivingSchoolCollection').get();
      schoolModelList =
          data.docs.map((e) => SchoolModel.fromJson(e.data())).toList();
      if (schoolModelList.isNotEmpty) {
        UserCredentialsController.schoolId = schoolModelList[0].docid;
        await SharedPreferencesHelper.setString(
            SharedPreferencesHelper.schoolIdKey,
            UserCredentialsController.schoolId ?? "");
        log("UserCredentialsController.schoolId: ${UserCredentialsController.schoolId}");
      } else {
        log("No schools found in the collection.");
      }
    } catch (e) {
      log("error ${e.toString()}");
    }
  }
}
