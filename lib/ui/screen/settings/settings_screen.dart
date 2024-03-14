import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tripsync_v3/main.dart';
import 'package:tripsync_v3/ui/common_widget/trip_popup.dart';
import 'package:tripsync_v3/ui/common_widget/trip_scaffold.dart';
import 'package:tripsync_v3/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends StatelessWidget {
  MainController mainController = Get.find<MainController>();
  SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          child: Icon(
            Icons.close,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView(
        children: [
          Obx ( () => mainController.isLoading.value
            ? SwitchListTile(
              title: Text(AppLocalizations.of(context)!.textTheme),
              value: mainController.currentTheme == ThemeMode.dark ? true : false, 
              activeColor: TripUtils.arancione,
              activeTrackColor: TripUtils.arancioneChiaro,
              inactiveTrackColor: TripUtils.grigioChiaro,
              inactiveThumbColor: Colors.white,
              trackOutlineColor: MaterialStatePropertyAll(mainController.currentTheme == ThemeMode.dark ? TripUtils.arancioneChiaro : TripUtils.grigioChiaro),
              onChanged: (value) {
                mainController.isLoading.value = true;
                if (mainController.currentTheme == ThemeMode.dark) {
                  mainController.currentTheme = ThemeMode.light;
                } else {
                  mainController.currentTheme = ThemeMode.dark;
                }
                mainController.isLoading.value = false;
              },
            )
            : SwitchListTile(
              title: Text(AppLocalizations.of(context)!.textTheme),
              value: mainController.currentTheme == ThemeMode.dark ? true : false, 
              activeColor: TripUtils.arancione,
              activeTrackColor: TripUtils.arancioneChiaro,
              inactiveTrackColor: TripUtils.grigioChiaro,
              inactiveThumbColor: Colors.white,
              trackOutlineColor: MaterialStatePropertyAll(mainController.currentTheme == ThemeMode.dark ? TripUtils.arancioneChiaro : TripUtils.grigioChiaro),
              onChanged: (value) {
                mainController.isLoading.value = true;
                if (mainController.currentTheme == ThemeMode.dark) {
                  mainController.currentTheme = ThemeMode.light;
                } else {
                  mainController.currentTheme = ThemeMode.dark;
                }
                mainController.isLoading.value = false;
              },
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.textGeneralNotification),
            trailing: Icon(
              Iconsax.notification,
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.textSendError),
            trailing: Icon(
              Iconsax.danger,
              color: TripUtils.arancione
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.textPrivacyPolicy),
            trailing: Icon(
              Iconsax.arrow_right,
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.textTermsAndCondition),
            trailing: Icon(
              Iconsax.arrow_right,
            ),
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.textLogout,
              style: TextStyle(
                color: Colors.red
              )
            ),
            trailing: Icon(
              Iconsax.logout,
              color: Colors.red,
            ),
            onTap: () async {
              Get.dialog(
                TripPopup(
                  //title: 'ATTENZIONE', 
                  //hasButtons: true,
                  //onPressedConfirm: () async {
                  //  Get.back();
                  //  await loginController.deleteUserFromDb();
                  //},
                  //content: Text("Cliccando 'CONFERMA' cancellerai in modo permanente il tuo account.\nQuest'azione sarà confermata entro 10 giorni lavorativi.")
                )
              );
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.textDeleteAccount,
              style: TextStyle(
                color: Colors.red
              )
            ),
            trailing: Icon(
              Iconsax.profile_delete,
              color: Colors.red
            ),
          ),
        ],
      )
    );
  }
}