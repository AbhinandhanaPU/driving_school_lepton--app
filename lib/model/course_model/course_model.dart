// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CourseModel {
  String courseName;
  String courseDes;
  String tutor;
  String duration;
  String rate;
  String courseId;
  CourseModel({
    required this.courseName,
    required this.courseDes,
    required this.tutor,
    required this.duration,
    required this.rate,
    required this.courseId,
  });

  CourseModel copyWith({
    String? courseName,
    String? courseDes,
    String? tutor,
    String? duration,
    String? rate,
    String? courseId,
  }) {
    return CourseModel(
      courseName: courseName ?? this.courseName,
      courseDes: courseDes ?? this.courseDes,
      tutor: tutor ?? this.tutor,
      duration: duration ?? this.duration,
      rate: rate ?? this.rate,
      courseId: courseId ?? this.courseId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'courseName': courseName,
      'courseDes': courseDes,
      'tutor': tutor,
      'duration': duration,
      'rate': rate,
      'courseId': courseId,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      courseName: map['courseName'] as String,
      courseDes: map['courseDes'] as String,
      tutor: map['tutor'] as String,
      duration: map['duration'] as String,
      rate: map['rate'] as String,
      courseId: map['courseId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CourseModel(courseName: $courseName, courseDes: $courseDes, tutor: $tutor, duration: $duration, rate: $rate, courseId: $courseId)';
  }

  @override
  bool operator ==(covariant CourseModel other) {
    if (identical(this, other)) return true;

    return other.courseName == courseName &&
        other.courseDes == courseDes &&
        other.tutor == tutor &&
        other.duration == duration &&
        other.rate == rate &&
        other.courseId == courseId;
  }

  @override
  int get hashCode {
    return courseName.hashCode ^
        courseDes.hashCode ^
        tutor.hashCode ^
        duration.hashCode ^
        rate.hashCode ^
        courseId.hashCode;
  }
}
