// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';


class UserGroupModel {
  int userId;
  int groupId;
  String nickname;
  String email;
  String? fcmToken;
  bool? isAcceptedGroup;
  bool chatNotification;
  bool acceptGroupNotification;
  bool insertChoiceNotification;
  bool walletNotification;
  bool calendarNotification;
  bool infoNotification;
  bool invitationGroupNotification;
  bool showChecklist;
  String? pathImage;
  UserGroupModel({
    required this.userId,
    required this.groupId,
    required this.nickname,
    required this.email,
    this.fcmToken,
    this.isAcceptedGroup,
    required this.chatNotification,
    required this.acceptGroupNotification,
    required this.insertChoiceNotification,
    required this.walletNotification,
    required this.calendarNotification,
    required this.infoNotification,
    required this.invitationGroupNotification,
    required this.showChecklist,
    this.pathImage
  });

  factory UserGroupModel.fromJson(String str) => UserGroupModel.fromMap(json.decode(str));

  String toJson() => json.encode(
    {
      "id_user": userId,
      "id_group": groupId,
      "nickname": nickname,
      "email": email,
      "fcm_token": fcmToken
    }
  );

  factory UserGroupModel.fromMap(Map<String, dynamic> json) => UserGroupModel(
      userId: json["id_user"],
      groupId: json["id_group"],
      nickname: json["nickname"],
      email: json['email'],
      fcmToken: json['fcm_token'],
      isAcceptedGroup: json['is_accepted_group'],
      chatNotification: json['chat_notification'],
      acceptGroupNotification: json['accept_group_notification'],
      insertChoiceNotification: json['insert_choice_notification'],
      walletNotification: json['wallet_notification'],
      calendarNotification: json['calendar_notification'],
      infoNotification: json['info_notification'],
      invitationGroupNotification: json['invitation_group_notification'],
      showChecklist: json["show_checklist"],
      pathImage: json['path_image']
  );

  Map<String, dynamic> toMap() => {
      "id_user": userId,
      "id_group": groupId,
      "nickname": nickname,
      "email": email,
      "fcm_token": fcmToken
      };

  static UserGroupModel? getUser(List<UserGroupModel> users, int userId) {
    UserGroupModel? user;

    for (UserGroupModel uTmp in users) {
      if (uTmp.userId == userId) {
        user = uTmp;
      } 
    }
    return user;
  }
}
