// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EventModel {
   String eventName;
  String eventDate;
  String eventDescription;
  String venue;
  String signedBy;
  String id;
  EventModel({
    required this.eventName,
    required this.eventDate,
    required this.eventDescription,
    required this.venue,
    required this.signedBy,
    required this.id,
  });


  EventModel copyWith({
    String? eventName,
    String? eventDate,
    String? eventDescription,
    String? venue,
    String? signedBy,
    String? id,
  }) {
    return EventModel(
      eventName: eventName ?? this.eventName,
      eventDate: eventDate ?? this.eventDate,
      eventDescription: eventDescription ?? this.eventDescription,
      venue: venue ?? this.venue,
      signedBy: signedBy ?? this.signedBy,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventName': eventName,
      'eventDate': eventDate,
      'eventDescription': eventDescription,
      'venue': venue,
      'signedBy': signedBy,
      'id': id,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      eventName: map['eventName'] ?? "",
      eventDate: map['eventDate'] ?? "",
      eventDescription: map['eventDescription'] ?? "",
      venue: map['venue'] ?? "",
      signedBy: map['signedBy'] ?? "",
      id: map['id'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) => EventModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EventModel(eventName: $eventName, eventDate: $eventDate, eventDescription: $eventDescription, venue: $venue, signedBy: $signedBy, id: $id)';
  }

  @override
  bool operator ==(covariant EventModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.eventName == eventName &&
      other.eventDate == eventDate &&
      other.eventDescription == eventDescription &&
      other.venue == venue &&
      other.signedBy == signedBy &&
      other.id == id;
  }

  @override
  int get hashCode {
    return eventName.hashCode ^
      eventDate.hashCode ^
      eventDescription.hashCode ^
      venue.hashCode ^
      signedBy.hashCode ^
      id.hashCode;
  }
}
