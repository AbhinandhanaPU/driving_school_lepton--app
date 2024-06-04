import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/view/widgets/image_container_widgets/image_container_widgets.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_montserrat.dart';

class UserContainer extends StatelessWidget {
  const UserContainer(
      {super.key,
      required this.width,
      required this.imagePath,
      required this.imageText});
  final double width;
  final String imagePath;
  final String imageText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 2 / 3,
      height: width * 1 / 3,
      margin: EdgeInsets.only(
          bottom: width / 10,
          left: width / 20,
          right: width / 20,
          top: width / 20),
      decoration: BoxDecoration(
        border: Border.all(color: cbluelight, width: 0.3),
        color: const Color.fromARGB(250, 219, 232, 255).withOpacity(0.4),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: cblack.withOpacity(0.1),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AssetContainerImage(height: 60, width: 60, imagePath: imagePath),
          GoogleMontserratWidgets(
            text: imageText,
            letterSpacing: 1,
            fontsize: 20,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
