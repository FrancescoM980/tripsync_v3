import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripsync_v3/ui/controller/serviceController.dart';
import 'package:tripsync_v3/ui/model/flight_ticket.dart';
import 'package:url_launcher/url_launcher.dart';

class FlightResultPage extends StatelessWidget {
  ServiceController serviceController = Get.find<ServiceController>();
  FlightResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx( () => serviceController.isLoadingFlight.value
          ? Center(
            child: Image.asset('assets/images/gif_loading_flight.gif')
          )
          : ListView.builder(
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
    );
  }
}