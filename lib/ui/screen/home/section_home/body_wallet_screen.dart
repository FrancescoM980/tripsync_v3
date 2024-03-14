import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:clean_calendar/clean_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:timeago/timeago.dart';
import 'package:tripsync_v3/ui/common_widget/common_form_field.dart';
import 'package:tripsync_v3/ui/common_widget/obx_body.dart';
import 'package:tripsync_v3/ui/common_widget/trip_scaffold.dart';
import 'package:tripsync_v3/ui/controller/calendarController.dart';
import 'package:tripsync_v3/ui/controller/chatController.dart';
import 'package:tripsync_v3/ui/controller/groupController.dart';
import 'package:tripsync_v3/ui/controller/homeController.dart';
import 'package:tripsync_v3/ui/controller/walletController.dart';
import 'package:tripsync_v3/ui/model/chat.dart';
import 'package:tripsync_v3/ui/model/group.dart';
import 'package:tripsync_v3/ui/screen/settings/settings_screen.dart';
import 'package:tripsync_v3/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class BodyWallet extends StatelessWidget {
  WalletController walletController = Get.find<WalletController>();
  BodyWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
            child: Row(
              children: [
                Text(
                  'Nel complesso devi ricevere ',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '33,84',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: false,
              itemCount: walletController.debitors.length,
              itemBuilder: (context, i) {
                Debitor debitor = walletController.debitors[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: ListTile(
                    onTap: () {
                      
                    },
                    title: Text(debitor.nicknameDebitor),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'devi dare',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text('${debitor.valueDebt}')
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.transparent,
                      child: Icon(
                        Iconsax.moneys,
                        color: Colors.lightGreenAccent,
                      )
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      )
    );
  }
}