import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tripsync_v3/ui/controller/groupController.dart';
import 'package:tripsync_v3/ui/controller/loginController.dart';
import 'package:tripsync_v3/ui/screen/home/homepage.dart';
import 'package:tripsync_v3/ui/screen/login/login_screen.dart';
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

class MyApp extends StatelessWidget {
  LoginController loginController = Get.put(LoginController());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
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
              } else {
                return LoginScreen();
              }
            } else {
              return FirstScreen();
            }
          },
        )
      ),
    );
  }
  Future<String> autoLogin() async {
    String tmp = await loginController.autoLogin();
    //groupController.fetchMyGroups();
    return tmp;
  }
}







class FirstScreenController extends GetxController {
  RxBool isLoading = true.obs;
}

class FirstScreen extends StatelessWidget {
  FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FirstScreenController>(
      init: FirstScreenController(),
      builder: (controller) {
        
        return Scaffold(
          body: SizedBox(
            width: MediaQuery.of(context).size.width/1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LoadingAnimationWidget.inkDrop(
                  color: Theme.of(context).primaryColor, 
                  size: 30
                ),
                SizedBox(height: 15),
                Text(AppLocalizations.of(context)!.loadingText)
              ],
            ),
          )
        );
      },
    );
  }
}