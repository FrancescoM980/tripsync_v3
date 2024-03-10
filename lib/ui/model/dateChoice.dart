import 'dart:convert';

class DateChoice {
  final int id;
  final int idGroupChoice;
  final String startDate;
  final String endDate;
  
  
  DateChoice({
    required this.id,
    required this.idGroupChoice,
    required this.startDate,
    required this.endDate,
  });


  factory DateChoice.fromJson(String str) => DateChoice.fromMap(json.decode(str));

  String toJson() => json.encode({
        "id": id,
        "id_group_choice": idGroupChoice,
        "start_date": startDate,
        "end_date": endDate,
      });

  factory DateChoice.fromMap(Map<String, dynamic> json) => DateChoice(
        id: json["id"],
        idGroupChoice: json["id_group_choice"],
        startDate: json["start_date"].split('T')[0],
        endDate: json["end_date"].split('T')[0],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "id_group_choice": idGroupChoice,
        "start_date": startDate,
        "end_date": endDate,
      };
}
