// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CourseModel {
  String courseName;
  String courseDes;
  String duration;
  String rate;
  String courseId;

  CourseModel({
    required this.courseName,
    required this.courseDes,
    required this.duration,
    required this.rate,
    required this.courseId,
  });

  CourseModel copyWith({
    String? courseName,
    String? courseDes,
    String? duration,
    String? rate,
    String? courseId,
  }) {
    return CourseModel(
      courseName: courseName ?? this.courseName,
      courseDes: courseDes ?? this.courseDes,
      duration: duration ?? this.duration,
      rate: rate ?? this.rate,
      courseId: courseId ?? this.courseId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'courseName': courseName,
      'courseDes': courseDes,
      'duration': duration,
      'rate': rate,
      'courseId': courseId,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    // Convert each field to a String to handle type mismatches
    return CourseModel(
      courseName: map['courseName']?.toString() ?? "",
      courseDes: map['courseDes']?.toString() ?? "",
      duration: map['duration']?.toString() ?? "",
      rate: map['rate']?.toString() ?? "",
      courseId: map['courseId']?.toString() ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CourseModel(courseName: $courseName, courseDes: $courseDes, duration: $duration, rate: $rate, courseId: $courseId)';
  }

  @override
  bool operator ==(covariant CourseModel other) {
    if (identical(this, other)) return true;

    return other.courseName == courseName &&
        other.courseDes == courseDes &&
        other.duration == duration &&
        other.rate == rate &&
        other.courseId == courseId;
  }

  @override
  int get hashCode {
    return courseName.hashCode ^
        courseDes.hashCode ^
        duration.hashCode ^
        rate.hashCode ^
        courseId.hashCode;
  }
}
