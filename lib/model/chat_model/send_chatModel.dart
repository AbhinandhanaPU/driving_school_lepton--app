// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SendUserStatusModel {
bool? block;
String docid;
int messageindex;
String senderName;
  SendUserStatusModel({
    this.block,
    required this.docid,
    required this.messageindex,
    required this.senderName,
  });

  SendUserStatusModel copyWith({
    bool? block,
    String? docid,
    int? messageindex,
    String? senderName,
  }) {
    return SendUserStatusModel(
      block: block ?? this.block,
      docid: docid ?? this.docid,
      messageindex: messageindex ?? this.messageindex,
      senderName: senderName ?? this.senderName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'block': block,
      'docid': docid,
      'messageindex': messageindex,
      'senderName': senderName,
    };
  }

  factory SendUserStatusModel.fromMap(Map<String, dynamic> map) {
    return SendUserStatusModel(
      block: map['block'] != null ? map['block'] as bool : null,
      docid: map['docid'] as String,
      messageindex: map['messageindex'] as int,
      senderName: map['senderName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendUserStatusModel.fromJson(String source) => SendUserStatusModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SendUserStatusModel(block: $block, docid: $docid, messageindex: $messageindex, senderName: $senderName)';
  }

  @override
  bool operator ==(covariant SendUserStatusModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.block == block &&
      other.docid == docid &&
      other.messageindex == messageindex &&
      other.senderName == senderName;
  }

  @override
  int get hashCode {
    return block.hashCode ^
      docid.hashCode ^
      messageindex.hashCode ^
      senderName.hashCode;
  }
}
