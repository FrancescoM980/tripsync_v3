import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeago/timeago.dart';
import 'package:tripsync_v3/ui/common_widget/loading_widget.dart';
import 'package:tripsync_v3/ui/controller/groupController.dart';
import 'package:tripsync_v3/ui/controller/loginController.dart';
import 'package:tripsync_v3/ui/screen/home/homepage.dart';
import 'package:tripsync_v3/ui/screen/login/login_screen.dart';
import 'package:tripsync_v3/ui/screen/travel_wizard/step1.dart';
import 'package:tripsync_v3/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://imsudryomiffczemzekx.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imltc3VkcnlvbWlmZmN6ZW16ZWt4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA0MTgyNDksImV4cCI6MjAxNTk5NDI0OX0.LtxJ3yfF44h4hxP-3vTwHRyyT8wL8Jt4Im-zsZAONF4',
  );
  
  runApp(MyApp());
}

class MainController extends GetxController {
  ThemeMode currentTheme = ThemeMode.system;
  RxBool isLoading = false.obs;
}

class MyApp extends StatelessWidget {
  MainController mainController = Get.put(MainController());
  LoginController loginController = Get.put(LoginController());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Obx( () => mainController.isLoading.value
        ? GetMaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          themeMode: mainController.currentTheme,
          theme: TripUtils.lightTheme,
          darkTheme: TripUtils.darkTheme,
          home: FutureBuilder(
            future: autoLogin(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == 'success') {
                  return HomePageScreen();
                }
                else if (snapshot.data == 'aggiornare') {
                  return Text('ciao');
                } else {
                  return LoginScreen();
                }
              } else {
                return FirstScreen();
              }
            },
          )
        )
      : GetMaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          themeMode: mainController.currentTheme,
          theme: TripUtils.lightTheme,
          darkTheme: TripUtils.darkTheme,
          home: FutureBuilder(
            future: autoLogin(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(snapshot.data);
              if (snapshot.hasData) {
                if (snapshot.data == 'success') {
                  return HomePageScreen();
                }
                else if (snapshot.data == 'aggiornare') {
                  return Text('ciao');
                } else if (snapshot.data == 'tutorial') { 
                  return StepTutorialWizard();
                } else {
                  return LoginScreen();
                }
              } else {
                return FirstScreen();
              }
            },
          )
        ),
        
      ),
    );
  }
  Future<String> autoLogin() async {
    setLocaleMessages('it', ItMessages());
    try {
      
      String tmp = await loginController.autoLogin();
      GroupController groupController = Get.put(GroupController());
      await groupController.fetchMyGroups();
      //groupController.fetchMyGroups();
      return tmp;
    } catch (e) {
      return 'error';
    }
    
  }
}







class FirstScreenController extends GetxController {
  ThemeMode currentTheme = ThemeMode.system;
  RxBool isLoading = false.obs;
}

class FirstScreen extends StatelessWidget {
  FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FirstScreenController>(
      init: FirstScreenController(),
      builder: (controller) {
        
        return Scaffold(
          backgroundColor: TripUtils.purple,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_icona.png'
                  ),
                  Image.asset(
                    'assets/images/logo_scritta.png'
                  )
                ],
              ),
            ],
          )
        );
      },
    );
  }
}