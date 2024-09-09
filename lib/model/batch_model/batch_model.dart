// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BatchModel {
  String batchName;
  String date;
  String batchId;
  BatchModel({
    required this.batchName,
    required this.date,
    required this.batchId,
  });

  BatchModel copyWith({
    String? batchName,
    String? date,
    String? batchId,
  }) {
    return BatchModel(
      batchName: batchName ?? this.batchName,
      date: date ?? this.date,
      batchId: batchId ?? this.batchId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'batchName': batchName,
      'date': date,
      'batchId': batchId,
    };
  }

  factory BatchModel.fromMap(Map<String, dynamic> map) {
    return BatchModel(
      batchName: map['batchName'] ?? "",
      date: map['date'] ?? "",
      batchId: map['batchId'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory BatchModel.fromJson(String source) =>
      BatchModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'BatchModel(batchName: $batchName, date: $date, batchId: $batchId)';

  @override
  bool operator ==(covariant BatchModel other) {
    if (identical(this, other)) return true;

    return other.batchName == batchName &&
        other.date == date &&
        other.batchId == batchId;
  }

  @override
  int get hashCode => batchName.hashCode ^ date.hashCode ^ batchId.hashCode;
}
