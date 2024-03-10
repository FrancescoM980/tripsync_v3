// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';


class NotificationUserModel {
  int id;
  String message;
  String title;
  String actionType;
  int groupId;
  String groupTitle;
  int senderId;
  String senderNickname;
  int receiverId;
  bool isRead;
  DateTime createdAt;


  NotificationUserModel({
    required this.id,
    required this.message,
    required this.title,
    required this.actionType,
    required this.groupId,
    required this.groupTitle,
    required this.senderId,
    required this.senderNickname,
    required this.receiverId,
    required this.isRead,
    required this.createdAt
  });

  factory NotificationUserModel.fromJson(String str) => NotificationUserModel.fromMap(json.decode(str));

  String toJson() => json.encode(
    {
      "id": id,
      "message": message,
      "title": title,
      "action_type": actionType,
      "group_id": groupId,
      "group_title": groupTitle,
      "sender_id": senderId,
      "sender_nickname": senderNickname,
      "receiver_id": receiverId,
      "is_read": isRead,
    }
  );

  factory NotificationUserModel.fromMap(Map<String, dynamic> json) => NotificationUserModel(
    id: json["id"],
    message: json["message"],
    title: json["title"],
    actionType: json["action_type"],
    groupId: json["group_id"],
    groupTitle: json["group_title"],
    senderId: json["sender_id"],
    senderNickname: json["sender_nickname"],
    receiverId: json["receiver_id"],
    isRead: json["is_read"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "title": title,
    "action_type": actionType,
    "group_id": groupId,
    "group_title": groupTitle,
    "sender_id": senderId,
    "sender_nickname": senderNickname,
    "receiver_id": receiverId,
  };
}
