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
  String joiningDate;
  String status; //

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
    required this.joiningDate,
    required this.status,
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
    String? joiningDate,
    String? status,
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
      joiningDate: joiningDate ?? this.joiningDate,
      status: status ?? this.status,
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
      'joiningDate': joiningDate,
      'status': status,
      'userRole': userRole,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      docid: map['docid'] ?? "",
      password: map['password'] ?? "",
      studentemail: map['studentemail'] ?? "",
      studentName: map['studentName'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      dateofBirth: map['dateofBirth'] ?? "",
      guardianName: map['guardianName'] ?? "",
      address: map['address'] ?? "",
      place: map['place'] ?? "",
      profileImageId: map['profileImageId'] ?? "",
      profileImageUrl: map['profileImageUrl'] ?? "",
      rtoName: map['rtoName'] ?? "",
      licenceNumber: map['licenceNumber'] ?? "",
      joiningDate: map['joiningDate'] ?? "",
      status: map['status'] ?? "",
      userRole: map['userRole'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentModel.fromJson(String source) =>
      StudentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StudentModel(docid: $docid, password: $password, studentemail: $studentemail, studentName: $studentName, phoneNumber: $phoneNumber, dateofBirth: $dateofBirth, guardianName: $guardianName, address: $address, place: $place, profileImageId: $profileImageId, profileImageUrl: $profileImageUrl, rtoName: $rtoName, licenceNumber: $licenceNumber, joiningDate: $joiningDate, status: $status, userRole: $userRole)';
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
        other.joiningDate == joiningDate &&
        other.status == status &&
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
        joiningDate.hashCode ^
        status.hashCode ^
        userRole.hashCode;
  }
}
