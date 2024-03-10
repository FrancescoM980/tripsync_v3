// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';
import 'dart:io';


class Attraction {
  int id;
  String title;
  String description;
  String city;
  String type_attraction;


  Attraction({
    required this.id,
    required this.title,
    required this.description,
    required this.city,
    required this.type_attraction,
  });

  factory Attraction.fromJson(String str) => Attraction.fromMap(json.decode(str));

  String toJson() => json.encode(
    {
      "id": id,
      "title": title,
      "description": description,
      "city": city,
      "type_attraction": type_attraction,
    }
  );

  factory Attraction.fromMap(Map<String, dynamic> json) => Attraction(
      id: json["id"] ?? 0,
      title: json["title"] ?? '',
      description: json["description"] ?? '',
      city: json["city"] ?? '',
      type_attraction: json["type_attraction"] ?? '',
  );

  Map<String, dynamic> toMap() => {
      "id": id,
      "title": title,
      "description": description,
      "city": city,
      "type_attraction": type_attraction,
      };
}
