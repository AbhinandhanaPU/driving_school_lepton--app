import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/admin_controller/admin_controller.dart';
import 'package:new_project_app/view/widgets/progess_button/progress_button.dart';
import 'package:new_project_app/view/widgets/textformfeild_container/textformfiled_blue_container.dart';

class CreateSecondaryAdmin extends StatelessWidget {
  const CreateSecondaryAdmin({super.key});
  @override
  Widget build(BuildContext context) {
    final AdminController adminController = Get.put(AdminController());

    final createTutorList = [
      TextFormFiledBlueContainerWidgetWithOutColor(
        controller: adminController.nameController,
        hintText: " Enter Name",
        title: 'Admin  Name',
        validator: checkFieldEmpty,
      ), /////////////////////////...........................0....................name
      TextFormFiledBlueContainerWidgetWithOutColor(
        controller: adminController.phoneNumberController,
        keyboardType: TextInputType.number,
        hintText: " Enter Phone Number",
        title: 'Phone Number',
        validator: checkFieldPhoneNumberIsValid,
      ), //////////////////1....................number...................
      TextFormFiledBlueContainerWidgetWithOutColor(
        controller: adminController.emailController,
        keyboardType: TextInputType.emailAddress,
        hintText: " Enter Email",
        title: 'Admin Email',
        validator: checkFieldEmailIsValid,
      ), ///////////////////4.......................
      TextFormFiledBlueContainerWidgetWithOutColor(
        controller: adminController.passwordController,
        hintText: "Set a Password",
        title: 'Password',
        validator: checkFieldPasswordIsValid,
      ), ///////////////////4.......................
      TextFormFiledBlueContainerWidgetWithOutColor(
        controller: adminController.conformpassController,
        hintText: " Enter Confirm Password",
        title: 'Confirm Password',
        validator: checkFieldPasswordIsValid,
      ), ///////////////////4.......................
      Obx(
        () => ProgressButtonWidget(
            function: () async {
              if (adminController.formKey.currentState!.validate()) {
                if (adminController.conformpassController.text.trim() ==
                    adminController.passwordController.text.trim()) {
                  adminController.createNewAdmin(context).then((value) => Get.back());
                }
              }
            },
            buttonstate: adminController.buttonstate.value,
            text: 'Create Admin '),
      ),
    ];

    return SafeArea(
      child: Scaffold(
          backgroundColor: screenContainerbackgroundColor,
          appBar: AppBar(
            title: Row(
              children: [
                Text("Create Admin".tr),
              ],
            ),
            backgroundColor: themeColor,
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, top: 30),
            child: SingleChildScrollView(
              child: Form(
                key: adminController.formKey,
                child: Column(
                  children: [
                    createTutorList[0],
                    createTutorList[1],
                    createTutorList[2],
                    createTutorList[3],
                    createTutorList[4],
                    createTutorList[5],
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
