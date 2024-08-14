import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';

class AttendanceHomePage extends StatelessWidget {
  const AttendanceHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
        backgroundColor: cblue,
      ),
      body: Center(
        child: ElevatedButton.icon(
            onPressed: () {}, icon: Icon(Icons.back_hand_rounded), label: Text("Attendance")),
      ),
    );
  }
}
