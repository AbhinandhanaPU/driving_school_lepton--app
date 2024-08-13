import 'dart:math';

import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/mock_test/admin_side/model/questionModel.dart';
import 'package:new_project_app/view/mock_test/user/model/moctest_questionnair.dart';

class QuizTestAdminSideController extends GetxController {
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

  List<MockQuestionAnswerModel> userQuestionAnsList = [];
  // Future<MockQuestionAnswerModel> userQuesAnsResult(
  //     MockQuestionAnswerModel data) async {
  //   userQuestionAnsList.add(data);
  //   return data;
  // }
}
