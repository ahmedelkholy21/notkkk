import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String,dynamic>> createaccount(
    String username, String password, String email, String number) async {
  var url =
      Uri.parse('https://8879-156-199-11-154.ngrok-free.app/create_account');
  var response = await http.post(url, body: jsonEncode( {
    'name': username,
    'email': email,
    'pw': password,
    'phone': number,
  }));
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  return jsonDecode(response.body);
}

Future<Map<String,dynamic>> loginn(
     String password, String email) async {
  var url =
      Uri.parse('https://8879-156-199-11-154.ngrok-free.app/login');
  var response = await http.post(url, body: jsonEncode( {
     'email': email,
    'pw': password,
   }));
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  return jsonDecode(response.body);
}


Future<Map<String,dynamic>> forgetpw(
      String email) async {
  var url =
      Uri.parse('https://8879-156-199-11-154.ngrok-free.app/forget_pw1');
  var response = await http.post(url, body: jsonEncode( {
     'email': email,
   }));
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  return jsonDecode(response.body);
}
Future<Map<String,dynamic>> forgetpw2(
      String id,String newpas) async {
  var url =
      Uri.parse('https://8879-156-199-11-154.ngrok-free.app/forget_pw2');
  var response = await http.post(url, body: jsonEncode( {
     'id': id,
     'new_pw':newpas
   }));
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  return jsonDecode(response.body);
}