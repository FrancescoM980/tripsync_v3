// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';
import 'dart:io';


class Itinerario {
  int day;
  String hour;
  String title;
  String description;
  String city;
  String type_attraction;
  String image;
  String cost;
  int idSetItinerario;


  Itinerario({
    required this.day,
    required this.hour,
    required this.cost,
    required this.title,
    required this.description,
    required this.city,
    required this.type_attraction,
    required this.image,
    required this.idSetItinerario
  });

  factory Itinerario.fromJson(String str) => Itinerario.fromMap(json.decode(str));

    String toJson() => json.encode(
    {
      "day": day,
      "title": title,
      "description": description,
      "city": city,
      "type_attraction": type_attraction,
      "hour": hour,
      "image": image,
      "cost": cost,

    }
  );

    Map<String, dynamic> toMap() => {
      "day": day,
      "title": title,
      "description": description,
      "city": city,
      "type_attraction": type_attraction,
      "hour": hour,
      "cost": cost,
      "id_set_itinerario": idSetItinerario
    };

  factory Itinerario.fromMap(Map<String, dynamic> json) => Itinerario(
      day: json["day"] ?? json['day'] ?? 0,
      title: json['title'] ?? utf8.decode(json["Title"].runes.toList()),
      description: json['description'] ?? utf8.decode(json["Description"].runes.toList()),
      city: json["city"] ?? '',
      type_attraction: json["type_attraction"] ?? '',
      hour: json['hours'] ?? json['hour'] ?? '',
      image: json['Image'] ?? '',
      idSetItinerario: json['id_set_itinerario'] ?? 0,
      cost: json['cost'] ?? (utf8.decode(json["Cost"].runes.toList()).isEmpty ? 'Gratis' : utf8.decode(json["Cost"].runes.toList())),
  );

}
