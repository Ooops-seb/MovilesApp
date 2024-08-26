// ignore_for_file: file_names

import 'dart:convert';
import 'package:proyecto_moviles/enums/type.dart';
import 'package:proyecto_moviles/enums/status.dart';
import 'package:proyecto_moviles/models/User.dart';
import 'package:proyecto_moviles/models/Course.dart';
import 'package:proyecto_moviles/models/Laboratory.dart';
import 'package:proyecto_moviles/models/Schedule.dart';

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));
String bookingToJson(Booking data) => json.encode(data.toJson());

class Booking {
  int? id;
  DateTime date;
  int courseId;
  String labId;
  int scheduleId;
  TypeEnum type;
  StatusEnum state;
  String? info;
  User? user;
  Course? course;
  Laboratory? laboratory;
  Schedule? schedule;

  Booking({
    this.id,
    required this.date,
    required this.courseId,
    required this.labId,
    required this.scheduleId,
    required this.type,
    required this.state,
    this.info,
    this.user,
    this.course,
    this.laboratory,
    this.schedule,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        courseId: json["course_id"],
        labId: json["lab_id"],
        scheduleId: json["schedule_id"],
        type: typeEnumFromString[json["type"]]!,
        state: statusEnumFromString[json["state"]]!,
        info: json["info"],
        user: null,
        course: null,
        laboratory: null,
        schedule: null,
    );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "course_id": courseId,
        "lab_id": labId,
        "schedule_id": scheduleId,
        "type": typeEnumValues[type],
        "state": statusEnumValues[state],
        "info": info,
    };
}