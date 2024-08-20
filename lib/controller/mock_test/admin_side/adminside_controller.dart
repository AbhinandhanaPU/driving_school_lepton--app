import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/fonts/text_widget.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/mock_test/admin_side/model/questionModel.dart';
import 'package:new_project_app/view/mock_test/user/model/moctest_questionnair.dart';
import 'package:new_project_app/view/widgets/getx_showdilogue/getx_showdilog.dart';

class QuizTestAdminSideController extends GetxController {
  late PageController pgcontroller;
  RxInt initquestionNumber = 1.obs;
  List<QuizTestQuestionModel> getAllQuestionFromServer = [];
  List<QuizTestQuestionModel> selectedQuestions =
      []; // New list for shuffled 20 questions

  Stream<List<QuizTestQuestionModel>> getAllQuestionAndSuffleStream() async* {
    selectedQuestions.clear();
    getAllQuestionFromServer.clear();

    await server
        .collection('DrivingSchoolCollection')
        .doc('Hi2qKeAIvhdpLkTDAgOoNN2AS0z2')
        .collection('MockTestCollection')
        .get()
        .then((value) async {
      final list = value.docs
          .map((e) => QuizTestQuestionModel.fromMap(e.data()))
          .toList();
      getAllQuestionFromServer.addAll(list);

      // Shuffle the list of all questions
      getAllQuestionFromServer.shuffle(Random());

      // Select the first 20 questions
      selectedQuestions = getAllQuestionFromServer.take(20).toList();

      // Yield the selected questions
      selectedQuestions;
    });
  }

  int? selectedOptIndex;
  RxBool optionSelected = false.obs;
  RxBool screenLock = false.obs;

  List<MockQuestionAnswerModel> userQuestionAnsList = [];
  RxInt correctAns = 0.obs;
  RxInt wrongAns = 0.obs;
  var startTimerValue = 30.obs; // Observable for the timer value
  Timer? _timer; // Reference to the Timer object

  void startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (startTimerValue.value > 0) {
        startTimerValue.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel(); // Stop the timer if it's running
  }

  void resetTimer() {
    stopTimer(); // Stop any running timer
    startTimerValue.value = 30; // Reset the value to the initial state
  }

  @override
  void onInit() {
    pgcontroller = PageController(initialPage: 0);
    super.onInit();
  }

  void showResult() {
    getxcustomShowDialogBox(
        title: 'Result',
        children: [
          TextFontWidget(text: "${correctAns}/20", fontsize: 14)
        ],
        doYouWantActionButton: true);
  }
}
