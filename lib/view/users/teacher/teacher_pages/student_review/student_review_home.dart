import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';

class StudentReviewHome extends StatelessWidget {
  const StudentReviewHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cblue,
        title: Text('Student Review'),
      ),
      body: Container(
        child: Text('data'),
      ),
    );
  }
}
