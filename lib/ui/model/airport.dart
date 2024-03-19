// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';


class Airport {
  String name;
  String code;

  Airport({
    required this.name,
    required this.code
  });

  factory Airport.fromJson(String str) => Airport.fromMap(json.decode(str));

  String toJson() => json.encode(
    {
      "name": name,
      "code": code
    }
  );

  factory Airport.fromMap(Map<String, dynamic> json) => Airport(
      name: json['name'],
      code: json['code']
  );

  Map<String, dynamic> toMap() => {
      "name": name,
      "code": code
      };
}
