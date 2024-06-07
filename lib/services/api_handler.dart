// ignore_for_file: non_constant_identifier_names, constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

class VegNetAPI {
  static List<dynamic> response_message = [];
  static const String base_url = 'http://192.168.1.65:8000/veg_net';
  static const String user_registration_url = '$base_url/user_registration';
  static const String user_login_url = '$base_url/user_login';
  static const String user_token_verification = '$base_url/user_token_handler';

  static Map<String, dynamic> sign_in_response = {'status': 0, 'token': ''};
  // static const String user_registration_url = '/veg_net/user_registration';

  //static SharedPreferences? prefs;

  static Future<int> post_user_signup_data(
      Map<String, dynamic> user_sign_up_data) async {
    final uri = Uri.parse(user_registration_url);
    try {
      final response = await http.post(uri, body: user_sign_up_data);
      final body = response.body;
      final json = jsonDecode(body);
      sign_in_response['status'] = json['status'];
      sign_in_response['token'] = json['token'];
      print(json['status']);
      return json['status'];
    } catch (error) {
      return -1;
    }
  }

  static Future<Map<String, dynamic>> post_user_login(
      Map<String, dynamic> user_login_data) async {
    final uri = Uri.parse(user_login_url);
    try {
      final response = await http.post(uri, body: user_login_data);
      final body = response.body;
      final json = jsonDecode(body);
      sign_in_response['status'] = json['status'];
      sign_in_response['token'] = json['token'];
      return sign_in_response;
    } catch (error) {
      // return -1;
      //redundant sign_in_response but necessary
      return sign_in_response;
    }
  }

  static Future<int> verify_user_token(
      Map<String, dynamic> user_login_data) async {
    final uri = Uri.parse(user_token_verification);
    try {
      final response = await http.post(uri, body: user_login_data);
      final body = response.body;
      final json = jsonDecode(body);
      return json['status'];
    } catch (error) {
      return -1;
    }
  }
}
