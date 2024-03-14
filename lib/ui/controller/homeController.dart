import 'dart:convert';

import 'package:get/get.dart';
import 'package:tripsync_v3/ui/controller/groupController.dart';
import 'package:tripsync_v3/ui/controller/loginController.dart';
import 'package:tripsync_v3/ui/model/chat.dart';
import 'package:tripsync_v3/utils.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  LoginController loginController = Get.find<LoginController>();
  GroupController groupController = Get.find<GroupController>();
  RxInt currentIndex = 0.obs;



  Future<void> searchAirport(String inputText) async {
    List<String> suffix = [];
    var searchUrl = Uri.parse('https://autocomplete.travelpayouts.com/places2?locale=it&types[]=airport&types[]=city&term=$inputText');
    var response = await http.get(searchUrl);
    var res = jsonDecode(response.body);
    for (var r in res) {
      suffix.add(r['code'] + ' - ' + r['name']);
    }
    print(suffix);
  }

  Future<void> searchFlight(String inputText) async {
    String token = '19f7f10a6c60d2808c9d2ec422502d39';
    List<String> suffix = [];
    var searchUrl = Uri.parse('https://api.travelpayouts.com/aviasales/v3/prices_for_dates?origin=SUF&destination=LIN&departure_at=2024-04-15&return_at=2024-04-24&unique=false&sorting=price&direct=false&cy=eur&limit=50&page=1&one_way=false&token=$token');
    var response = await http.get(searchUrl);
    var res = jsonDecode(response.body);
    print(res);
    //for (var r in res) {
    //  print(r);
    //}
    //print(suffix);
  }



  Future<void> fetchDirectFlights(String origin, String destination, String departDate, String returnDate, String token) async {
    final String url = 'http://api.travelpayouts.com/v1/prices/calendar';
    final response = await http.get(Uri.parse('$url?depart_date=$departDate&origin=$origin&destination=$destination&token=$token'));
    print(response.body);
    if (response.statusCode == 200) {
      for (var r in json.decode(response.body)['data'].entries) {
        print(r.key);
        print(json.decode(response.body)['data'][r.key]);
      }
    } else {
      print('Failed to load flights');
    }
  }


  Future<void> fetchFlightSearchResults(String searchId) async {
    String token = '19f7f10a6c60d2808c9d2ec422502d39';
    final String url = 'http://api.travelpayouts.com/v1/flight_search_results';
    final response = await http.get(
      Uri.parse('$url?uuid=$searchId'),
      // Aggiungi il token API nell'header della richiesta
      headers: {
        'X-Access-Token': token
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      // Qui puoi elaborare ulteriormente la risposta JSON.
    } else {
      print('Richiesta fallita con stato: ${response.statusCode}.');
      print(response.body);
    }
  }
}