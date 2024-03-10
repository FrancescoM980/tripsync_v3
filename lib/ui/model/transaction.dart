// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

import 'package:tripsync_v3/ui/model/transaction_info.dart';



class Transaction {
  int id;
  String description;
  double value;
  int groupId;
  int userId;
  String nickname;
  String createdAt; 
  String typeTransaction;
  List<TransactionInfo> usersTransaction;


  Transaction({
    required this.id,
    required this.description,
    required this.value,
    required this.groupId,
    required this.userId,
    required this.nickname,
    required this.createdAt,
    required this.typeTransaction,
    required this.usersTransaction
  });

  factory Transaction.fromJson(String str) => Transaction.fromMap(json.decode(str));

  String toJson() => json.encode(
    {
      "id": id,
      "description": description,
      "group_id": groupId,
      "user_id": userId,
    }
  );

  factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
      id: json["id"],
      description: json["description"],
      value: json["value"].toDouble(),
      groupId: json["group_id"],
      userId: json["user_id"],
      nickname: json["nickname"],
      createdAt: json["created_at"],
      typeTransaction: json["type_transaction"],
      usersTransaction: []
  );

  Map<String, dynamic> toMap() => {
      "description": description,
      "value": value,
      "group_id": groupId,
      "user_id": userId,
      "created_at": createdAt,
      "type_transaction": typeTransaction
      };

  
}
