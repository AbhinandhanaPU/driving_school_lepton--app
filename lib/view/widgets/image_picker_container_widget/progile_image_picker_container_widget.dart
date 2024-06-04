import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_project_app/constant/fonts/fonts.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/controller/image_picker_controlller/image_picker_controller.dart';

class BottomProfileImageContainerWidget extends StatelessWidget {
  const BottomProfileImageContainerWidget({
    super.key,
    required this.getImageController,
  });

  final GetImage getImageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Profile Photo".tr,
                  style: TextStyleFonts.subHeadStyle,
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                  ),
                )
              ],
            ),
          ),
          kHeight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () async {
                      await getImageController.pickImage(ImageSource.camera);
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: CircleAvatar(
                      maxRadius: 20,
                      backgroundColor: Colors.blue[300],
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  kHeight10,
                  Text(
                    "Camera".tr,
                    style: TextStyleFonts.smallTextStyle,
                  )
                ],
              ),
              kWidth30,
              Column(
                children: [
                  InkWell(
                    onTap: () async {
                      await getImageController.pickImage(ImageSource.gallery);
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: CircleAvatar(
                      maxRadius: 20,
                      backgroundColor: Colors.blue[300],
                      child: const Icon(
                        Icons.photo,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  kHeight10,
                  Text(
                    "Gallery".tr,
                    style: TextStyleFonts.smallTextStyle,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
