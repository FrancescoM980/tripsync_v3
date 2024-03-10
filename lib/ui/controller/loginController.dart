
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tripsync_v3/ui/model/user_model.dart';
import 'package:tripsync_v3/ui/screen/home/homepage.dart';
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
          
        }
        success = true;
      }
      return success;

    } catch (error) {
      success = false;
      print(error);
      return success;
    }
  }

  Future<void> saveAutologin(String phone, String password, String prefix) async {
    isLoadingLogin.value = true;
    await loginWithSupabase(phone, password, prefix);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await prefs.setString('phone', phone);
    await prefs.setString('password', password);
    await prefs.setString('prefix', prefix);
    isLoadingLogin.value = false;
  }

  Future<String> autoLogin() async {
    isLoadingLogin.value = true;
    bool success = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phone = prefs.getString('phone');
    String? password = prefs.getString('password');
    String? prefix = prefs.getString('prefix');
    if (phone != null && prefix != null && password != null) {
      success = await loginWithSupabase(phone, password, prefix);
    }
    isLoadingLogin.value = false;
    return success ? 'success' : 'error';
  }

  Future<String> checkLoginStatus() async {
  try {
    if (TripUtils.supabase.auth.currentSession?.accessToken != null) {
      final response = await TripUtils.supabase.auth.recoverSession(
        '{"access_token": ${TripUtils.supabase.auth.currentSession?.accessToken}}'
      );
      if (response.session != null) {
        // User is logged in
        return 'success';
      } else {
        // User is not logged in or session has expired
        return 'error';
      }
    } else {
      return 'error';
    }
  } catch (error) {
    // Handle any errors that occur during the session recovery process
    return 'error';
  }
}

}