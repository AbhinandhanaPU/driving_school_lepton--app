// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Optionswidget extends StatelessWidget {
  final Question question;
  final ValueChanged<Option> onclickOption;
  const Optionswidget({super.key, required this.question, required this.onclickOption});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: question.options
              .asMap()
              .entries
              .map((entry) => buildOption(context, entry.key, entry.value))
              .toList(),
        ),
      );
  Widget buildOption(BuildContext context, int index, Option option) {
    final color = getColorForOption(option, question);
    return GestureDetector(
      onTap: () => onclickOption(option),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: color),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${index + 1}. ${option.text}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              getIconForOption(option, question)
            ],
          ),
        ),
      ),
    );
  }
}

class Question {
  final String text;
  final List<Option> options;
  bool isLocked;
  Option? selectedOption;
  Question({
    required this.text,
    required this.options,
    this.isLocked = false,
    this.selectedOption,
  });
}

class Option {
  final String text;
  final bool isCorrect;
  Option({
    required this.text,
    required this.isCorrect,
  });
}

final question = [
  Question(text: 'what is actually electricity ?', options: [
    Option(text: 'A Flow of water ', isCorrect: false),
    Option(text: 'A Flow of air ', isCorrect: false),
    Option(text: 'A Flow of electrons ', isCorrect: true),
    Option(text: 'A Flow of atom ', isCorrect: false),
  ]),
  Question(text: 'what is actually electricity ?', options: [
    Option(text: 'A Flow of water ', isCorrect: false),
    Option(text: 'A Flow of air ', isCorrect: false),
    Option(text: 'A Flow of electrons ', isCorrect: true),
    Option(text: 'A Flow of atom ', isCorrect: false),
  ]),
  Question(text: 'what is actually electricity ?', options: [
    Option(text: 'A Flow of water ', isCorrect: false),
    Option(text: 'A Flow of air ', isCorrect: false),
    Option(text: 'A Flow of electrons ', isCorrect: true),
    Option(text: 'A Flow of atom ', isCorrect: false),
  ]),
];

Color getColorForOption(Option option, Question question) {
  final isSelected = option == question.selectedOption;
  if (question.isLocked) {
    if (isSelected) {
      return option.isCorrect ? Colors.green : Colors.red;
    } else if (option.isCorrect) {
      return Colors.green;
    }
    return Colors.grey.shade300;
  } else {
    return Colors.transparent;
  }
}

Widget getIconForOption(Option option, Question question) {
  final isSelected = option == question.selectedOption;
  if (question.isLocked) {
    if (isSelected) {
      return option.isCorrect
          ? Icon(
              Icons.check_circle,
              color: Colors.green,
            )
          : Icon(
              Icons.cancel,
              color: Colors.red,
            );
    } else if (option.isCorrect) {
      return Icon(
        Icons.check_circle,
        color: Colors.green,
      );
    }
    return SizedBox.shrink();
  } else {
    return SizedBox.shrink();
  }
}
