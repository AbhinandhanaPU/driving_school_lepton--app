// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class QuizTestQuestionModel {
  String docid;
  String question;
  String answerID;
  String? imageID;
  bool? imageQuestion;
  QuizTestQuestionModel({
    required this.docid,
    required this.question,
    required this.answerID,
    this.imageID,
    this.imageQuestion,
  });

  QuizTestQuestionModel copyWith({
    String? docid,
    String? question,
    String? answerID,
    String? imageID,
    bool? imageQuestion,
  }) {
    return QuizTestQuestionModel(
      docid: docid ?? this.docid,
      question: question ?? this.question,
      answerID: answerID ?? this.answerID,
      imageID: imageID ?? this.imageID,
      imageQuestion: imageQuestion ?? this.imageQuestion,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docid': docid,
      'question': question,
      'answerID': answerID,
      'imageID': imageID,
      'imageQuestion': imageQuestion,
    };
  }

  factory QuizTestQuestionModel.fromMap(Map<String, dynamic> map) {
    return QuizTestQuestionModel(
      docid: map['docid'] ??'',
      question: map['question'] ??'',
      answerID: map['answerID'] ??'',
      imageID: map['imageID'] != null ? map['imageID'] ??'' : null,
      imageQuestion: map['imageQuestion'] != null ? map['imageQuestion'] ?? false : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizTestQuestionModel.fromJson(String source) => QuizTestQuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuizTestQuestionModel(docid: $docid, question: $question, answerID: $answerID, imageID: $imageID, imageQuestion: $imageQuestion)';
  }

  @override
  bool operator ==(covariant QuizTestQuestionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docid == docid &&
      other.question == question &&
      other.answerID == answerID &&
      other.imageID == imageID &&
      other.imageQuestion == imageQuestion;
  }

  @override
  int get hashCode {
    return docid.hashCode ^
      question.hashCode ^
      answerID.hashCode ^
      imageID.hashCode ^
      imageQuestion.hashCode;
  }
}
