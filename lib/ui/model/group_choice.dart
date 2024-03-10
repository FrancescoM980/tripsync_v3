import 'dart:convert';

import 'package:tripsync_v3/ui/model/dateChoice.dart';

class GroupChoice {
  int id;
  int groupId;
  bool isFinalChoice;
  String createdAt;
  String? countryName;
  String? regionName;
  String? cityName;
  String? addressName;
  String? countryName2;
  String? regionName2;
  String? cityName2;
  String? addressName2;
  String? countryName3;
  String? regionName3;
  String? cityName3;
  String? addressName3;
  List<String>? allDestinations;
  int? budgetStart;
  int? budgetEnd;
  int? budgetHotel;
  int? budgetTrasporti;
  int? budgetSvago;
  List<DateChoice>? dates = [];
  bool status;
  int ownerId;
  String nickname;
  List<String>? adjectives;

  GroupChoice({
    required this.id,
    required this.groupId,
    required this.isFinalChoice,
    required this.createdAt,
    this.dates,
    this.allDestinations,
    this.countryName,
    this.regionName,
    this.cityName,
    this.addressName,
    this.countryName2,
    this.regionName2,
    this.cityName2,
    this.addressName2,
    this.countryName3,
    this.regionName3,
    this.cityName3,
    this.addressName3,
    this.budgetStart,
    this.budgetEnd,
    this.budgetHotel,
    this.budgetSvago,
    this.budgetTrasporti,
    this.adjectives,
    required this.status,
    required this.ownerId,
    required this.nickname,
  });

  factory GroupChoice.fromJson(String str) =>
      GroupChoice.fromMap(json.decode(str));

  String toJson() => json.encode({
        "id": id,
        "id_group": groupId,
        "is_final_choice": isFinalChoice,
        "created_at": createdAt,
        "country_name": countryName,
        "region_name": regionName,
        "city_name": cityName,
        "street_name": addressName,
        "country_name2": countryName2,
        "region_name2": regionName2,
        "city_name2": cityName2,
        "street_name2": addressName2,
        "country_name3": countryName3,
        "region_name3": regionName3,
        "city_name3": cityName3,
        "street_name3": addressName3,
        "budget_start": budgetStart,
        "budget_end": budgetEnd,
        "status": status,
        "owner_id": ownerId,
        "nickname": nickname,
        "all_destinations": allDestinations
      });

  factory GroupChoice.fromMap(Map<String, dynamic> json) => GroupChoice(
        id: json["id"],
        groupId: json["id_group"],
        isFinalChoice: json["is_final_choice"],
        createdAt: json["created_at"],
        countryName: json["country_name"],
        regionName: json["region_name"],
        cityName: json["city_name"],
        addressName: json["street_name"],
        countryName2: json["country_name2"],
        regionName2: json["region_name2"],
        cityName2: json["city_name2"],
        addressName2: json["street_name2"],
        countryName3: json["country_name3"],
        regionName3: json["region_name3"],
        cityName3: json["city_name3"],
        addressName3: json["street_name3"],
        budgetStart: json["budget_start"],
        budgetEnd: json["budget_end"],
        status: json["status"],
        ownerId: json["owner_id"],
        nickname: json["nickname"],
        adjectives: json['adjective'] != null ? (() {
          var list = json['adjective'].split('|');
          if (list.isNotEmpty && list.last.isEmpty) {
            list.removeLast();
          }
          return list;
        })() : null,
        budgetHotel: json['budget_hotel'],
        budgetSvago: json['budget_svago'],
        budgetTrasporti: json['budget_trasporti'],
        allDestinations: json['all_destinations'] != null ? (() {
          var list = json['all_destinations'].split('|');
          if (list.isNotEmpty && list.last.isEmpty) {
            list.removeLast();
          }
          return list;
        })() : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "id_group": groupId,
        "is_final_choice": isFinalChoice,
        "created_at": createdAt,
        "country_name": countryName,
        "region_name": regionName,
        "city_name": cityName,
        "street_name": addressName,
        "country_name2": countryName2,
        "region_name2": regionName2,
        "city_name2": cityName2,
        "street_name2": addressName2,
        "country_name3": countryName3,
        "region_name3": regionName3,
        "city_name3": cityName3,
        "street_name3": addressName3,
        "budget_start": budgetStart,
        "budget_end": budgetEnd,
        "status": status,
        "owner_id": ownerId,
        "nickname": nickname,
      };

  static GroupChoice? myChoice(List<GroupChoice> choices, int userId) {
    for (GroupChoice choice in choices) {
      if (choice.ownerId == userId) {
        return choice;
      }
    }
    return null;
  }

  static GroupChoice? finalChoice(List<GroupChoice> choices) {
    for (GroupChoice choice in choices) {
      if (choice.status && choice.isFinalChoice) {
        return choice;
      }
    }
    return null;
  }
}
