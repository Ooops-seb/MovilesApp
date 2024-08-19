// ignore_for_file: file_names

import 'dart:convert';

Laboratory laboratoryFromJson(String str) => Laboratory.fromJson(json.decode(str));
String laboratoryToJson(Laboratory data) => json.encode(data.toJson());

class Laboratory {
  String id;
  String name;
  String? info;

  Laboratory({
    required this.id,
    required this.name,
    this.info,
  });

  factory Laboratory.fromJson(Map<String, dynamic> json) => Laboratory(
        id: json["id"],
        name: json["name"],
        info: json["info"],
    );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "info": info,
    };
}
