import 'package:flutter/material.dart';

customMessageDialogBox(
    {required BuildContext context,
    required String message,
    required void Function()? onPressed}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Message'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: onPressed,
          ),
        ],
      );
    },
  );
}
