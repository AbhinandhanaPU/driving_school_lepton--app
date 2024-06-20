import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:new_project_app/constant/colors/colors.dart';

class CreateTutor extends StatelessWidget {
  const CreateTutor({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.blue[50],
            appBar: AppBar(
              title: Row(
                children: [
                  Text("Create Tutor".tr),
                ],
              ),
              backgroundColor: themeColor,
            ),
            body: Row(
              children: [
                Column(
                  children: [Text('Teacher Name'),Container()],
                )
              ],
            )));
  }
}
