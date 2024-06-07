// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:shared_preferences/shared_preferences.dart';
import 'package:veg_net/services/api_handler.dart';

class SharedPref {
  static SharedPreferences? prefs;
  static Map<String, dynamic> user_login_data = {
    'user_name': 'random',
    'user_token': Null
  };

//api call at the start if application to check if the user was previously logged in
  static Future<bool> initialize_shared_preferences() async {
    try {
      prefs = await SharedPreferences.getInstance();

      final String? user_token = prefs?.getString('user_token');
      final String? user_name = prefs?.getString('user_name');

      if (user_token != null) {
        //send token to verify if it matches with the database one
        user_login_data['user_name'] = user_name;
        user_login_data['user_token'] = user_token;
        var status_response =
            await VegNetAPI.verify_user_token(user_login_data);
        if (status_response == 102) {
          return true;
        }
      }
    } catch (error) {
      print("SOME ERRRRRRRRRRRORRRRRRRRRRRRRRRRR");
    }
    return false;
  }

  static Future<bool> store_local_user_data(
      Map<String, dynamic> user_data) async {
    if (prefs != null) {
      try {
        await prefs!.setString('user_token', user_data['user_token']);
        await prefs!.setString('user_name', user_data['user_name']);
        return true;
      } catch (error) {
        return false;
      }
    }
    return false;
  }

  // static Future<Map<String, dynamic>> get_local_user_info() async{
  //   if (prefs != null) {
  //     try {
  //       return user_login_data;
  //     } catch (error) {}
  //   }
  // }

//after the user is signed up sucessfully, the token needs to be saved in shared preferences
}
