import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/const/const.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/helper/shared_pref_helper.dart';
import 'package:new_project_app/controller/image_picker_controlller/image_picker_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/teacher_model/teacher_model.dart';
import 'package:new_project_app/view/users/teacher/teacher_home_page/teacher_home_page.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

class TeacherSignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  RxBool isLoading = RxBool(false);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController fatherSpouseController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController rtoNameController = TextEditingController();
  TextEditingController licenceController = TextEditingController();
  void clearFields() {
    emailController.clear();
    passwordController.clear();
    confirmpasswordController.clear();
    nameController.clear();
    phoneController.clear();
    dateOfBirthController.clear();
    fatherSpouseController.clear();
    placeController.clear();
    addressController.clear();
    rtoNameController.clear();
    licenceController.clear();
  }

  String uid = const Uuid().v1();
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;

  Future<void> createTeacher(BuildContext context) async {
    buttonstate.value = ButtonState.loading;
    String imageId = "";
    String imageUrl = "";
    try {
      if (Get.find<GetImage>().pickedImage.isNotEmpty) {
        isLoading.value = true;
        imageId = uid;
        final result = await serverStorage
            .ref(
                "files/teacherPhotos/${UserCredentialsController.schoolId}/${UserCredentialsController.teacherModel?.teacherName}$imageId")
            .putFile(File(Get.find<GetImage>().pickedImage.value));
        imageUrl = await result.ref.getDownloadURL();
        await serverAuth
            .createUserWithEmailAndPassword(
                email: TeacherPasswordSaver.teacherEmailID,
                password: TeacherPasswordSaver.teacherPassword)
            .then((authvalue) async {
          TeacherModel teacherModel = TeacherModel(
              docid: authvalue.user!.uid,
              password: passwordController.text,
              teacheremail: emailController.text,
              teacherName: nameController.text,
              phoneNumber: phoneController.text,
              dateofBirth: dateOfBirthController.text,
              guardianName: fatherSpouseController.text,
              address: addressController.text,
              place: placeController.text,
              profileImageId: imageId,
              profileImageUrl: imageUrl,
              rtoName: rtoNameController.text,
              licenceNumber: licenceController.text,
              userRole: "teacher");
          await server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection('Teachers')
              .doc(authvalue.user!.uid)
              .set(
                teacherModel.toMap(),
              )
              .then(
            (value) async {
              buttonstate.value = ButtonState.success;
              await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
                buttonstate.value = ButtonState.idle;
              });
              final user = await server
                  .collection('DrivingSchoolCollection')
                  .doc(UserCredentialsController.schoolId)
                  .collection('Teachers')
                  .doc(authvalue.user!.uid)
                  .get();
              if (user.data() != null) {
                UserCredentialsController.teacherModel = TeacherModel.fromMap(user.data()!);
                log(UserCredentialsController.teacherModel.toString());
              }

              if (UserCredentialsController.teacherModel?.userRole == "teacher") {
                await SharedPreferencesHelper.setString(
                    SharedPreferencesHelper.currenUserKey, authvalue.user!.uid);
                await SharedPreferencesHelper.setString(
                        SharedPreferencesHelper.userRoleKey, 'teacher')
                    .then((value) {
                  clearFields();
                  return showDialog(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Message'),
                        content: const SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[Text('Your Profile Created Successfully ')],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                builder: (context) {
                                  return const TeachersMainHomeScreen();
                                },
                              ), (route) => false);
                              TeacherPasswordSaver.teacherEmailID = '';
                              TeacherPasswordSaver.teacherPassword = '';
                            },
                          ),
                        ],
                      );
                    },
                  );
                });

                isLoading.value = false;
              }
            },
          ).then((value) {
            clearFields();
            isLoading.value = false;
          });
        });
      } else {
        showToast(msg: "Please upload profile image");
      }
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
}
