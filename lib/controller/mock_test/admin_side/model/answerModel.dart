// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class QuizTestAnswerModel {
  String docid;
  String options;
  QuizTestAnswerModel({
    required this.docid,
    required this.options,
  });

  QuizTestAnswerModel copyWith({
    String? docid,
    String? options,
  }) {
    return QuizTestAnswerModel(
      docid: docid ?? this.docid,
      options: options ?? this.options,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docid': docid,
      'options': options,
    };
  }

  factory QuizTestAnswerModel.fromMap(Map<String, dynamic> map) {
    return QuizTestAnswerModel(
      docid: map['docid'] ??'',
      options: map['options'] ??'',
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizTestAnswerModel.fromJson(String source) => QuizTestAnswerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'QuizTestAnswerModel(docid: $docid, options: $options)';

  @override
  bool operator ==(covariant QuizTestAnswerModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docid == docid &&
      other.options == options;
  }

  @override
  int get hashCode => docid.hashCode ^ options.hashCode;
}
