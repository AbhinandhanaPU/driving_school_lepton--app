import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';

class StudentsAttendenceListViewScreen extends StatelessWidget {
  final String date;
  final String month;

  const StudentsAttendenceListViewScreen({
    required this.date,
    required this.month,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance List'.tr),
        flexibleSpace: const AppBarColorWidget(),
        foregroundColor: cWhite,
      ),
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              color: Colors.green.withOpacity(0.4),
              height: 40,
              width: double.infinity,
              child: Center(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('${index + 1}'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      " studentName",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(' - Pr')
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: 4,
        ),
      ),
    );
  }
}
