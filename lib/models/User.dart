// ignore_for_file: file_names

import 'dart:convert';
import 'package:proyecto_moviles/enums/role.dart';
import 'package:date_time_format/date_time_format.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  String id;
  String fullName;
  String imageUrl;
  String email;
  RoleEnum role;
  bool isActive;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime lastSignIn;

  User({
    required this.id,
    required this.fullName,
    required this.imageUrl,
    required this.email,
    required this.role,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.lastSignIn,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["full_name"],
        imageUrl: json["image_url"],
        email: json["email"],
        role: roleEnumFromString[json["role"]]!,
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        lastSignIn: DateTime.parse(json["last_sign_in"]),
    );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "image_url": imageUrl,
        "email": email,
        "role": roleEnumValues[role],
        "is_active": isActive,
        "created_at": DateTimeFormat.format(createdAt, format: r'Y-m-d\TH:i:s'),
        "updated_at": DateTimeFormat.format(updatedAt, format: r'Y-m-d\TH:i:s'),
        "last_sign_in": DateTimeFormat.format(lastSignIn, format: r'Y-m-d\TH:i:s')
    };
}