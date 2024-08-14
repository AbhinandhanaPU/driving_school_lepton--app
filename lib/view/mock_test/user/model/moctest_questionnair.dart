// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:new_project_app/controller/mock_test/admin_side/model/questionModel.dart';

class MockQuestionAnswerModel {
  bool lockoption;
  String selectedOption;
  int questionNo;
  bool ansIsTrue;
  QuizTestQuestionModel dataModel;
  MockQuestionAnswerModel({
    required this.lockoption,
    required this.selectedOption,
    required this.questionNo,
    required this.ansIsTrue,
    required this.dataModel,
  });

  MockQuestionAnswerModel copyWith({
    bool? lockoption,
    String? selectedOption,
    int? questionNo,
    bool? ansIsTrue,
    QuizTestQuestionModel? dataModel,
  }) {
    return MockQuestionAnswerModel(
      lockoption: lockoption ?? this.lockoption,
      selectedOption: selectedOption ?? this.selectedOption,
      questionNo: questionNo ?? this.questionNo,
      ansIsTrue: ansIsTrue ?? this.ansIsTrue,
      dataModel: dataModel ?? this.dataModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lockoption': lockoption,
      'selectedOption': selectedOption,
      'questionNo': questionNo,
      'ansIsTrue': ansIsTrue,
      'dataModel': dataModel.toMap(),
    };
  }

  factory MockQuestionAnswerModel.fromMap(Map<String, dynamic> map) {
    return MockQuestionAnswerModel(
      lockoption: map['lockoption'] as bool,
      selectedOption: map['selectedOption'] as String,
      questionNo: map['questionNo'] as int,
      ansIsTrue: map['ansIsTrue'] as bool,
      dataModel: QuizTestQuestionModel.fromMap(map['dataModel'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory MockQuestionAnswerModel.fromJson(String source) =>
      MockQuestionAnswerModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MockQuestionAnswerModel(lockoption: $lockoption, selectedOption: $selectedOption, questionNo: $questionNo, ansIsTrue: $ansIsTrue, dataModel: $dataModel)';
  }

  @override
  bool operator ==(covariant MockQuestionAnswerModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.lockoption == lockoption &&
      other.selectedOption == selectedOption &&
      other.questionNo == questionNo &&
      other.ansIsTrue == ansIsTrue &&
      other.dataModel == dataModel;
  }

  @override
  int get hashCode {
    return lockoption.hashCode ^
      selectedOption.hashCode ^
      questionNo.hashCode ^
      ansIsTrue.hashCode ^
      dataModel.hashCode;
  }
}
