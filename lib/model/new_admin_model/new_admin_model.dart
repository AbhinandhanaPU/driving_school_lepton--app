// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AdminDetailsModel {
  String docid;
  String username;
  String email;
  String phoneNumber;
  bool active;

  AdminDetailsModel({
    required this.docid,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.active,
  });

  AdminDetailsModel copyWith({
    String? docid,
    String? username,
    String? email,
    String? phoneNumber,
    bool? active,
  }) {
    return AdminDetailsModel(
      docid: docid ?? this.docid,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docid': docid,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'active': active,
    };
  }

  factory AdminDetailsModel.fromMap(Map<String, dynamic> map) {
    return AdminDetailsModel(
      docid: map['docid'] ??"",
      username: map['username'] ??"",
      email: map['email'] ??"",
      phoneNumber: map['phoneNumber'] ??"",
      active: map['active'] ??false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminDetailsModel.fromJson(String source) => AdminDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AdminDetailsModel(docid: $docid, username: $username, email: $email, phoneNumber: $phoneNumber, active: $active)';
  }

  @override
  bool operator ==(covariant AdminDetailsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docid == docid &&
      other.username == username &&
      other.email == email &&
      other.phoneNumber == phoneNumber &&
      other.active == active;
  }

  @override
  int get hashCode {
    return docid.hashCode ^
      username.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      active.hashCode;
  }
}
