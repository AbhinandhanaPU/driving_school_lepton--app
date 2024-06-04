// ignore_for_file: must_be_immutable

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class SignUpTextFromFiled extends StatelessWidget {
  String text;
  String hintText;
  int? maxLines;
  int? maxLength;
  bool readOnly;
  TextInputType? keyboardType;
  final TextEditingController textfromController;
  String? Function(String?)? validator;
  void Function()? onTapFunction;
  SignUpTextFromFiled({
    required this.text,
    required this.hintText,
    this.maxLines,
    this.maxLength,
    this.keyboardType,
    required this.textfromController,
    this.validator,
    this.onTapFunction,
    this.readOnly = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: maxLines == 3 ? 170.h : 115.h,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GooglePoppinsWidgets(
              fontsize: 15,
              fontWeight: FontWeight.w500,
              text: text,
            ),
            kHeight10,
            Center(
              child: TextFormField(
                onTap: onTapFunction,
                keyboardType: keyboardType,
                validator: validator,
                controller: textfromController,
                readOnly: readOnly,
                maxLines: maxLines,
                maxLength: maxLength,
                decoration: InputDecoration(
                  hintText: hintText,
                  contentPadding: EdgeInsets.all(10.h),
                  isDense: true,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
