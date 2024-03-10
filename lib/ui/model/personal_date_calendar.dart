import 'dart:convert';

class PersonalDateCalendar {
  final int userId;
  final DateTime startDate;
  final DateTime endDate;
  final String groupTitle;
  final int groupId;
  final bool isMyChoice;
  
  PersonalDateCalendar({
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.groupTitle,
    required this.groupId,
    required this.isMyChoice,
  });


  factory PersonalDateCalendar.fromJson(String str) => PersonalDateCalendar.fromMap(json.decode(str));

  String toJson() => json.encode({
    "user_id": userId,
    "start_date": startDate,
    "end_date": endDate,
    "title": groupTitle,
    "group_id": groupId,
    "ismychoice": isMyChoice,
      });

  factory PersonalDateCalendar.fromMap(Map<String, dynamic> json) => PersonalDateCalendar(
        userId: json["user_id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        groupTitle: json["title"],
        groupId: json["group_id"],
        isMyChoice: json["ismychoice"],
      );

  Map<String, dynamic> toMap() => {
    "user_id": userId,
    "start_date": startDate,
    "end_date": endDate,
    "title": groupTitle,
    "group_id": groupId,
    "ismychoice": isMyChoice,
      };

}


