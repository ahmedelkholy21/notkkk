import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> createaccount(
    String username, String password, String email, String number) async {
  try {
    var url =
        Uri.parse('https://8879-156-199-11-154.ngrok-free.app/create_account');
    var response = await http.post(url,
        body: jsonEncode({
          'name': username,
          'email': email,
          'pw': password,
          'phone': number,
        }));
    return jsonDecode(response.body);
  } catch (e) {
    return {'success': false, 'message': 'error'};
  }
}

Future<Map<String, dynamic>> loginn(String password, String email) async {
  try {
    var url = Uri.parse('https://8879-156-199-11-154.ngrok-free.app/login');
    var response = await http.post(url,
        body: jsonEncode({
          'email': email,
          'pw': password,
        }));
    return jsonDecode(response.body);
  } catch (e) {
    return {'success': false, 'message': 'error'};
  }
}

Future<Map<String, dynamic>> forgetpw(String email) async {
  try {
    var url =
        Uri.parse('https://8879-156-199-11-154.ngrok-free.app/forget_pw1');
    var response = await http.post(url,
        body: jsonEncode({
          'email': email,
        }));
    return jsonDecode(response.body);
  } catch (e) {
    return {'success': false, 'message': 'error'};
  }
}

Future<Map<String, dynamic>> forgetpw2(String id, String newpas) async {
  try {
    var url =
        Uri.parse('https://8879-156-199-11-154.ngrok-free.app/forget_pw2');
    var response =
        await http.post(url, body: jsonEncode({'id': id, 'new_pw': newpas}));
    return jsonDecode(response.body);
  } catch (e) {
    return {'success': false, 'message': 'error'};
  }
}
