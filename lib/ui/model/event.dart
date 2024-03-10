import 'dart:convert';

class Event {
  final int id;
  final int idGroup;
  final String startDate;
  final String endDate;
  final String dateTime;
  final String title;
  final String? address;
  
  Event({
    required this.id,
    required this.idGroup,
    required this.startDate,
    required this.endDate,
    required this.dateTime,
    required this.title,
    this.address
  });


  factory Event.fromJson(String str) => Event.fromMap(json.decode(str));

  String toJson() => json.encode({
        "id": id,
        "id_group": idGroup,
        "start_date": startDate,
        "end_date": endDate,
        "date_time": dateTime,
        "title": title,
        "address": address,
      });

  factory Event.fromMap(Map<String, dynamic> json) => Event(
        id: json["id"],
        idGroup: json["id_group"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        dateTime: json["date_time"],
        title: json["title"],
        address: json["address"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "id_group": idGroup,
        "start_date": startDate,
        "end_date": endDate,
        "date_time": dateTime,
        "title": title,
        "address": address,
      };


  static List<Event> eventForDay(String date, List<Event> allEvent) {
    List<Event> tmp = [];
    for (Event event in allEvent) {
      if (event.dateTime == date) {
        tmp.add(event);
      }
    }
    tmp.sort(
      (a, b) => a.startDate.compareTo(b.startDate)
    );
    return tmp;
  }

}


