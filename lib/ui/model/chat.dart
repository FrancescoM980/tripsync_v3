// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

class Chat {
  int id;
  int senderId;
  String? senderNick;
  int groupId;
  String? groupName;
  String message;
  DateTime createdAt;
  bool isMine;
  bool? isRead;
  Chat({
    required this.id,
    required this.senderId,
    required this.groupId,
    required this.message,
    required this.createdAt,
    this.senderNick,
    this.groupName,
    required this.isMine,
    this.isRead
  });

  factory Chat.fromJson(String str, int myId) => Chat.fromMap(json.decode(str), myId);
  factory Chat.fromMap(Map<String, dynamic> json, int myId) => Chat(
      id: json["id"],
      senderId: json["sender_id"],
      groupId: json["group_id"],
      groupName: json["group_name"],
      senderNick: json["sender_nickname"],
      message: json["message"],
      createdAt: DateTime.parse(json["created_at"]),
      isMine: myId == json["sender_id"],
  );

  Map<String, dynamic> toMap() => {
      "id": id,
      "sender_id": senderId,
      "group_id": groupId,
      "group_name": groupName,
      "sender_nickname": senderNick,
      "message": message,
      "created_at": createdAt.toIso8601String()
      };
}
