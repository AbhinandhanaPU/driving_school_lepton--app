import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/image_picker_controlller/image_picker_controller.dart';
import 'package:new_project_app/model/admin_model/admin_model.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

class CreateschoolController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();

  RxBool isLoading = RxBool(false);
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  TextEditingController schoolNameController = TextEditingController();
  TextEditingController schoolCodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController adminUserNameController = TextEditingController();
  TextEditingController schoolLicenceNumberController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  RxString countryValue = ''.obs;
  RxString stateValue = ''.obs;
  RxString cityValue = ''.obs;
  String uid = const Uuid().v1();

  Future<void> addNewSchool(BuildContext context) async {
    buttonstate.value = ButtonState.loading;
    String profileImageId = "";
    String profileImageUrl = "";
    String uUID = schoolNameController.text.substring(0, 5) +
        cityValue.value.substring(0, 5) +
        uuid.v1();
    try {
      isLoading.value = true;
      profileImageId = uid;
      final result = await serverStorage
          .ref("files/schoolPhotos/$profileImageId")
          .putFile(File(Get.find<GetImage>().pickedImage.value));
      profileImageUrl = await result.ref.getDownloadURL();

      AdminModel adminModel = AdminModel(
          docid: uUID,
          country: countryValue.value,
          state: stateValue.value,
          city: cityValue.value,
          password: passwordController.text,
          adminEmail: emailController.text,
          adminName: adminUserNameController.text,
          schoolCode: schoolCodeController.text,
          schoolName: schoolNameController.text,
          phoneNumber: phoneNumberController.text,
          schoolLicenceNumber: schoolLicenceNumberController.text,
          address: addressController.text,
          place: placeController.text,
          designation: designationController.text,
          profileImageId: profileImageId,
          profileImageUrl: profileImageUrl,
          createdDate: DateTime.now().toString(),
          verified: false,
          userRole: "admin");
      if (await checkSchoolIsCreated(
          schoolNameController.text, placeController.text)) {
        showToast(msg: 'School Is Already Created');
      } else {
        if (context.mounted) {}
        serverAuth
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            )
            .then(
              (value) => addRequestedSchools(
                adminModel,
                context,
              ).then((value) {
                clearFunction();
                Get.find<GetImage>().pickedImage.value = '';
              }),
            );
      }
      await server.collection('RequestedSchools').doc(uUID).set(
            adminModel.toMap(),
          );
    } on FirebaseAuthException catch (e) {
      showToast(msg: e.code);
    } catch (e) {
      log(e.toString());
      showToast(msg: 'Somthing went wrong please try again');
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
    }
  }

  Future<bool> checkSchoolIsCreated(String schoolName, String place) async {
    final schoolListCollection =
        await server.collection('DrivingSchoolCollection').get();
    if (schoolListCollection.docs.isEmpty) {
      return false;
    }

    for (var element in schoolListCollection.docs) {
      if (element.data()["schoolName"] == schoolName &&
          element.data()["place"] == place) {
        return true;
      }
    }
    return false;
  }

  Future<void> addRequestedSchools(AdminModel adminModel, context) async {
    try {
      server
          .collection('DrivingSchoolCollection')
          .doc(adminModel.docid)
          .set(adminModel.toMap())
          .then((value) {
        return showDialog(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Message'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                        "Your account created successfully. Please login again to continue ...")
                    // Text(
                    //     "Thank you for applying for an account. Your account is currently pending approval \n"
                    //     " by the site administrator. In the meantime, a welcome message with further\n"
                    //     " instructions has been sent to your e-mail address. "),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () async {
                    Navigator.pop(context);
                    await Future.delayed(const Duration(milliseconds: 500));
                  },
                ),
              ],
            );
          },
        );
      });
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Error ${e.message.toString()}');
      }
    }
  }

  void clearFunction() {
    schoolNameController.clear();
    designationController.clear();
    schoolCodeController.clear();
    placeController.clear();
    addressController.clear();
    adminUserNameController.clear();
    passwordController.clear();
    phoneNumberController.clear();
    emailController.clear();
    confirmPassController.clear();
    schoolLicenceNumberController.clear();
    countryValue.value = '';
    stateValue.value = '';
    cityValue.value = '';
  }
}
