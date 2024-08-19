// ignore_for_file: file_names

import 'dart:convert';
import 'package:proyecto_moviles/enums/type.dart';
import 'package:proyecto_moviles/enums/status.dart';

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));
String bookingToJson(Booking data) => json.encode(data.toJson());

class Booking {
  int id;
  DateTime date;
  String courseId;
  String labId;
  int scheduleId;
  TypeEnum type;
  StatusEnum state;
  String? info;

  Booking({
    required this.id,
    required this.date,
    required this.courseId,
    required this.labId,
    required this.scheduleId,
    required this.type,
    required this.state,
    this.info,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        courseId: json["courseId"],
        labId: json["labId"],
        scheduleId: json["scheduleId"],
        type: typeEnumFromString[json["type"]]!,
        state: statusEnumFromString[json["state"]]!,
        info: json["info"],
    );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "courseId": courseId,
        "labId": labId,
        "scheduleId": scheduleId,
        "type": typeEnumValues[type],
        "state": statusEnumValues[state],
        "info": info,
    };
}