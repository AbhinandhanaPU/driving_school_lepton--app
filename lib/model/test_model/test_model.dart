// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TestModel {
  String testDate;
  String testTime;
  String location;
  String docId;
  TestModel({
    required this.testDate,
    required this.testTime,
    required this.location,
    required this.docId,
  });

  TestModel copyWith({
    String? testDate,
    String? testTime,
    String? location,
    String? docId,
  }) {
    return TestModel(
      testDate: testDate ?? this.testDate,
      testTime: testTime ?? this.testTime,
      location: location ?? this.location,
      docId: docId ?? this.docId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'testDate': testDate,
      'testTime': testTime,
      'location': location,
      'docId': docId,
    };
  }

  factory TestModel.fromMap(Map<String, dynamic> map) {
    return TestModel(
      testDate: map['testDate'] ??"",
      testTime: map['testTime'] ??"",
      location: map['location'] ??"",
      docId: map['docId'] ??"",
    );
  }

  String toJson() => json.encode(toMap());

  factory TestModel.fromJson(String source) => TestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TestModel(testDate: $testDate, testTime: $testTime, location: $location, docId: $docId)';
  }

  @override
  bool operator ==(covariant TestModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.testDate == testDate &&
      other.testTime == testTime &&
      other.location == location &&
      other.docId == docId;
  }

  @override
  int get hashCode {
    return testDate.hashCode ^
      testTime.hashCode ^
      location.hashCode ^
      docId.hashCode;
  }
}
