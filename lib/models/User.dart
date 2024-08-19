// ignore_for_file: file_names

import 'dart:convert';
import 'package:proyecto_moviles/enums/role.dart';

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
        fullName: json["fullName"],
        imageUrl: json["imageUrl"],
        email: json["email"],
        role: roleEnumFromString[json["role"]]!,
        isActive: json["isActive"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        lastSignIn: DateTime.parse(json["lastSignIn"]),
    );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "imageUrl": imageUrl,
        "email": email,
        "role": roleEnumValues[role],
        "isActive": isActive,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "lastSignIn": lastSignIn.toIso8601String(),
    };
}


