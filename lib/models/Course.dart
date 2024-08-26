// ignore_for_file: file_names

import 'dart:convert';

Course courseFromJson(String str) => Course.fromJson(json.decode(str));
String courseToJson(Course data) => json.encode(data.toJson());

class Course {
  int id;
  String name;
  String userId;
  String info;

  Course({
    required this.id,
    required this.name,
    required this.userId,
    required this.info,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        name: json["name"],
        userId: json["user_id"],
        info: json["info"],
    );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_id": userId,
        "info": info,
    };
}