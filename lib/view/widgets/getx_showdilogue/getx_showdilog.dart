import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/view/widgets/back_button/back_button.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

getxcustomShowDialogBox({
  required String title,
  required List<Widget> children,
  String? actionText,
  required bool doYouWantActionButton,
  void Function()? actionOnTapFunction,
}) {
  return Get.dialog(
    AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GooglePoppinsWidgets(
              text: title, fontsize: 15, fontWeight: FontWeight.w600),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: BackButtonContainerWidget(),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: children,
        ),
      ),
      actions: doYouWantActionButton
          ? <Widget>[
              GestureDetector(
                onTap: actionOnTapFunction,
                child: Container(
                  height: 40,
                  width: 250,
                  decoration: const BoxDecoration(
                    color: themeColor,
                  ),
                  child: Center(
                    child: GooglePoppinsWidgets(
                        text: actionText ?? 'OK',
                        color: cWhite,
                        fontsize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ]
          : null,
    ),
    barrierDismissible: false, // user must tap button!
  );
}
