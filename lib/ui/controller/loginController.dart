
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tripsync_v3/ui/model/user_model.dart';
import 'package:tripsync_v3/ui/screen/home/homepage.dart';
import 'package:tripsync_v3/ui/screen/travel_wizard/step1.dart';
import 'package:tripsync_v3/utils.dart';

class LoginController extends GetxController {
  late UserModel currentUser;
  RxBool isLoadingLogin = false.obs;

  Future<bool> loginWithSupabase(String phone, String password, String prefix) async {
    bool success = false;
    try {
      final AuthResponse response = await TripUtils.supabase.auth.signInWithPassword(
        phone: phone.replaceAll('+', ''),
        password: password,
      );
      if (response.user != null) {
        final res =  await TripUtils.supabase.rpc('get_user_by_phone', params: {'phoneinput': phone.replaceFirst(prefix, '')});
        UserModel? user = res.isNotEmpty ? UserModel.fromMap(res[0]) : null;
        if (user != null) {
          currentUser = user;
          if (currentUser.pathImage != null && currentUser.pathImage!.isNotEmpty) {
            String urlImage = await TripUtils.supabase
            .storage
            .from('files')
            .createSignedUrl(
              currentUser.pathImage!,
              100000
            );
            currentUser.pathImage = urlImage;
          }
          success = true;
        } else {
          Get.dialog(
            AlertDialog(
              title: Text('user not feund'),
            )
          );
        }
        
      }
      return success;

    } catch (error) {
      success = false;
      Get.dialog(
        AlertDialog(
          title: Text('$error'),
        )
      );
      print(error);
      return success;
    }
  }

  Future<bool> saveAutologin(String phone, String password, String prefix) async {
    isLoadingLogin.value = true;
    bool success = false;
    try {
      success = await loginWithSupabase(phone, password, prefix);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await prefs.setString('phone', phone);
      await prefs.setString('password', password);
      await prefs.setString('prefix', prefix);
      bool? hasTutorial = prefs.getBool('has_tutorial');
      isLoadingLogin.value = false;
      if ( (hasTutorial == null || hasTutorial != true) && success) {
        Get.off(
          StepTutorialWizard()
        );
      } else if (success) {
        Get.off(HomePageScreen());
      } else {
        Get.dialog(
          AlertDialog(
            title: Text('Ops, qualcosa è andato stuart'),
          )
        );
      }
      return success;
    } catch (e) {
      Get.dialog(
        AlertDialog(
          title: Text('$e'),
        )
      );
      return success;
    }

    
  }

  Future<String> autoLogin() async {
    isLoadingLogin.value = true;
    bool success = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phone = prefs.getString('phone');
    String? password = prefs.getString('password');
    String? prefix = prefs.getString('prefix');
    bool? hasTutorial = prefs.getBool('has_tutorial');
    if (phone != null && prefix != null && password != null) {
      success = await loginWithSupabase(phone, password, prefix);
    }
    isLoadingLogin.value = false;
    if ( (hasTutorial == null || hasTutorial != true) && success) {
      return 'tutorial';
    } else {
      return success ? 'success' : 'error';
    }
    
  }

  Future<String> checkLoginStatus() async {
    try {
      if (TripUtils.supabase.auth.currentSession?.accessToken != null) {
        final response = await TripUtils.supabase.auth.recoverSession(
          '{"access_token": ${TripUtils.supabase.auth.currentSession?.accessToken}}'
        );
        if (response.session != null) {
          return 'success';
        } else {
          return 'error';
        }
      } else {
        return 'error';
      }
    } catch (error) {
      return 'error';
    }
  }

  Future<void> deleteUserFromDb() async {
    //isLoadingDeleteUser.value = true;
    //final String url = 'https://imsudryomiffczemzekx.supabase.co/auth/v1/admin/users/${TripUtils.supabase.auth.currentUser?.id ?? ''}';
    //final response = await http.delete(
    //  Uri.parse(url),
    //  headers: {
    //    'apikey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imltc3VkcnlvbWlmZmN6ZW16ZWt4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA0MTgyNDksImV4cCI6MjAxNTk5NDI0OX0.LtxJ3yfF44h4hxP-3vTwHRyyT8wL8Jt4Im-zsZAONF4',
    //    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imltc3VkcnlvbWlmZmN6ZW16ZWt4Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwMDQxODI0OSwiZXhwIjoyMDE1OTk0MjQ5fQ.prOE1Mvf1EhVEurkbkI2EHZnuoaeMgbphppeOiDvAlE',
    //    'Content-Type': 'application/json',
    //  },
    //);
    //if (response.statusCode == 200) {
    //  ResponseBody ress = await RemoteService.updateDataToTable(
    //    'userdata', 
    //    {
    //      'is_active': false
    //    }, 
    //    {
    //      'id': currentUser.id
    //    }
    //  );
    //  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //  sharedPreferences.clear();
    //  isLoadingDeleteUser.value = false;
    //  Get.off(Login());
    //} else {
    //  isLoadingDeleteUser.value = false;
    //}
  }

}