// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';



class Document {
  int id;
  int groupId;
  String? urlImage;
  String createdAt;
  int ownerId;
  bool status;
  String type;
  String? publicUrlImage;
  bool isGroupImage;
  Document({
    required this.id,
    required this.groupId,
    required this.urlImage,
    required this.createdAt,
    required this.ownerId,
    required this.status,
    required this.type,
    required this.isGroupImage
  });

  factory Document.fromJson(String str) => Document.fromMap(json.decode(str));

  String toJson() => json.encode(
    {
      "id": id,
      "id_group": groupId,
      "url_image": urlImage,
      "created_at": createdAt,
      "owner_id": ownerId,
      "status": status,
      "type": type
    }
  );

  factory Document.fromMap(Map<String, dynamic> json) => Document(
      id: json["id"],
      groupId: json["id_group"],
      urlImage: json["url_image"],
      createdAt: json["created_at"],
      ownerId: json["owner_id"],
      status: json["status"],
      type: json["type"],
      isGroupImage: json['is_group_image']
  );

  Map<String, dynamic> toMap() => {
      "id": id,
      "id_group": groupId,
      "url_image": urlImage,
      "created_at": createdAt,
      "owner_id": ownerId,
      "status": status,
      "type": type
      };
}
