import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/view/widgets/back_button/back_button.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';


customShowDilogBox2(
    {required BuildContext context,
    required String title,
    required List<Widget> children,
    String? actiontext,
    Widget? headerchild,
    required bool doyouwantActionButton,
    void Function()? actiononTapfuction}) {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
          backgroundColor: cWhite,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerchild ?? const SizedBox(),
              GooglePoppinsWidgets(
                  text: title, fontsize: 13, fontWeight: FontWeight.w600),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: BackButtonContainerWidget(),
              )
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: children,
            ),
          ),
          actions: doyouwantActionButton == true
              ? <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: actiononTapfuction,
                      child: Container(
                        height: 40,
                        width: 250,
                        decoration: const BoxDecoration(
                          color: themeColor,
                        ),
                        child: Center(
                          child: GooglePoppinsWidgets(
                              text: actiontext ?? 'Ok',
                              color: cWhite,
                              fontsize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 40,
                        width: 250,
                        decoration: const BoxDecoration(
                          color: themeColor,
                        ),
                        child: Center(
                          child: GooglePoppinsWidgets(
                              text: actiontext ?? 'Cancel',
                              color: cWhite,
                              fontsize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )
                ]
              : null);
    },
  );
}
