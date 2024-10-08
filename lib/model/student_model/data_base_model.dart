// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddStudentModel {
  String? uid;
  String? studentName;
  String? gender;
  String? admissionNumber;
  String? studentemail;
  String? parentPhoneNumber;
  String? classID;
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
  AddStudentModel({
    this.uid,
    this.studentName,
    this.gender,
    this.admissionNumber,
    this.studentemail,
    this.parentPhoneNumber,
    this.classID,
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
    this.userRole='student',
  });

  AddStudentModel copyWith({
    String? uid,
    String? studentName,
    String? gender,
    String? admissionNumber,
    String? studentemail,
    String? parentPhoneNumber,
    String? classID,
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
    return AddStudentModel(
      uid: uid ?? this.uid,
      studentName: studentName ?? this.studentName,
      gender: gender ?? this.gender,
      admissionNumber: admissionNumber ?? this.admissionNumber,
      studentemail: studentemail ?? this.studentemail,
      parentPhoneNumber: parentPhoneNumber ?? this.parentPhoneNumber,
      classID: classID ?? this.classID,
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
      'studentName': studentName,
      'gender': gender,
      'admissionNumber': admissionNumber,
      'studentemail': studentemail,
      'parentPhoneNumber': parentPhoneNumber,
      'classID': classID,
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

  factory AddStudentModel.fromMap(Map<String, dynamic> map) {
    return AddStudentModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      studentName: map['studentName'] != null ? map['studentName'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      admissionNumber: map['admissionNumber'] != null ? map['admissionNumber'] as String : null,
      studentemail: map['studentemail'] != null ? map['studentemail'] as String : null,
      parentPhoneNumber: map['parentPhoneNumber'] != null ? map['parentPhoneNumber'] as String : null,
      classID: map['classID'] != null ? map['classID'] as String : null,
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
      userRole: map['userRole'] ??"",
    );
  }

  String toJson() => json.encode(toMap());

  factory AddStudentModel.fromJson(String source) =>
      AddStudentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddStudentModel(uid: $uid, studentName: $studentName, gender: $gender, admissionNumber: $admissionNumber, studentemail: $studentemail, parentPhoneNumber: $parentPhoneNumber, classID: $classID, houseName: $houseName, place: $place, district: $district, alPhoneNumber: $alPhoneNumber, profileImageId: $profileImageId, profileImageUrl: $profileImageUrl, createDate: $createDate, bloodgroup: $bloodgroup, dateofBirth: $dateofBirth, docid: $docid, userRole: $userRole)';
  }

  @override
  bool operator ==(covariant AddStudentModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.studentName == studentName &&
      other.gender == gender &&
      other.admissionNumber == admissionNumber &&
      other.studentemail == studentemail &&
      other.parentPhoneNumber == parentPhoneNumber &&
      other.classID == classID &&
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
      studentName.hashCode ^
      gender.hashCode ^
      admissionNumber.hashCode ^
      studentemail.hashCode ^
      parentPhoneNumber.hashCode ^
      classID.hashCode ^
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
