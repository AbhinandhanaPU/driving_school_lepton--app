// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// NoticeModel noticeModelFromJson(String str) =>
//     NoticeModel.fromJson(json.decode(str));

// String noticeModelToJson(NoticeModel data) =>
//     json.encode(data.toJson());

class NoticeModel {
  String publishedDate;
  String subject;
  String heading;
  String signedBy;
  String noticeId;
  NoticeModel({
    required this.publishedDate,
    required this.subject,
    required this.heading,
    required this.signedBy,
    required this.noticeId,
  });

  NoticeModel copyWith({
    String? publishedDate,
    String? subject,
    String? heading,
    String? signedBy,
    String? noticeId,
  }) {
    return NoticeModel(
      publishedDate: publishedDate ?? this.publishedDate,
      subject: subject ?? this.subject,
      heading: heading ?? this.heading,
      signedBy: signedBy ?? this.signedBy,
      noticeId: noticeId ?? this.noticeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'publishedDate': publishedDate,
      'subject': subject,
      'heading': heading,
      'signedBy': signedBy,
      'noticeId': noticeId,
    };
  }

  factory NoticeModel.fromMap(Map<String, dynamic> map) {
    return NoticeModel(
      publishedDate: map['publishedDate'] ?? "",
      subject: map['subject'] ?? "",
      heading: map['heading'] ?? "",
      signedBy: map['signedBy'] ?? "",
      noticeId: map['noticeId'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory NoticeModel.fromJson(String source) =>
      NoticeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NoticeModel(publishedDate: $publishedDate, subject: $subject, heading: $heading, signedBy: $signedBy, noticeId: $noticeId)';
  }

  @override
  bool operator ==(covariant NoticeModel other) {
    if (identical(this, other)) return true;

    return other.publishedDate == publishedDate &&
        other.subject == subject &&
        other.heading == heading &&
        other.signedBy == signedBy &&
        other.noticeId == noticeId;
  }

  @override
  int get hashCode {
    return publishedDate.hashCode ^
        subject.hashCode ^
        heading.hashCode ^
        signedBy.hashCode ^
        noticeId.hashCode;
  }
}
