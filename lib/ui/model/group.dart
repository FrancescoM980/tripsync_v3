import 'dart:convert';


class Group {
  int id;
  String title;
  int ownerId;
  String ownerNickname;
  bool isCompleted;
  String? description;
  String? createdAt;
  bool? isAcceptedGroup;
  int people;
  String type;
  String? pathImage;
  bool hasDateLocked;
  bool hasDestinationLocked;
  bool hasGeneratedDestinationFromTripSync;

  Group({
    required this.id,
    required this.isCompleted,
    this.description,
    this.isAcceptedGroup,
    required this.title,
    this.createdAt,
    required this.ownerId,
    required this.ownerNickname,
    required this.people,
    required this.type,
    this.pathImage,
    required this.hasDateLocked,
    required this.hasDestinationLocked,
    required this.hasGeneratedDestinationFromTripSync
  });

  factory Group.fromJson(String str) => Group.fromMap(json.decode(str));

  String toJson() => json.encode({
        "id": id,
        "is_completed": isCompleted,
        "title": title,
        "description": description,
        "is_accepted_group": isAcceptedGroup,
        "created_at": createdAt,
        "owner_id": ownerId,
        "owner_nickname": ownerNickname,
        "people": people,
        "type": type
      });

  factory Group.fromMap(Map<String, dynamic> json) => Group(
        id: json["id"],
        isCompleted: json["is_completed"],
        title: json["title"],
        description: json["description"],
        isAcceptedGroup: json["is_accepted_group"],
        createdAt: json["created_at"],
        ownerId: json["owner_id"],
        ownerNickname: json["owner_nickname"],
        people: json['people'],
        type: json['type'],
        pathImage: json['path_image'],
        hasDateLocked: json["has_date_locked"],
        hasDestinationLocked: json["has_destination_locked"],
        hasGeneratedDestinationFromTripSync: json["has_generated_destination_from_tripsync"]
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "is_completed": isCompleted,
        "title": title,
        "description": description,
        "is_accepted_group": isAcceptedGroup,
        "created_at": createdAt,
        "owner_id": ownerId,
        "owner_nickname": ownerNickname,
        'people': people,
        "type": type
      };
}
