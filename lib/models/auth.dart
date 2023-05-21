import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {

  static const baseUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:';
  static const apiKey = 'key=AIzaSyC4_8tA14-0fzrAwamvlz6qSvsJRlEXKPo';
  
  Future<void> authenticate(String email, String password, String urlFragment) async {
    final response = await http.post(
      Uri.parse('$baseUrl$urlFragment?$apiKey'),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true
      }));

      print(jsonDecode(response.body));
  }

  Future<void> signInWithPassword(String email, String password) async {
    authenticate(email, password, 'signInWithPassword');
  }

    Future<void> signUp(String email, String password) async {
    authenticate(email, password, 'signUp');
  }


}
