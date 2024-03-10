// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';
import 'dart:io';


class LogError {
  int id;
  String username;
  String info;
  String errorMessage;
  String errorCode;
  String versionApp;
  String createdAt;
  bool isRead;


  LogError({
    required this.id,
    required this.username,
    required this.info,
    required this.errorMessage,
    required this.errorCode,
    required this.versionApp,
    required this.createdAt,
    required this.isRead
  });

  factory LogError.fromJson(String str) => LogError.fromMap(json.decode(str));

  String toJson() => json.encode(
    {
      "id": id,
      "username": username,
      "info": info,
      "error_message": errorMessage,
      "error_code": errorCode,
      "version_app": versionApp,
      "created_at": createdAt
    }
  );

  factory LogError.fromMap(Map<String, dynamic> json) => LogError(
      id: json["id"] ?? 0,
      username: json["username"] ?? '',
      info: json["info"] ?? '',
      errorMessage: json["error_message"] ?? '',
      errorCode: json["error_code"] ?? '',
      versionApp: json["version_app"] ?? '',
      createdAt: json["created_at"] ?? '',
      isRead: json['is_read'] ?? false
  );

  Map<String, dynamic> toMap() => {
      "id": id,
      "username": username,
      "info": info,
      "error_message": errorMessage,
      "error_code": errorCode,
      "version_app": versionApp,
      "created_at": createdAt,
      };
}
