import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
 

class CatrgoryTableHeaderWidget extends StatelessWidget {
  final String headerTitle;
  final double? width;

  const CatrgoryTableHeaderWidget({
    this.width,
    required this.headerTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: width,
      decoration: const BoxDecoration(
          color:  Colors.blue,
          border: Border.symmetric(
            horizontal: BorderSide(color: Colors.blue),
          )),
      child: Center(
        child: Text(
          headerTitle,
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: cWhite,
              decoration: TextDecoration.none),
        ),
      ),
    );
  }
}

class CatrgoryTableHeaderColorWidget extends StatelessWidget {
  final String headerTitle;
  final double? width;
  final Color color;
  final Color textcolor;

  const CatrgoryTableHeaderColorWidget({
    this.width,
    required this.headerTitle,
    required this.color,
    required this.textcolor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: width,
      decoration: BoxDecoration(
          color: color,
          border: const Border.symmetric(
              // horizontal: BorderSide(color: Colors.blue),
              )),
      child: Center(
        child: Text(
          headerTitle,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 13, color: textcolor),
        ),
      ),
    );
  }
}
