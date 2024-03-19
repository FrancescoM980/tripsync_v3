class FlightTicket {
  bool isDirect;
  List<Segment> segments;
  int totalDuration;
  String durationString;
  GeneralInfo generalInfo;
  String searchId;

  FlightTicket({
    required this.isDirect,
    required this.segments,
    required this.totalDuration,
    required this.durationString,
    required this.generalInfo,
    required this.searchId,
  });

  factory FlightTicket.fromMap(Map<String, dynamic> map) {
    return FlightTicket(
      isDirect: map['is_direct'] ?? false,
      segments: List<Segment>.from(map['segments'].map((x) => Segment.fromMap(x))),
      totalDuration: map['total_duration'] ?? 0,
      generalInfo: GeneralInfo.fromMap(map['general_info']),
      durationString: '',
      searchId: '',
    );
  }

}


class Segment {
  String marketingCarrier;
  String arrival;
  String arrivalDate;
  String arrivalTime;
  String departure;
  String departureDate;
  String departureTime;
  int duration;

  Segment({
    required this.marketingCarrier,
    required this.arrival,
    required this.arrivalDate,
    required this.arrivalTime,
    required this.departure,
    required this.departureDate,
    required this.departureTime,
    required this.duration,
  });

  factory Segment.fromMap(Map<String, dynamic> map) {
    return Segment(
      marketingCarrier: map['marketing_carrier'] ?? '',
      arrival: map['arrival'] ?? '',
      arrivalDate: map['arrival_date'] ?? '',
      arrivalTime: map['arrival_time'] ?? '',
      departure: map['departure'] ?? '',
      departureDate: map['departure_date'] ?? '',
      departureTime: map['departure_time'] ?? '',
      duration: map['duration'] ?? 0,
    );
  }

}

class GeneralInfo {
  String currency;
  int price;
  int url;

  GeneralInfo({
    required this.currency,
    required this.price,
    required this.url,
  });

  factory GeneralInfo.fromMap(Map<String, dynamic> map) {
    return GeneralInfo(
      currency: map['currency'] ?? '',
      price: map['price'] ?? 0,
      url: map['url'] ?? 0,
    );
  }

}