// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AdminModel {
  String docid;
  String country;
  String state;
  String city;
  String password;
  String adminEmail;
  String adminName;
  String schoolCode;
  String schoolName;
  String phoneNumber;
  String schoolLicenceNumber;
  String address;
  String place;
  String designation;
  String profileImageId;
  String profileImageUrl;

  String userRole = 'admin';

  AdminModel({
    required this.docid,
    required this.country,
    required this.state,
    required this.city,
    required this.password,
    required this.adminEmail,
    required this.adminName,
    required this.schoolCode,
    required this.schoolName,
    required this.phoneNumber,
    required this.schoolLicenceNumber,
    required this.address,
    required this.place,
    required this.designation,
    required this.profileImageId,
    required this.profileImageUrl,
    required this.userRole,
  });

  AdminModel copyWith({
    String? docid,
    String? country,
    String? state,
    String? city,
    String? password,
    String? adminEmail,
    String? adminName,
    String? schoolCode,
    String? schoolName,
    String? phoneNumber,
    String? schoolLicenceNumber,
    String? address,
    String? place,
    String? designation,
    String? profileImageId,
    String? profileImageUrl,
    String? userRole,
  }) {
    return AdminModel(
      docid: docid ?? this.docid,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      password: password ?? this.password,
      adminEmail: adminEmail ?? this.adminEmail,
      adminName: adminName ?? this.adminName,
      schoolCode: schoolCode ?? this.schoolCode,
      schoolName: schoolName ?? this.schoolName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      schoolLicenceNumber: schoolLicenceNumber ?? this.schoolLicenceNumber,
      address: address ?? this.address,
      place: place ?? this.place,
      designation: designation ?? this.designation,
      profileImageId: profileImageId ?? this.profileImageId,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      userRole: userRole ?? this.userRole,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docid': docid,
      'country': country,
      'state': state,
      'city': city,
      'password': password,
      'adminEmail': adminEmail,
      'adminName': adminName,
      'schoolCode': schoolCode,
      'schoolName': schoolName,
      'phoneNumber': phoneNumber,
      'schoolLicenceNumber': schoolLicenceNumber,
      'address': address,
      'place': place,
      'designation': designation,
      'profileImageId': profileImageId,
      'profileImageUrl': profileImageUrl,
      'userRole': userRole,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      docid: map['docid'] as String,
      country: map['country'] as String,
      state: map['state'] as String,
      city: map['city'] as String,
      password: map['password'] as String,
      adminEmail: map['adminEmail'] as String,
      adminName: map['adminName'] as String,
      schoolCode: map['schoolCode'] as String,
      schoolName: map['schoolName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      schoolLicenceNumber: map['schoolLicenceNumber'] as String,
      address: map['address'] as String,
      place: map['place'] as String,
      designation: map['designation'] as String,
      profileImageId: map['profileImageId'] as String,
      profileImageUrl: map['profileImageUrl'] as String,
      userRole: map['userRole'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminModel.fromJson(String source) =>
      AdminModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AdminModel(docid: $docid, country: $country, state: $state, city: $city, password: $password, adminEmail: $adminEmail, adminName: $adminName, schoolCode: $schoolCode, schoolName: $schoolName, phoneNumber: $phoneNumber, schoolLicenceNumber: $schoolLicenceNumber, address: $address, place: $place, designation: $designation, profileImageId: $profileImageId, profileImageUrl: $profileImageUrl, userRole: $userRole)';
  }

  @override
  bool operator ==(covariant AdminModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docid == docid &&
      other.country == country &&
      other.state == state &&
      other.city == city &&
      other.password == password &&
      other.adminEmail == adminEmail &&
      other.adminName == adminName &&
      other.schoolCode == schoolCode &&
      other.schoolName == schoolName &&
      other.phoneNumber == phoneNumber &&
      other.schoolLicenceNumber == schoolLicenceNumber &&
      other.address == address &&
      other.place == place &&
      other.designation == designation &&
      other.profileImageId == profileImageId &&
      other.profileImageUrl == profileImageUrl &&
      other.userRole == userRole;
  }

  @override
  int get hashCode {
    return docid.hashCode ^
      country.hashCode ^
      state.hashCode ^
      city.hashCode ^
      password.hashCode ^
      adminEmail.hashCode ^
      adminName.hashCode ^
      schoolCode.hashCode ^
      schoolName.hashCode ^
      phoneNumber.hashCode ^
      schoolLicenceNumber.hashCode ^
      address.hashCode ^
      place.hashCode ^
      designation.hashCode ^
      profileImageId.hashCode ^
      profileImageUrl.hashCode ^
      userRole.hashCode;
  }
}
