// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';


class CountryImage {
  int id;
  String country;
  String imgUrl;


  CountryImage({
    required this.id,
    required this.country,
    required this.imgUrl
  });

  factory CountryImage.fromJson(String str) => CountryImage.fromMap(json.decode(str));

  String toJson() => json.encode(
    {
      "id": id,
      "country": country,
      "img_url": imgUrl,
    }
  );

  factory CountryImage.fromMap(Map<String, dynamic> json) => CountryImage(
      id: json["id"],
      imgUrl: json["img_url"],
      country: json["country"]
  );

  Map<String, dynamic> toMap() => {
      "id": id,
      "country": country,
      "img_url": imgUrl
      };
}
