// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';


class TransactionInfo {
  int userId;
  String nickname;
  int transactionId;


  TransactionInfo({
    required this.userId,
    required this.nickname,
    required this.transactionId
  });

  factory TransactionInfo.fromJson(String str) => TransactionInfo.fromMap(json.decode(str));

  String toJson() => json.encode(
    {
      "transaction_id": transactionId,
      "nickname": nickname,
      "user_id": userId,
    }
  );

  factory TransactionInfo.fromMap(Map<String, dynamic> json) => TransactionInfo(
      userId: json["user_id"],
      nickname: json["nickname"],
      transactionId: json["transaction_id"]
  );

  Map<String, dynamic> toMap() => {
      "transaction_id": transactionId,
      "nickname": nickname,
      "user_id": userId,
      };

  
}
