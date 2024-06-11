import 'dart:convert';

class StudentModel {
  String docid;
  String password;
  String studentemail;
  String studentName;
  String phoneNumber;
  String dateofBirth;
  String guardianName;
  String address;
  String place;
  String profileImageId;
  String profileImageUrl;
  String rtoName;
  String licenceNumber;

  String userRole = 'student';

  StudentModel({
    required this.docid,
    required this.password,
    required this.studentemail,
    required this.studentName,
    required this.phoneNumber,
    required this.dateofBirth,
    required this.guardianName,
    required this.address,
    required this.place,
    required this.profileImageId,
    required this.profileImageUrl,
    required this.rtoName,
    required this.licenceNumber,
    required this.userRole,
  });

  StudentModel copyWith({
    String? docid,
    String? password,
    String? studentemail,
    String? studentName,
    String? phoneNumber,
    String? dateofBirth,
    String? guardianName,
    String? address,
    String? place,
    String? profileImageId,
    String? profileImageUrl,
    String? rtoName,
    String? licenceNumber,
    String? userRole,
  }) {
    return StudentModel(
      docid: docid ?? this.docid,
      password: password ?? this.password,
      studentemail: studentemail ?? this.studentemail,
      studentName: studentName ?? this.studentName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateofBirth: dateofBirth ?? this.dateofBirth,
      guardianName: guardianName ?? this.guardianName,
      address: address ?? this.address,
      place: place ?? this.place,
      profileImageId: profileImageId ?? this.profileImageId,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      rtoName: rtoName ?? this.rtoName,
      licenceNumber: licenceNumber ?? this.licenceNumber,
      userRole: userRole ?? this.userRole,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docid': docid,
      'password': password,
      'studentemail': studentemail,
      'studentName': studentName,
      'phoneNumber': phoneNumber,
      'dateofBirth': dateofBirth,
      'guardianName': guardianName,
      'address': address,
      'place': place,
      'profileImageId': profileImageId,
      'profileImageUrl': profileImageUrl,
      'rtoName': rtoName,
      'licenceNumber': licenceNumber,
      'userRole': userRole,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      docid: map['docid'] as String,
      password: map['password'] as String,
      studentemail: map['studentemail'] as String,
      studentName: map['studentName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      dateofBirth: map['dateofBirth'] as String,
      guardianName: map['guardianName'] as String,
      address: map['address'] as String,
      place: map['place'] as String,
      profileImageId: map['profileImageId'] as String,
      profileImageUrl: map['profileImageUrl'] as String,
      rtoName: map['rtoName'] as String,
      licenceNumber: map['licenceNumber'] as String,
      userRole: map['userRole'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentModel.fromJson(String source) =>
      StudentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StudentModel(docid: $docid, password: $password, studentemail: $studentemail, studentName: $studentName, phoneNumber: $phoneNumber, dateofBirth: $dateofBirth, guardianName: $guardianName, address: $address, place: $place, profileImageId: $profileImageId, profileImageUrl: $profileImageUrl, rtoName: $rtoName, licenceNumber: $licenceNumber, userRole: $userRole)';
  }

  @override
  bool operator ==(covariant StudentModel other) {
    if (identical(this, other)) return true;

    return other.docid == docid &&
        other.password == password &&
        other.studentemail == studentemail &&
        other.studentName == studentName &&
        other.phoneNumber == phoneNumber &&
        other.dateofBirth == dateofBirth &&
        other.guardianName == guardianName &&
        other.address == address &&
        other.place == place &&
        other.profileImageId == profileImageId &&
        other.profileImageUrl == profileImageUrl &&
        other.rtoName == rtoName &&
        other.licenceNumber == licenceNumber &&
        other.userRole == userRole;
  }

  @override
  int get hashCode {
    return docid.hashCode ^
        password.hashCode ^
        studentemail.hashCode ^
        studentName.hashCode ^
        phoneNumber.hashCode ^
        dateofBirth.hashCode ^
        guardianName.hashCode ^
        address.hashCode ^
        place.hashCode ^
        profileImageId.hashCode ^
        profileImageUrl.hashCode ^
        rtoName.hashCode ^
        licenceNumber.hashCode ^
        userRole.hashCode;
  }
}
