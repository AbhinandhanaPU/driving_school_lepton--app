import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

String stringTimeToDateConvert(String date) {
  //String dateandtime convert to "dd-mm-yyyy" this format
  try {
    final DateTime dateFormat = DateTime.parse(date);
    return "${dateFormat.day}-${dateFormat.month}-${dateFormat.year}";
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  return '';
}

String timeConvert(DateTime date) {
  try {
    String formattedTime = DateFormat('hh:mm:a').format(date);
    return formattedTime;
  } catch (e) {
    // Handle any potential errors
    if (kDebugMode) {
      print('Error converting time: $e');
    }
  }
  return '';
}

String? checkFieldEmpty(String? fieldContent) {
  //<-- add String? as a return type
  if (fieldContent == null || fieldContent.isEmpty) {
    return "Field is mandatory";
  }
  return null;
}

String? checkFieldEmailIsValid(String? fieldContent) {
  if (fieldContent == null) {
    return 'null';
  }
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  final result = (regex.hasMatch(fieldContent)) ? true : false;
  if (result) {
    return null;
  } else {
    return "Email is not valid";
  }
}

String? checkFieldPhoneNumberIsValid(String? fieldContent) {
  if (fieldContent == null) {
    return 'null';
  }
  if (fieldContent.length >= 10) {
    return null;
  } else {
    return 'Please enter 10 digit number';
  }
}

String? checkFieldPasswordIsValid(String? fieldContent) {
  if (fieldContent == null) {
    return 'null';
  }
  if (fieldContent.length >= 6) {
    return null;
  } else {
    return 'Minimum 6 Charaters is required';
  }
}

String? checkFieldDateIsValid(String? fieldContent) {
  if (fieldContent == null) {
    return 'null';
  }
  // Define a regular expression pattern to match a date in the "dd-mm-yyyy" format
  String pattern = r'^\d{2}-\d{2}-\d{4}$';
  RegExp regex = RegExp(pattern);

  if (regex.hasMatch(fieldContent)) {
    // If the date matches the pattern, further validate it for valid date values.
    try {
      final parts = fieldContent.split('-');
      final day = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      final year = int.tryParse(parts[2]);
      if (day != null && month != null && year != null) {
        final date = DateTime(year, month, day);
        if (date.year == year && date.month == month && date.day == day) {
          return null; // Valid date
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  return 'Date is not valid (dd-mm-yyyy)';
}

String? checkFieldTimeIsValid(String? fieldContent) {
  if (fieldContent == null) {
    return 'null';
  }
  // Define a regular expression pattern to match a time in the "h:mm am/pm" format
  String pattern = r'^(0?[1-9]|1[0-2]):[0-5][0-9] (am|pm)$';
  RegExp regex = RegExp(pattern, caseSensitive: false);

  if (regex.hasMatch(fieldContent)) {
    // If the time matches the pattern, further validate it for valid time values.
    try {
      final parts = fieldContent.split(' ');
      final timeParts = parts[0].split(':');
      final hour = int.tryParse(timeParts[0]);
      final minute = int.tryParse(timeParts[1]);
      final period = parts[1].toLowerCase();

      if (hour != null && minute != null) {
        if (hour >= 1 && hour <= 12 && minute >= 0 && minute <= 59) {
          if (period == 'am' || period == 'pm') {
            return null; // Valid time
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  return 'Time is not valid (h:mm am/pm)';
}

Future<String> timePicker(BuildContext context) async {
  TimeOfDay? time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (time != null) {
    final now = DateTime.now();
    final formattedTime = DateFormat("h:mm a")
        .format(DateTime(now.year, now.month, now.day, time.hour, time.minute));
    return formattedTime;
  } else {
    return '';
  }
}
