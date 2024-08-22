// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddTeacherModel {
   String? uid;
  String? teacherName;
  String? gender;
  String? admissionNumber;
  String? teacherEmail;
  String? phoneNumber;
  String? houseName;
  String? place;
  String? district;
  String? alPhoneNumber;
  String? profileImageId;
  String? profileImageUrl;
  String? createDate;
  String? bloodgroup;
  String? dateofBirth;
  String? docid;
  String userRole;
  AddTeacherModel({
    this.uid,
    this.teacherName,
    this.gender,
    this.admissionNumber,
    this.teacherEmail,
    this.phoneNumber,
    this.houseName,
    this.place,
    this.district,
    this.alPhoneNumber,
    this.profileImageId,
    this.profileImageUrl,
    this.createDate,
    this.bloodgroup,
    this.dateofBirth,
    this.docid,
    required this.userRole,
  });

  AddTeacherModel copyWith({
    String? uid,
    String? teacherName,
    String? gender,
    String? admissionNumber,
    String? teacherEmail,
    String? phoneNumber,
    String? houseName,
    String? place,
    String? district,
    String? alPhoneNumber,
    String? profileImageId,
    String? profileImageUrl,
    String? createDate,
    String? bloodgroup,
    String? dateofBirth,
    String? docid,
    String? userRole,
  }) {
    return AddTeacherModel(
      uid: uid ?? this.uid,
      teacherName: teacherName ?? this.teacherName,
      gender: gender ?? this.gender,
      admissionNumber: admissionNumber ?? this.admissionNumber,
      teacherEmail: teacherEmail ?? this.teacherEmail,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      houseName: houseName ?? this.houseName,
      place: place ?? this.place,
      district: district ?? this.district,
      alPhoneNumber: alPhoneNumber ?? this.alPhoneNumber,
      profileImageId: profileImageId ?? this.profileImageId,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createDate: createDate ?? this.createDate,
      bloodgroup: bloodgroup ?? this.bloodgroup,
      dateofBirth: dateofBirth ?? this.dateofBirth,
      docid: docid ?? this.docid,
      userRole: userRole ?? this.userRole,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'teacherName': teacherName,
      'gender': gender,
      'admissionNumber': admissionNumber,
      'teacherEmail': teacherEmail,
      'phoneNumber': phoneNumber,
      'houseName': houseName,
      'place': place,
      'district': district,
      'alPhoneNumber': alPhoneNumber,
      'profileImageId': profileImageId,
      'profileImageUrl': profileImageUrl,
      'createDate': createDate,
      'bloodgroup': bloodgroup,
      'dateofBirth': dateofBirth,
      'docid': docid,
      'userRole': userRole,
    };
  }

  factory AddTeacherModel.fromMap(Map<String, dynamic> map) {
    return AddTeacherModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      teacherName: map['teacherName'] != null ? map['teacherName'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      admissionNumber: map['admissionNumber'] != null ? map['admissionNumber'] as String : null,
      teacherEmail: map['teacherEmail'] != null ? map['teacherEmail'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      houseName: map['houseName'] != null ? map['houseName'] as String : null,
      place: map['place'] != null ? map['place'] as String : null,
      district: map['district'] != null ? map['district'] as String : null,
      alPhoneNumber: map['alPhoneNumber'] != null ? map['alPhoneNumber'] as String : null,
      profileImageId: map['profileImageId'] != null ? map['profileImageId'] as String : null,
      profileImageUrl: map['profileImageUrl'] != null ? map['profileImageUrl'] as String : null,
      createDate: map['createDate'] != null ? map['createDate'] as String : null,
      bloodgroup: map['bloodgroup'] != null ? map['bloodgroup'] as String : null,
      dateofBirth: map['dateofBirth'] != null ? map['dateofBirth'] as String : null,
      docid: map['docid'] != null ? map['docid'] as String : null,
      userRole: map['userRole'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddTeacherModel.fromJson(String source) => AddTeacherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddTeacherModel(uid: $uid, teacherName: $teacherName, gender: $gender, admissionNumber: $admissionNumber, teacherEmail: $teacherEmail, phoneNumber: $phoneNumber, houseName: $houseName, place: $place, district: $district, alPhoneNumber: $alPhoneNumber, profileImageId: $profileImageId, profileImageUrl: $profileImageUrl, createDate: $createDate, bloodgroup: $bloodgroup, dateofBirth: $dateofBirth, docid: $docid, userRole: $userRole)';
  }

  @override
  bool operator ==(covariant AddTeacherModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.teacherName == teacherName &&
      other.gender == gender &&
      other.admissionNumber == admissionNumber &&
      other.teacherEmail == teacherEmail &&
      other.phoneNumber == phoneNumber &&
      other.houseName == houseName &&
      other.place == place &&
      other.district == district &&
      other.alPhoneNumber == alPhoneNumber &&
      other.profileImageId == profileImageId &&
      other.profileImageUrl == profileImageUrl &&
      other.createDate == createDate &&
      other.bloodgroup == bloodgroup &&
      other.dateofBirth == dateofBirth &&
      other.docid == docid &&
      other.userRole == userRole;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      teacherName.hashCode ^
      gender.hashCode ^
      admissionNumber.hashCode ^
      teacherEmail.hashCode ^
      phoneNumber.hashCode ^
      houseName.hashCode ^
      place.hashCode ^
      district.hashCode ^
      alPhoneNumber.hashCode ^
      profileImageId.hashCode ^
      profileImageUrl.hashCode ^
      createDate.hashCode ^
      bloodgroup.hashCode ^
      dateofBirth.hashCode ^
      docid.hashCode ^
      userRole.hashCode;
  }
}
