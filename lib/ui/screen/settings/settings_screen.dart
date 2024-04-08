import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripsync_v3/main.dart';
import 'package:tripsync_v3/ui/common_widget/trip_popup.dart';
import 'package:tripsync_v3/ui/common_widget/trip_scaffold.dart';
import 'package:tripsync_v3/ui/controller/loginController.dart';
import 'package:tripsync_v3/ui/screen/login/login_screen.dart';
import 'package:tripsync_v3/ui/screen/settings/general_notification_screen.dart';
import 'package:tripsync_v3/ui/screen/settings/privacy_policy.dart';
import 'package:tripsync_v3/ui/screen/settings/send_report.dart';
import 'package:tripsync_v3/ui/screen/settings/termini_condizioni.dart';
import 'package:tripsync_v3/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends StatelessWidget {
  LoginController loginController = Get.find<LoginController>();
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
            onTap: () {
              Get.to(NotificationSettingsPage());
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.textSendError),
            trailing: Icon(
              Iconsax.danger,
              color: TripUtils.arancione
            ),
            onTap: () {
              Get.to(SendReportPage());
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.textPrivacyPolicy),
            trailing: Icon(
              Iconsax.arrow_right,
            ),
            onTap: () {
              Get.to(PrivacyPolicy());
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.textTermsAndCondition),
            trailing: Icon(
              Iconsax.arrow_right,
            ),
            onTap: () {
              Get.to(TermsAndCondition());
            },
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
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              await TripUtils.supabase.auth.signOut();
              sharedPreferences.clear();
              Get.offAll(
                LoginScreen()
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
            onTap: () async {
              Get.back();
              //await loginController.deleteUserFromDb();
            },
          ),
        ],
      )
    );
  }
}