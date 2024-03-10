// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';
import 'dart:io';


class DestinationLike {
  int id;
  int destinationId;
  int userId;
  bool isLike;
  bool isDislike;


  DestinationLike({
    required this.id,
    required this.destinationId,
    required this.userId,
    required this.isLike,
    required this.isDislike,
    
  });

  factory DestinationLike.fromJson(String str) => DestinationLike.fromMap(json.decode(str));

  String toJson() => json.encode(
    {
      "id": id,
      "id_destination": destinationId,
      "id_user": userId,
      "is_like": isLike,
      "is_dislike": isDislike
    }
  );

  factory DestinationLike.fromMap(Map<String, dynamic> json) => DestinationLike(
      id: json['id'] ?? 0,
      destinationId: json['id_destination'],
      userId: json['id_user'],
      isLike: json['is_like'],
      isDislike: json['is_dislike']
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "id_destination": destinationId,
    "id_user": userId,
    "is_like": isLike,
    "is_dislike": isDislike
      };
}
