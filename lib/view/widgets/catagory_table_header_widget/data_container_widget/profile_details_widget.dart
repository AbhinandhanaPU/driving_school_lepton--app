import 'package:flutter/material.dart';
import 'package:new_project_app/constant/responsive.dart';

class ProfileDetailsWidget extends StatelessWidget {
  const ProfileDetailsWidget({
    super.key,
    required this.title,
    required this.content,
  });
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Flexible(
          child: SizedBox(
            width: ResponsiveApp.width / 2,
            child: Text(
              title,
              style: TextStyle(
                fontSize: ResponsiveApp.width * .045,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const Flexible(child: Text(":")),
        SizedBox(
          width: ResponsiveApp.width / 2.5,
          child: Text(
            content,
            style: TextStyle(fontSize: ResponsiveApp.width * .04),
          ),
        ),
      ],
    );
  }
}
