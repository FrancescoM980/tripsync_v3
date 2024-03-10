// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';
import 'dart:io';


class Destination {
  int id;
  String title;
  String description;
  List<dynamic> travelType;
  bool alternative;
  int compatibility;
  int groupId;
  String urlImage;
  int createdBy;
  String createdAt;


  Destination({
    required this.id,
    required this.title,
    required this.description,
    required this.travelType,
    required this.alternative,
    required this.compatibility,
    required this.groupId,
    required this.urlImage,
    required this.createdBy,
    required this.createdAt,
  });

  factory Destination.fromJson(String str) => Destination.fromMap(json.decode(str));

  String toJson() => json.encode(
    {
      "title": title,
      "description": description,
      "travel_type": travelType,
      "alternative": alternative,
      "compatibility": compatibility,
      "id": id,
    }
  );

  factory Destination.fromMap(Map<String, dynamic> json) => Destination(
      id: json['id'] ?? 0,
      title: (json["title"].contains('Ã') ? utf8.decode(json["title"].runes.toList()) : json['title']).replaceAll(' - ', ', ').split(', ').length > 1
        ? '${(json["title"].contains('Ã') ? utf8.decode(json["title"].runes.toList()) : json['title']).replaceAll(' - ', ', ').split(', ').first}, ${(json["title"].contains('Ã') ? utf8.decode(json["title"].runes.toList()) : json['title']).replaceAll(' - ', ', ').split(', ').last}'
        : (json["title"].contains('Ã') ? utf8.decode(json["title"].runes.toList()) : json['title']).replaceAll(' - ', ', '),
      description: json["description"].contains('Ã') ? utf8.decode(json["description"].runes.toList()) : json['description'],
      travelType: json["travel_type"] ?? '',
      alternative: json["alternative"] ?? '',
      compatibility: json["compatibility"] ?? 0,
      groupId: json['id_group'] ?? 0,
      createdAt: json['created_at'] ?? '',
      createdBy: json['created_by'] ?? 0,
      urlImage: json['urlImage'] ?? ''
  );

  Map<String, dynamic> toMap() => {
      "title": title,
      "description": description,
      "travel_type": travelType,
      "alternative": alternative,
      "compatibility": compatibility
      };
}
