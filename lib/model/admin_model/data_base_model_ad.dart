// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddAdminModel {
  String docid;
  String country;
  String state;
  String city;
  String password;
  String adminEmail;
  String username;
  String schoolCode;
  String schoolName;
  String phoneNumber;
  String schoolLicenceNumber;
  String address;
  String place;
  String designation;
  String profileImageId;
  String profileImageUrl;
  String createdDate;
  bool verified;
  AddAdminModel({
    required this.docid,
    required this.country,
    required this.state,
    required this.city,
    required this.password,
    required this.adminEmail,
    required this.username,
    required this.schoolCode,
    required this.schoolName,
    required this.phoneNumber,
    required this.schoolLicenceNumber,
    required this.address,
    required this.place,
    required this.designation,
    required this.profileImageId,
    required this.profileImageUrl,
    required this.createdDate,
    required this.verified,
  });

  AddAdminModel copyWith({
    String? docid,
    String? country,
    String? state,
    String? city,
    String? password,
    String? adminEmail,
    String? username,
    String? schoolCode,
    String? schoolName,
    String? phoneNumber,
    String? schoolLicenceNumber,
    String? address,
    String? place,
    String? designation,
    String? profileImageId,
    String? profileImageUrl,
    String? createdDate,
    bool? verified,
  }) {
    return AddAdminModel(
      docid: docid ?? this.docid,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      password: password ?? this.password,
      adminEmail: adminEmail ?? this.adminEmail,
      username: username ?? this.username,
      schoolCode: schoolCode ?? this.schoolCode,
      schoolName: schoolName ?? this.schoolName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      schoolLicenceNumber: schoolLicenceNumber ?? this.schoolLicenceNumber,
      address: address ?? this.address,
      place: place ?? this.place,
      designation: designation ?? this.designation,
      profileImageId: profileImageId ?? this.profileImageId,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdDate: createdDate ?? this.createdDate,
      verified: verified ?? this.verified,
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
      'username': username,
      'schoolCode': schoolCode,
      'schoolName': schoolName,
      'phoneNumber': phoneNumber,
      'schoolLicenceNumber': schoolLicenceNumber,
      'address': address,
      'place': place,
      'designation': designation,
      'profileImageId': profileImageId,
      'profileImageUrl': profileImageUrl,
      'createdDate': createdDate,
      'verified': verified,
    };
  }

  factory AddAdminModel.fromMap(Map<String, dynamic> map) {
    return AddAdminModel(
      docid: map['docid'] ??"",
      country: map['country'] ??"",
      state: map['state'] ??"",
      city: map['city'] ??"",
      password: map['password'] ??"",
      adminEmail: map['adminEmail'] ??"",
      username: map['username'] ??"",
      schoolCode: map['schoolCode'] ??"",
      schoolName: map['schoolName'] ??"",
      phoneNumber: map['phoneNumber'] ??"",
      schoolLicenceNumber: map['schoolLicenceNumber'] ??"",
      address: map['address'] ??"",
      place: map['place'] ??"",
      designation: map['designation'] ??"",
      profileImageId: map['profileImageId'] ??"",
      profileImageUrl: map['profileImageUrl'] ??"",
      createdDate: map['createdDate'] ??"",
      verified: map['verified'] ??false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddAdminModel.fromJson(String source) => AddAdminModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddAdminModel(docid: $docid, country: $country, state: $state, city: $city, password: $password, adminEmail: $adminEmail, username: $username, schoolCode: $schoolCode, schoolName: $schoolName, phoneNumber: $phoneNumber, schoolLicenceNumber: $schoolLicenceNumber, address: $address, place: $place, designation: $designation, profileImageId: $profileImageId, profileImageUrl: $profileImageUrl, createdDate: $createdDate, verified: $verified)';
  }

  @override
  bool operator ==(covariant AddAdminModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docid == docid &&
      other.country == country &&
      other.state == state &&
      other.city == city &&
      other.password == password &&
      other.adminEmail == adminEmail &&
      other.username == username &&
      other.schoolCode == schoolCode &&
      other.schoolName == schoolName &&
      other.phoneNumber == phoneNumber &&
      other.schoolLicenceNumber == schoolLicenceNumber &&
      other.address == address &&
      other.place == place &&
      other.designation == designation &&
      other.profileImageId == profileImageId &&
      other.profileImageUrl == profileImageUrl &&
      other.createdDate == createdDate &&
      other.verified == verified;
  }

  @override
  int get hashCode {
    return docid.hashCode ^
      country.hashCode ^
      state.hashCode ^
      city.hashCode ^
      password.hashCode ^
      adminEmail.hashCode ^
      username.hashCode ^
      schoolCode.hashCode ^
      schoolName.hashCode ^
      phoneNumber.hashCode ^
      schoolLicenceNumber.hashCode ^
      address.hashCode ^
      place.hashCode ^
      designation.hashCode ^
      profileImageId.hashCode ^
      profileImageUrl.hashCode ^
      createdDate.hashCode ^
      verified.hashCode;
  }
}
