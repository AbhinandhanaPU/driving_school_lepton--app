// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// NoticeModel noticeModelFromJson(String str) =>
//     NoticeModel.fromJson(json.decode(str));

// String noticeModelToJson(NoticeModel data) =>
//     json.encode(data.toJson());

class PracticeSheduleModel {
  String practiceName;
  String startTime;
  String endTime;
  String practiceId;

  PracticeSheduleModel({
    required this.practiceName,
    required this.startTime,
    required this.endTime,
    required this.practiceId,
  });

  PracticeSheduleModel copyWith(
      {String? practiceName, String? startTime, String? endTime, String? practiceId}) {
    return PracticeSheduleModel(
      practiceName: practiceName ?? this.practiceName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      practiceId: practiceId ?? this.practiceId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'practiceName': practiceName,
      'startTime': startTime,
      'endTime': endTime,
      'practiceId': practiceId,
    };
  }

  factory PracticeSheduleModel.fromMap(Map<String, dynamic> map) {
    return PracticeSheduleModel(
        practiceName: map['practiceName'] ?? "",
        startTime: map['startTime'] ?? "",
        endTime: map['endTime'] ?? "",
        practiceId: map['practiceId']);
  }

  String toJson() => json.encode(toMap());

  factory PracticeSheduleModel.fromJson(String source) =>
      PracticeSheduleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PracticeSheduleModel(practiceName: $practiceName, startTime: $startTime, endTime: $endTime,practiceId$practiceId';
  }

  @override
  bool operator ==(covariant PracticeSheduleModel other) {
    if (identical(this, other)) return true;

    return other.practiceName == practiceName &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.practiceId == practiceId;
  }

  @override
  int get hashCode {
    return practiceName.hashCode ^ startTime.hashCode ^ endTime.hashCode^practiceId.hashCode;
  }
}
