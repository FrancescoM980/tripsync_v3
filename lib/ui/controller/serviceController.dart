import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:currency_converter/currency.dart';
import 'package:currency_converter/currency_converter.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tripsync_v3/ui/model/airport.dart';
import 'package:tripsync_v3/ui/model/flight_ticket.dart';
class ServiceController extends GetxController {
  Airport? andata;
  Airport? ritorno;
  TextEditingController andataDate = TextEditingController();
  TextEditingController ritornoDate = TextEditingController();
  int numberPartecipants = 1;
  RxBool isChangedAnything = false.obs;
  RxList<Airport> allAirports = <Airport>[].obs;
  RxList<FlightTicket> flightTickets = <FlightTicket>[].obs;

  String generateSignature(Map<String, dynamic> params, String apiToken, String marker) {
  var passengersString = params['passengers'].entries.map((e) => "${e.value}").join(':');
  var segmentsString = params['segments'].map((segment) {
    return "${segment['date']}:${segment['destination']}:${segment['origin']}";
  }).join(':');

  var host = params['host'];
  var locale = params['locale'];
  var tripClass = params['trip_class'];
  var currency = params['currency'];
  var userIp = params['user_ip'];

  var finalString = "$apiToken:$currency:$host:$locale:$marker:$passengersString:$segmentsString:$tripClass:$userIp";
  return md5.convert(utf8.encode(finalString)).toString();
}

  Future<String> fetchDeviceIP() async {
    final response = await http.get(Uri.parse('http://api.ipify.org'));
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load IP address');
    }
  }

  Future<void> searchFlights(String andata, String ritorno, String andataDate, String ritornoDate, int partecipants, String typeTicket) async {
    String marker = '527479';
    String apiToken = '19f7f10a6c60d2808c9d2ec422502d39';
    var url = Uri.parse('https://api.travelpayouts.com/v1/flight_search');
    var headers = {'Content-type': 'application/json'};
    String ip = await fetchDeviceIP();
    print(ip);
    var signature = '';
    var requestParams = {
      "host": "com.example.tripsyncV3",
      "locale": "en",
      "currency": "eur",
      "user_ip": ip,
      "trip_class": typeTicket,
      "passengers": {"adults": partecipants, "children": 0, "infants": 0},
      "segments": [
        {"origin": andata, "destination": ritorno, "date": andataDate},
        {"origin": ritorno, "destination": andata, "date": ritornoDate}
      ]
    };

    signature = generateSignature(requestParams, apiToken, marker);

    var body = jsonEncode({...requestParams, "signature": signature, "marker": marker});
    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      String searchId = jsonDecode(response.body)['search_id'];
      print('Search id:' + searchId);
      //await Future.delayed(Duration(seconds: 20));
      await fetchFlightResults(searchId);
    } else {
      print('Errore nella richiesta API: ${response.statusCode}');
      print(response.body);
    }
  }































  Future<void> fetchFlightResults(String searchId) async {
    flightTickets.clear();
    List<FlightTicket> allTickets = [];
    var url = Uri.parse('http://api.travelpayouts.com/v1/flight_search_results?uuid=$searchId');
    try {
      await http.get(url);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        
        var jsonResponse = jsonDecode(response.body);
        for (var singleJson in jsonResponse) {
          print(singleJson['gates_info']);
          print(singleJson['filters_boundary']);
          if (singleJson['proposals'] != null && singleJson['proposals'].isNotEmpty) {
            var proposals = singleJson['proposals'];
            for (Map<String, dynamic> proposal in proposals) {
              int ore = proposal['total_duration'] ~/ 60;
              int minuti = proposal['total_duration'] % 60;
              List<Segment> segmentsFlight = [];
              FlightTicket flightTicket = FlightTicket(
                searchId: searchId,
                isDirect: proposal['is_direct'], 
                segments: [], 
                totalDuration: proposal['total_duration'],
                durationString: '${ore}h$minuti',
                generalInfo: GeneralInfo(
                  currency: '', 
                  price: 0, 
                  url: 0
                )
              );
              Map<String, dynamic> terms = proposal['terms'];
              for (String key in terms.keys) {
                var response = terms[key];
                GeneralInfo generalInfo = GeneralInfo.fromMap(response);

                flightTicket.generalInfo = generalInfo;
              }
              List<dynamic> segment = proposal['segment'];
              for (Map<String, dynamic> tmp in segment) {
                List<dynamic> listFlight = tmp['flight'];
                for (Map<String, dynamic> flight in listFlight) {
                  Segment segment = Segment.fromMap(flight);
                  segmentsFlight.add(segment);
                }
              }
              flightTicket.segments = segmentsFlight;
              allTickets.add(flightTicket);
            }
          }

        }
      }

      int bestPrice = allTickets[0].generalInfo.price;
      int bestDuration = allTickets[0].totalDuration;
      int maxPrice = allTickets[0].generalInfo.price;
      int maxDuration = allTickets[0].totalDuration;

      for (FlightTicket ticket in allTickets) {
        if (ticket.generalInfo.price < bestPrice) {
          bestPrice = ticket.generalInfo.price;
        }
        if (ticket.generalInfo.price > maxPrice) {
          maxPrice = ticket.generalInfo.price;
        }
        if (ticket.totalDuration < bestDuration) {
          bestDuration = ticket.totalDuration;
        }
        if (ticket.totalDuration > maxDuration) {
          maxDuration = ticket.totalDuration;
        }
      }

      print('MASSIMO: $maxDuration - $maxPrice');
      print('MINIMO: $bestDuration - $bestPrice');
      List<FlightTicket> bestTickets = sortTickets(
        allTickets, 
        bestPrice.toDouble(), 
        maxPrice.toDouble(), 
        bestDuration.toDouble(), 
        maxDuration.toDouble(), 
        0.50, 
        0.50
      );
      flightTickets.addAll(bestTickets);
      print(flightTickets.length);
    } catch (e) {
      print('Errore nel catch: $e');
    }
  }



  List<FlightTicket> sortTickets(List<FlightTicket> tickets, double priceMin, double priceMax, double durationMin, double durationMax, double weightPrice, double weightDuration) {
    // Funzione per normalizzare i valori
    double normalize(double value, double min, double max) {
      return (value - min) / (max - min);
    }

    // Calcolo della valutazione per ogni ticket e ordinamento
    tickets.sort((a, b) {
      double aPriceNormalized = normalize(a.generalInfo.price.toDouble(), priceMin, priceMax);
      double aDurationNormalized = normalize(a.totalDuration.toDouble(), durationMin, durationMax);
      double aScore = weightPrice * aPriceNormalized + weightDuration * aDurationNormalized;

      double bPriceNormalized = normalize(b.generalInfo.price.toDouble(), priceMin, priceMax);
      double bDurationNormalized = normalize(b.totalDuration.toDouble(), durationMin, durationMax);
      double bScore = weightPrice * bPriceNormalized + weightDuration * bDurationNormalized;

      return aScore.compareTo(bScore); // Ordina i ticket dal punteggio più basso al più alto
    });

    return tickets.take(10).toList();
  }



Currency getCurrencyName(String currencyCode) {
  switch (currencyCode.toUpperCase()) {
    case 'USD':
      return Currency.usd;
    case 'EUR':
      return Currency.eur;
    case 'JPY':
      return Currency.jpy;
    case 'GBP':
      return Currency.gbp;
    case 'AUD':
      return Currency.aud;
    case 'CAD':
      return Currency.cad;
    case 'CHF':
      return Currency.chf;
    case 'CNY':
      return Currency.cny;
    case 'HKD':
      return Currency.hkd;
    case 'SGD':
      return Currency.sgd;
    case 'SEK':
      return Currency.sek;
    case 'KRW':
      return Currency.krw;
    case 'NOK':
      return Currency.nok;
    case 'MXN':
      return Currency.mxn;
    case 'INR':
      return Currency.inr;
    case 'RUB':
      return Currency.rub;
    case 'ZAR':
      return Currency.zar;
    case 'BRL':
      return Currency.brl;
    case 'NZD':
      return Currency.nzd;
    case 'PLN':
      return Currency.pln;
    case 'THB':
      return Currency.thb;
    case 'IDR':
      return Currency.idr;
    case 'HUF':
      return Currency.huf;
    case 'CZK':
      return Currency.czk;
    case 'ILS':
      return Currency.ils;
    case 'CLP':
      return Currency.clp;
    case 'PHP':
      return Currency.php;
    case 'AED':
      return Currency.aed;
    case 'COP':
      return Currency.cop;
    case 'SAR':
      return Currency.sar;
    case 'MYR':
      return Currency.myr;
    case 'RON':
      return Currency.ron;
    default:
      return Currency.eur;
  }
}







  Future<String> fetchFlightTermsUrl(String searchId, int termsUrl) async {
    String marker = '527479';
    var url = Uri.parse('http://api.travelpayouts.com/v1/flight_searches/$searchId/clicks/$termsUrl.json?marker=$marker');
    print(url);
    try {
      var response = await http.get(url, headers: {'Accept-Encoding': 'gzip, deflate'});

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return jsonResponse['url'];
      } else {
        return 'error';
      }
    } catch (e) {
      return 'error';
    }
  }

  Future<void> searchAirport(String inputText) async {
    List<String> suffix = [];
      try {
        var searchUrl = Uri.parse('https://autocomplete.travelpayouts.com/places2?locale=it&types[]=airport&types[]=city&term=$inputText');
        var response = await http.get(searchUrl);
        var res = jsonDecode(response.body);
        allAirports.clear();
        for (var r in res) {
          suffix.add(r['code'] + ' - ' + r['name']);
          allAirports.add(Airport(name: r['name'], code: r['code']));
        }
        print(suffix);
    } catch (e) {

    }
   
  }
}