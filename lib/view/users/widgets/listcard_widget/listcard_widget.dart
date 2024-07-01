// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ListTileCardWidget extends StatelessWidget {
  ListTileCardWidget({
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    super.key,
  });

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 8),
        onTap: onTap,
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
      ),
    );
  }
}
