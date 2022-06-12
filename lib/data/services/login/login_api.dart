import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:profile/constants/paths.dart';
import 'package:profile/constants/storage.dart';



class LoginNetworkService {
  login(String phoneNumber, String password) async {
    final response = await http.post(Uri.parse('$BASE_URL/token/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone_number": phoneNumber, "password": password}));
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      await storage.write(key: 'token', value: jsonResponse['access']);
    }
    print(response);
    return response;
  }
}