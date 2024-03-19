import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tripsync_v3/ui/common_widget/common_form_field.dart';
import 'package:tripsync_v3/ui/common_widget/main_button.dart';
import 'package:tripsync_v3/ui/common_widget/trip_popup.dart';
import 'package:tripsync_v3/ui/controller/serviceController.dart';
import 'package:tripsync_v3/ui/model/flight_ticket.dart';
import 'package:url_launcher/url_launcher.dart';

class BodyServiceFlight extends StatelessWidget {
  
  ServiceController serviceController = Get.put(ServiceController());
  BodyServiceFlight({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SearchFlightWidget(),
          MainButton(
            onTap: () {
              serviceController.searchFlights(
                serviceController.andata?.code ?? '',
                serviceController.ritorno?.code ?? '',
                serviceController.andataDate.text,
                serviceController.ritornoDate.text,
                serviceController.numberPartecipants,
                'Y'
              );
            }, 
            titleText: 'CERCA VOLO'
          ),
          Obx( () => 
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: serviceController.flightTickets.length,
              itemBuilder: (context, i) {
                FlightTicket ticket = serviceController.flightTickets[i];
                return InkWell(
                  onTap: () async {
                    String url = await serviceController.fetchFlightTermsUrl(ticket.searchId, ticket.generalInfo.url);
                    if (url != 'error') {
                      await launchUrl(
                        Uri.parse(
                          url
                        )
                      );
                    }
                    
                  },
                  child: Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('${ticket.generalInfo.price} ${ticket.generalInfo.currency}'),
                          subtitle: Text(ticket.durationString),
                        ),
                        
                        Column(
                          children: List.generate(
                            ticket.segments.length, 
                            (index) => ListTile(
                              title: Text('${ticket.segments[index].departure} ${ticket.segments[index].arrival}'),
                              subtitle: Text('${ticket.segments[index].departureTime} - ${ticket.segments[index].arrivalTime}\n${ticket.segments[index].marketingCarrier}'),
                            )
                          )
                        )
                      ],
                    ),
                    
                  ),
                );
              },
            ),
          )
        ],
      )
    );
  }
}


class SearchFlightWidget extends StatelessWidget {
  
  ServiceController serviceController = Get.find<ServiceController>();
  SearchFlightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Obx ( () => serviceController.isChangedAnything.value
        ? Container()
        : Card(
          child: Column(
            children: [
              TextField(
                controller: TextEditingController(text: serviceController.andata?.name),
                decoration: InputDecoration(
                  labelText:'Partenza',
                  border: InputBorder.none,
                  prefixIcon: Icon(Iconsax.location5),
                ),
                readOnly: true,
                onTap: () {
                  Get.to(
                    SearchAirportPage(
                      isAndata: true,
                    )
                  );
                },
                // Handle text input
              ),
              Divider(
                height: 0, 
                thickness: 2,
                color: Theme.of(context).highlightColor
              ),
              TextField(
                controller: TextEditingController(text: serviceController.ritorno?.name),
                decoration: InputDecoration(
                  labelText:'Arrivo',
                  border: InputBorder.none,
                  prefixIcon: Icon(Iconsax.location5),
                ),
                readOnly: true,
                onTap: () {
                  Get.to(
                    SearchAirportPage(
                      isAndata: false,
                    )
                  );
                },
                // Handle text input
              ),
              Divider(
                height: 0, 
                thickness: 2,
                color: Theme.of(context).highlightColor
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: TextField(
                        readOnly: true,
                        controller: serviceController.andataDate,
                        decoration: InputDecoration(
                          labelText: 'Andata',
                          border: InputBorder.none,
                          prefixIcon: Icon(Iconsax.calendar),
                        ),
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 1000)),
                            builder: (context, child) {
                              return child!;
                            },
                          );
                          if (selectedDate != null) {
                            String formattedDate = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";        
                            serviceController.andataDate.text = formattedDate;
                          }
                        },
                      ),
                    ),
                    VerticalDivider(
                      width: 0, 
                      thickness: 2,
                      color: Theme.of(context).highlightColor
                    ),
                    Flexible(
                      flex: 1,
                      child: TextField(
                        readOnly: true,
                        controller: serviceController.ritornoDate,
                        decoration: InputDecoration(
                          labelText: 'Ritorno',
                          border: InputBorder.none,
                          prefixIcon: Icon(Iconsax.calendar),
                        ),
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 1000)),
                            builder: (context, child) {
                              return child!;
                            },
                          );
                          if (selectedDate != null) {
                            String formattedDate = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";        
                            serviceController.ritornoDate.text = formattedDate;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0, 
                thickness: 2,
                color: Theme.of(context).highlightColor
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.people),
                          InkWell(
                            onTap: () {
                              serviceController.isChangedAnything.value = true;
                              if (serviceController.numberPartecipants > 1) {
                                serviceController.numberPartecipants -= 1;
                              }
                              serviceController.isChangedAnything.value = false;
                            },
                            child: Icon(Icons.remove)
                          ),
                          Text('${serviceController.numberPartecipants}'),
                          InkWell(
                            onTap: () {
                              serviceController.isChangedAnything.value = true;
                              serviceController.numberPartecipants += 1;
                              serviceController.isChangedAnything.value = false;
                            },
                            child: Icon(Icons.add)
                          ),
                        ],
                      )
                    ),
                    VerticalDivider(
                      width: 0, 
                      thickness: 2, 
                      color: Theme.of(context).highlightColor
                    ),
                    Flexible(
                      flex: 1,
                      child: TextField(
                        controller: TextEditingController(text: 'Economy'),
                        decoration: InputDecoration(
                          labelText: 'Classe',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.chair),
                        ),
                        // Handle text input
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}























class SearchAirportPage extends StatefulWidget {
  bool isAndata;
  SearchAirportPage({
    super.key,
    required this.isAndata
  });

  @override
  State<SearchAirportPage> createState() => _SearchAirportPageState();
}

class _SearchAirportPageState extends State<SearchAirportPage> {
  ServiceController serviceController = Get.find<ServiceController>();
  Timer? _debounce;

  void onSearchChanged(String query) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 50), () async {
      if (query.isNotEmpty) {
        await serviceController.searchAirport(query);
      }      
    });
  }
  
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isAndata 
            ? 'Da dove?'
            : 'Per dove?',
          style: TextStyle(
            color: Theme.of(context).primaryColor
          ),
        ),
      ),
      body: Column(
        children: [
          Card(
            child: TextField(
              decoration: InputDecoration(
                labelText: widget.isAndata 
                  ? 'Andata'
                  : 'Ritorno',
                border: InputBorder.none,
                prefixIcon: Icon(Iconsax.airplane),
              ),
              onChanged: onSearchChanged
            ),
          ),
          Expanded(
            child: Obx( () => ListView.builder(
                itemCount: serviceController.allAirports.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    onTap: () {
                      serviceController.isChangedAnything.value = true;
                      widget.isAndata
                        ? serviceController.andata = serviceController.allAirports[i]
                        : serviceController.ritorno = serviceController.allAirports[i];
                      serviceController.isChangedAnything.value = false;
                      Get.back();
                    },
                    title: Text(
                      '${serviceController.allAirports[i].name} - ${serviceController.allAirports[i].code}'
                    )
                  );
                },
              ),
            ),
          )
        ],
      )
    );
  }
}