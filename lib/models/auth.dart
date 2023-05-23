import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_state_store/exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  static const baseUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:';
  static const apiKey = 'key=AIzaSyC4_8tA14-0fzrAwamvlz6qSvsJRlEXKPo';

  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expiryDate;

  bool get isAuth {
    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get userId {
    return isAuth ? _userId : null;
  }

  Future<void> authenticate(
      String email, String password, String urlFragment) async {
    final response = await http.post(Uri.parse('$baseUrl$urlFragment?$apiKey'),
        body: jsonEncode(
            {'email': email, 'password': password, 'returnSecureToken': true}));

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    } else {

      _token = body['idToken'];
      _email = body['email'];
      _userId = body['localId'];
      _expiryDate =
          DateTime.now().add(Duration(seconds: int.parse(body['expiresIn'])));

      notifyListeners();
    }
  }

  Future<void> signInWithPassword(String email, String password) async {
    return authenticate(email, password, 'signInWithPassword');
  }

  Future<void> signUp(String email, String password) async {
    return authenticate(email, password, 'signUp');
  }
}
