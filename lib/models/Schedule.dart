// ignore_for_file: file_names

import 'dart:convert';
import 'package:proyecto_moviles/enums/days.dart';
import 'package:proyecto_moviles/enums/hours.dart';

Schedule scheduleFromJson(String str) => Schedule.fromJson(json.decode(str));
String scheduleToJson(Schedule data) => json.encode(data.toJson());

class Schedule {
  int? id;
  List<ScheduleDetail> detail;

  Schedule({
    this.id,
    required this.detail,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        detail: List<ScheduleDetail>.from(json["detail"].map((x) => ScheduleDetail.fromJson(x))),
    );

  Map<String, dynamic> toJson() => {
        "id": id,
        "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
    };
}

class ScheduleDetail {
  DayEnum day;
  HoursEnum hours;

  ScheduleDetail({
    required this.day,
    required this.hours,
  });

  factory ScheduleDetail.fromJson(Map<String, dynamic> json) => ScheduleDetail(
        day: dayEnumFromString[json["day"]]!,
        hours: hoursEnumFromString[json["hours"]]!,
    );

  Map<String, dynamic> toJson() => {
        "day": dayEnumValues[day],
        "hours": hoursEnumValues[hours],
    };
}
