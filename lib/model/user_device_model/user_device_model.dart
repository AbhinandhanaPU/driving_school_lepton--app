// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserDeviceIDModel {
  String devideID;
  String docId;
  String userRole;
  UserDeviceIDModel({
    required this.devideID,
    required this.docId,
    required this.userRole,
  });

  UserDeviceIDModel copyWith({
    String? devideID,
    String? docId,
    String? userRole,
  }) {
    return UserDeviceIDModel(
      devideID: devideID ?? this.devideID,
      docId: docId ?? this.docId,
      userRole: userRole ?? this.userRole,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'devideID': devideID,
      'docId': docId,
      'userRole': userRole,
    };
  }

  factory UserDeviceIDModel.fromMap(Map<String, dynamic> map) {
    return UserDeviceIDModel(
      devideID: map['devideID'] as String,
      docId: map['docId'] as String,
      userRole: map['userRole'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDeviceIDModel.fromJson(String source) =>
      UserDeviceIDModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserDeviceIDModel(devideID: $devideID, docId: $docId, userRole: $userRole)';

  @override
  bool operator ==(covariant UserDeviceIDModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.devideID == devideID &&
      other.docId == docId &&
      other.userRole == userRole;
  }

  @override
  int get hashCode => devideID.hashCode ^ docId.hashCode ^ userRole.hashCode;
}
