import 'package:flutter/material.dart';

class AlertNotifierSetup {
  final Color whiteshadeColor = const Color.fromARGB(255, 243, 105, 96);
  final Color containerColor = const Color.fromARGB(255, 240, 68, 56);
  final IconData icon = Icons.priority_high;
}

class WarningNotifierSetup {
  final Color whiteshadeColor = const Color.fromARGB(255, 249, 166, 58);
  final Color containerColor = const Color.fromARGB(255, 247, 144, 9);
  final IconData icon = Icons.warning_amber_outlined;
}

class SuccessNotifierSetup {
  final Color whiteshadeColor = const Color.fromARGB(255, 18, 183, 106);
  final Color containerColor = Colors.green;
  final IconData icon = Icons.task_alt;
}

class InfoNotifierSetup {
  Color whiteshadeColor = const Color.fromARGB(255, 63, 162, 232);
  Color containerColor = const Color.fromARGB(255, 4, 130, 225);
  final IconData icon = Icons.info_outline_rounded;
}

class CardNotifierSetup {
  final Color whiteshadeColor = const Color.fromARGB(255, 74, 6, 94);
  final Color containerColor = const Color.fromARGB(255, 163, 34, 249);
  final IconData icon = Icons.info_outline_rounded;
}
