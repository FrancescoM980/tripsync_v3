import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripsync_v3/main.dart';
import 'package:tripsync_v3/ui/common_widget/loading_widget.dart';
import 'package:tripsync_v3/ui/model/NotificationModel.dart';
import 'package:tripsync_v3/utils.dart';

class NotificationSettingsPage extends StatelessWidget {
  //NotificationController notificationController = Get.find<NotificationController>();
  List<Map<String, dynamic>> allItems = [
    {
      'title': 'Gruppo',
      'items': [
        NotificationModel(label: 'Messaggi Gruppi', value: 'chat'),
        NotificationModel(label: "Inviti Accettati", value: 'accept_group'),
        NotificationModel(label: 'Inviti Nuovi Gruppi', value: 'invitation_group'),
        NotificationModel(label: 'Inserimento Preferenze', value: 'insert_choice'),
        NotificationModel(label: 'Creazione Transazioni', value: 'wallet'),
        NotificationModel(label: 'Creazione Eventi', value: 'calendar'),
      ]
    },
    {
      'title': 'Sistema',
      'items': [
        NotificationModel(label: 'Info sistema', value: 'info'),
      ]
    },
  ];
  NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTIFICHE GENERALI'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          shrinkWrap: false,
          scrollDirection: Axis.vertical,
          itemCount: allItems.length,
          itemBuilder: (context, i) {
            return BlocNotify(
              titleText: allItems[i]['title'],
              items: allItems[i]['items']
            );
          }
        ),
      ),
      //body: Obx( () => 
      //  Stack(
      //    children: [
      //      Padding(
      //        padding: const EdgeInsets.all(15.0),
      //        child: ListView.builder(
      //          shrinkWrap: false,
      //          scrollDirection: Axis.vertical,
      //          itemCount: allItems.length,
      //          itemBuilder: (context, i) {
      //            return BlocNotify(
      //              titleText: allItems[i]['title'],
      //              items: allItems[i]['items']
      //            );
      //          }
      //        ),
      //      ),
      //      if (notificationController.isLoadingNotify.value)
      //      Container(
      //        color: Colors.black.withOpacity(0.2)
      //      ),
      //      if (notificationController.isLoadingNotify.value)
      //      LoadingWidget()
      //    ],
      //  ),
      //),
    );
  }
}


class BlocNotify extends StatelessWidget {
  MainController mainController = Get.find<MainController>();
  //NotificationController notificationController = Get.find<NotificationController>();
  String titleText;
  List<NotificationModel> items;
  BlocNotify({
    super.key,
    required this.titleText,
    required this.items
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Text(
          titleText,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          )
        ),
        Column(
          children: List.generate(
            items.length, 
            (i) => ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                items[i].label,
                style: TextStyle(
                  fontSize: 14,
                )
              ),
              subtitle: Text(
                'Stato attuale: On',//${notificationController.getBoolValueGeneral(items[i].value) ? 'On' : 'Off'}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300
                )
              ),
              trailing: Switch(
                activeColor: TripUtils.arancione,
                activeTrackColor: TripUtils.arancioneChiaro,
                inactiveTrackColor: TripUtils.grigioChiaro,
                inactiveThumbColor: Colors.white,
                trackOutlineColor: MaterialStatePropertyAll(7 == 7 //notificationController.getBoolValueGeneral(items[i].value) 
                  ? TripUtils.arancioneChiaro 
                  : TripUtils.grigioChiaro
                ),
                onChanged: (valuesBool) async {
                  //notificationController.updateNotifyGeneral(items[i].value, valuesBool);
                },
                value: true//notificationController.getBoolValueGeneral(items[i].value)
              ),
            )
          )
        )
      ],
    );
  }
}