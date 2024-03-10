// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';


class Checklist {
  int id;
  String description;
  int groupId;
  int userId;
  bool status;
  String createdAt;

  Checklist({
    required this.id,
    required this.description,
    required this.groupId,
    required this.userId,
    required this.status,
    required this.createdAt
  });

  factory Checklist.fromJson(String str) => Checklist.fromMap(json.decode(str));

  String toJson() => json.encode(
    {
      "id": id,
      "description": description,
      "group_id": groupId,
      "user_id": userId,
      "status": status,
      "created_at": createdAt
    }
  );

  factory Checklist.fromMap(Map<String, dynamic> json) => Checklist(
      id: json["id"],
      description: json["description"],
      groupId: json["group_id"],
      userId: json["user_id"],
      status: json["status"],
      createdAt: json["created_at"]
  );

  Map<String, dynamic> toMap() => {
      "id": id,
      "description": description,
      "group_id": groupId,
      "user_id": userId,
      "status": status,
      };
}
