// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';
import 'dart:io';


class AirbnbHotel {
  String id;
  String urlAirbnb;
  int position;
  String neighborhood;
  String name;
  dynamic bathrooms;
  dynamic bedrooms;
  dynamic beds;
  String city;
  List<dynamic> images;
  String hostImage;
  bool isSuperHost;
  dynamic persons;
  dynamic reviewsCount;
  dynamic rating;
  String typeRental;
  String address;
  List<dynamic> benefitList;
  dynamic total;
  String currency;
  List<dynamic> detailPayment;
   

  AirbnbHotel({
    required this.id,
    required this.neighborhood,
    required this.urlAirbnb,
    required this.position,
    required this.name,
    required this.bathrooms,
    required this.bedrooms,
    required this.beds,
    required this.city,
    required this.images,
    required this.hostImage,
    required this.isSuperHost,
    required this.persons,
    required this.reviewsCount,
    required this.rating,
    required this.typeRental,
    required this.address,
    required this.benefitList,
    required this.total,
    required this.currency,
    required this.detailPayment,
  });

  factory AirbnbHotel.fromJson(String str) => AirbnbHotel.fromMap(json.decode(str));


  factory AirbnbHotel.fromMap(Map<String, dynamic> json) => AirbnbHotel(
      id: json["id"],
      neighborhood: json['neighborhood'] ?? 'Sconosciuto',
      urlAirbnb: json["deeplink"],
      position: json["position"],
      name: json["name"],
      bathrooms: json["bathrooms"],
      bedrooms: json["bedrooms"],
      beds: json["beds"],
      city: json["city"],
      images: json["images"],
      hostImage: json["hostThumbnail"],
      isSuperHost: json["isSuperhost"],
      persons: json["persons"],
      reviewsCount: json["reviewsCount"],
      rating: json["rating"],
      typeRental: json["type"],
      address: json["address"],
      benefitList: json["amenityIds"],
      total: json["price"]["total"],
      currency: json["price"]["currency"],
      detailPayment: json["price"]["priceItems"],
  );
}
