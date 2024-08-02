import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/mock_test/admin_side/model/answerModel.dart';
import 'package:new_project_app/controller/mock_test/admin_side/model/questionModel.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:uuid/uuid.dart';

class QuizTestAdminSideController extends GetxController {
  Future<void> addNewQuestion(
    String question,
  ) async {
    final qdocid = Uuid().v1();
    QuizTestQuestionModel questionModel = QuizTestQuestionModel(
      docid: qdocid,
      imageQuestion: false,
      question: question,
      answerID: '',
    );
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('MockTestCollection')
        .doc(qdocid)
        .set(questionModel.toMap());
  }

  Future<void> addquestionOptions(String questionID) async {
    final optiondocid = Uuid().v1();
    QuizTestAnswerModel answerModel =
        QuizTestAnswerModel(docid: optiondocid, options: 'answer');
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('MockTestCollection')
        .doc(questionID)
        .collection('Options')
        .doc(optiondocid)
        .set(answerModel.toMap());
  }

  Future<void> updateQuestionAnswer(String questionID, String answerID) async {
    final optiondocid = Uuid().v1();
    QuizTestAnswerModel answerModel =
        QuizTestAnswerModel(docid: optiondocid, options: 'answer');
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('MockTestCollection')
        .doc(questionID)
        .collection('Options')
        .doc(optiondocid)
        .set(answerModel.toMap())
        .then((value) async {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('MockTestCollection')
          .doc(questionID)
          .update({'answerID': answerID});
    });
  }
}
