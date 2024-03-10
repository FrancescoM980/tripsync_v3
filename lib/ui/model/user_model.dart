// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';


class UserModel {
  int id;
  String nickname;
  String email;
  String phone;
  String prefix;
  String? name;
  String? surname;
  String? sesso;
  String? birthday;
  String createdAt;
  String? fcmToken;
  bool adminRole;
  bool chatNotification;
  bool acceptGroupNotification;
  bool insertChoiceNotification;
  bool walletNotification;
  bool calendarNotification;
  bool infoNotification;
  bool invitationGroupNotification;
  String? pathImage;
  UserModel({
    required this.id,
    required this.nickname,
    required this.email,
    required this.phone,
    required this.createdAt,
    required this.prefix,
    this.name,
    this.surname,
    this.birthday,
    this.sesso,
    this.fcmToken,
    required this.adminRole,
    required this.chatNotification,
    required this.acceptGroupNotification,
    required this.insertChoiceNotification,
    required this.walletNotification,
    required this.calendarNotification,
    required this.infoNotification,
    required this.invitationGroupNotification,
    this.pathImage
  });

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(
    {
      "id": id,
      "nickname": nickname,
      "email": email,
      "phone": phone,
      "prefix_phone": phone,
      "name": name,
      "surname": surname,
      "data_di_nascita": birthday,
      "sesso": sesso,
      "created_at": createdAt,
      "fcm_token": fcmToken,
    }
  );

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      nickname: json["nickname"],
      email: json["email"],
      phone: json["phone"],
      prefix: json["prefix_phone"],
      name: json['name'],
      birthday: json["data_di_nascita"],
      surname: json['surname'],
      sesso: json['sesso'],
      createdAt: json["created_at"],
      fcmToken: json["fcm_token"],
      adminRole: json['admin_role'],
      chatNotification: json['chat_notification'],
      acceptGroupNotification: json['accept_group_notification'],
      insertChoiceNotification: json['insert_choice_notification'],
      walletNotification: json['wallet_notification'],
      calendarNotification: json['calendar_notification'],
      infoNotification: json['info_notification'],
      invitationGroupNotification: json['invitation_group_notification'],
      pathImage: json['path_image']
  );

  Map<String, dynamic> toMap() => {
      "id": id,
      "nickname": nickname,
      "email": email,
      "phone": phone,
      "sesso": sesso,
      "surname": surname,
      "name": name,
      "data_di_nascita": birthday,
      "created_at": createdAt,
      "fcm_token": fcmToken
      };
}
