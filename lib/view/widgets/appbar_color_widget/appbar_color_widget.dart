import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';

class AppBarColorWidget extends StatelessWidget {
  const AppBarColorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: themeColor,
      ),
    );
  }
}
