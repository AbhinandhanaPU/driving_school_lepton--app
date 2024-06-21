import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/images/images.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/image_picker_controlller/image_picker_controller.dart';
import 'package:new_project_app/controller/profile_edit_controllers/admin_profile_edit_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/view/users/widgets/edit_listile_widgets/admin_listtile_widget.dart';
import 'package:new_project_app/view/users/widgets/edit_listile_widgets/profile_edit_listtile_widget.dart';
import 'package:new_project_app/view/widgets/icon_backbutton_widget/icon_backbutton_widget.dart';
import 'package:new_project_app/view/widgets/image_picker_container_widget/progile_image_picker_container_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class AdminProfileEditPage extends StatefulWidget {
  const AdminProfileEditPage({super.key});

  @override
  State<AdminProfileEditPage> createState() => _AdminProfileEditPageState();
}

final AdminProfileEditController adminProfileEditController =
    Get.put(AdminProfileEditController());

class _AdminProfileEditPageState extends State<AdminProfileEditPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 300.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.h),
                    bottomRight: Radius.circular(12.h)),
                color: themeColor,
                //const Color.fromARGB(255, 88, 167, 123),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButtonBackWidget(
                        color: cWhite,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      GooglePoppinsWidgets(
                        text: "Profile".tr,
                        fontsize: 22.h,
                        color: cWhite,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          SingleChildScrollView(
                            child: AdminCircleAvatarImgeWidget(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 620.h,
              child: ListView(
                children: [
                  ProfileEditListileWidget(
                    icon: Icons.person,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text:
                              UserCredentialsController.adminModel?.adminName ??
                                  "",
                          fontsize: 19.h,
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(text: "Name".tr, fontsize: 12.h),
                        IconButton(
                          onPressed: () async {
                            adminProfileEditController
                                .editvalueController.text = "";
                            await changeAdminData(
                              context: context,
                              hintText: 'Name',
                              updateValue: 'Name',
                              validator: checkFieldEmpty,
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ProfileEditListileWidget(
                    icon: Icons.call,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text: UserCredentialsController
                                  .adminModel?.phoneNumber ??
                              "",
                          fontsize: 19.h,
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(
                            text: "Phone No.".tr, fontsize: 12.h),
                        IconButton(
                          onPressed: () async {
                            adminProfileEditController
                                .editvalueController.text = "";
                            await changeAdminData(
                                context: context,
                                hintText: 'Phone Number',
                                updateValue: 'PhoneNumber',
                                validator: checkFieldPhoneNumberIsValid,
                                textInputType: TextInputType.number);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AdminEditListileWidgetEmail(
                    icon: Icons.email,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                            text: UserCredentialsController
                                    .adminModel?.adminEmail ??
                                "",
                            fontsize: 19.h),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(text: "Email".tr, fontsize: 12.h),
                      ],
                    ),
                    editicon: Icons.edit,
                  ),
                  ProfileEditListileWidget(
                    icon: Icons.home,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text: UserCredentialsController.adminModel?.address ??
                              "",
                          fontsize: 19.h,
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(
                            text: "Address".tr, fontsize: 13.h),
                        IconButton(
                          onPressed: () async {
                            adminProfileEditController
                                .editvalueController.text = "";
                            await changeAdminData(
                              context: context,
                              hintText: 'Address',
                              updateValue: 'houseName',
                              validator: checkFieldEmpty,
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ProfileEditListileWidget(
                    icon: Icons.place,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text:
                              UserCredentialsController.adminModel?.place ?? "",
                          fontsize: 19.h,
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(text: "Place".tr, fontsize: 13.h),
                        IconButton(
                          onPressed: () async {
                            adminProfileEditController
                                .editvalueController.text = "";
                            await changeAdminData(
                              context: context,
                              hintText: 'place',
                              updateValue: 'place',
                              validator: checkFieldEmpty,
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                  ),
                  ProfileEditListileWidget(
                    icon: Icons.person,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text: UserCredentialsController
                                  .adminModel?.schoolName ??
                              "",
                          fontsize: 19.h,
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(
                            text: "School Name".tr, fontsize: 13.h),
                        IconButton(
                          onPressed: () async {
                            adminProfileEditController
                                .editvalueController.text = "";
                            await changeAdminData(
                              context: context,
                              hintText: 'Name',
                              updateValue: 'Name',
                              validator: checkFieldEmpty,
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ProfileEditListileWidget(
                    icon: Icons.pin,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text: UserCredentialsController
                                  .adminModel?.schoolCode ??
                              "",
                          fontsize: 19.h,
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(text: "Code ".tr, fontsize: 13.h),
                        IconButton(
                          onPressed: () async {
                            adminProfileEditController
                                .editvalueController.text = "";
                            await changeAdminData(
                                onTapFunction: () async {
                                  adminProfileEditController.editvalueController
                                      .text = await dateTimePicker(context);
                                },
                                context: context,
                                textInputType: TextInputType.none,
                                validator: checkFieldEmpty,
                                hintText: 'Code',
                                updateValue: 'Code');
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                  ),
                  ProfileEditListileWidget(
                    icon: Icons.place,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text:
                              UserCredentialsController.studentModel?.rtoName ??
                                  "",
                          fontsize: 19.h,
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text: "RTO name".tr,
                          fontsize: 13.h,
                        ),
                        IconButton(
                          onPressed: () async {
                            adminProfileEditController
                                .editvalueController.text = "";
                            await changeAdminData(
                              context: context,
                              hintText: 'name',
                              updateValue: 'name',
                              validator: checkFieldEmpty,
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                  ),
                  ProfileEditListileWidget(
                    icon: Icons.phone,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text: UserCredentialsController
                                  .studentModel?.licenceNumber ??
                              "",
                          fontsize: 19.h,
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text: "Licence number".tr,
                          fontsize: 13.h,
                        ),
                        IconButton(
                          onPressed: () async {
                            adminProfileEditController
                                .editvalueController.text = "";
                            await changeAdminData(
                              context: context,
                              validator: checkFieldPhoneNumberIsValid,
                              hintText: 'Licence Number',
                              updateValue: 'Licence Number',
                              textInputType: TextInputType.number,
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminCircleAvatarImgeWidget extends StatelessWidget {
  AdminCircleAvatarImgeWidget({
    super.key,
  });
  final GetImage getImageController = Get.put(GetImage());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage:
              UserCredentialsController.adminModel?.profileImageUrl == null ||
                      UserCredentialsController
                          .adminModel!.profileImageUrl.isEmpty
                  ? const NetworkImage(assetImagePathPerson)
                  : NetworkImage(
                      UserCredentialsController.adminModel?.profileImageUrl ??
                          " ") as ImageProvider,
          radius: 60,
          child: Stack(
            children: [
              InkWell(
                onTap: () async {
                  _getCameraAndGallery(context);
                },
                child: const Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: cWhite,
                    child: Icon(Icons.edit),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _getCameraAndGallery(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return BottomProfileImageContainerWidget(
              getImageController: getImageController);
        }).then(
      (value) {
        if (getImageController.pickedImage.value.isNotEmpty) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Obx(
                () => adminProfileEditController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : AlertDialog(
                        title: Text('Do you want to change profile picture'.tr),
                        actions: [
                          TextButton(
                              onPressed: () {
                                // Get.find<StudentProfileEditController>()
                                //     .updateStudentProfilePicture();
                              },
                              child: Text('Update'.tr)),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              getImageController.pickedImage.value = "";
                            },
                            child: Text('Cancel'.tr),
                          ),
                        ],
                      ),
              );
            },
          );
        }
      },
    );
  }
}

changeAdminData({
  required BuildContext context,
  required String hintText,
  required String updateValue,
  TextInputType? textInputType,
  void Function()? onTapFunction,
  String? Function(String?)? validator,
}) {
  // final formkey = GlobalKey<FormState>();
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return Form(
        key: adminProfileEditController.formKey,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          title: Text('Edit $hintText'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  onTap: onTapFunction,
                  validator: validator,
                  controller: adminProfileEditController.editvalueController,
                  decoration: InputDecoration(hintText: "Enter your $hintText"),
                  keyboardType: textInputType,
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () async {
                // if (studentProfileEditController.formKey.currentState!
                //     .validate()) {
                //   await studentProfileEditController.updateprofile(context,
                //       updateValue: updateValue,
                //       valuee: studentProfileEditController
                //           .editvalueController.text
                //           .trim());
                // } else {
                //   showToast(msg: "Something went wrong");
                //   return;
                // }
              },
            ),
          ],
        ),
      );
    },
  );
}
