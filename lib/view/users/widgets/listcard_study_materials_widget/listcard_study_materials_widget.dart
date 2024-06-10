import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';

class ListileCardStudyMaterialsWidget extends StatelessWidget {
  const ListileCardStudyMaterialsWidget({
    required this.leading,
    required this.title,
    required this.subtitle,
    this.trailing,
    super.key,
  });

  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        shape: const BeveledRectangleBorder(side: BorderSide(color: cWhite)),
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
      ),
    );
  }
}
