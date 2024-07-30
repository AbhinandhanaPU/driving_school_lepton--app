import 'dart:convert';

class UserDeviceIDModel {
  String uid;
  String devideID;
  String schoolID;
  String userrole;
  UserDeviceIDModel({
    required this.uid,
    required this.devideID,
    required this.schoolID,
    required this.userrole,
  });

  UserDeviceIDModel copyWith({
    String? uid,
    String? batchID,
    String? classID,
    String? devideID,
    String? schoolID,
    String? userrole,
  }) {
    return UserDeviceIDModel(
      uid: uid ?? this.uid,
      devideID: devideID ?? this.devideID,
      schoolID: schoolID ?? this.schoolID,
      userrole: userrole ?? this.userrole,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'devideID': devideID,
      'schoolID': schoolID,
      'userrole': userrole,
    };
  }

  factory UserDeviceIDModel.fromMap(Map<String, dynamic> map) {
    return UserDeviceIDModel(
      uid: map['uid'] ?? '',
      devideID: map['devideID'] ?? '',
      schoolID: map['schoolID'] ?? '',
      userrole: map['userrole'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDeviceIDModel.fromJson(String source) =>
      UserDeviceIDModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserDeviceIDModel(uid: $uid, devideID: $devideID, schoolID: $schoolID, userrole: $userrole)';
  }

  @override
  bool operator ==(covariant UserDeviceIDModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.devideID == devideID &&
        other.schoolID == schoolID &&
        other.userrole == userrole;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        devideID.hashCode ^
        schoolID.hashCode ^
        userrole.hashCode;
  }
}
