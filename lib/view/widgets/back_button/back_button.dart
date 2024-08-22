import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class BackButtonContainerWidget extends StatelessWidget {
  const BackButtonContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 30,
        width: 80,
        decoration: const BoxDecoration(
          color: themeColor,
        ),
        child: Center(
          child: GooglePoppinsWidgets(
              text: 'BACK',
              color: cWhite,
              fontsize: 12,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
