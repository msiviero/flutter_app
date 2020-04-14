import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_learning/state/login_objects.dart';
import 'package:http/http.dart' as http;

class LoginState with ChangeNotifier {
  var _loggedIn = false;

  Future<LoginResponse> login(String email, String password) async {
    final http.Response response = await http.post(
      "https://jsonplaceholder.typicode.com/users",
      body: jsonEncode(LoginRequest(email: email, password: password).toJson()),
    );

    if (response.statusCode == 201) {
      _loggedIn = true;
      notifyListeners();
      return LoginResponse(token: "abcd");
    } else {
      throw LoginHttpRequestException(
        code: response.statusCode,
        message: response.body,
      );
    }
  }

  void logout() {
    _loggedIn = false;
    notifyListeners();
  }

  bool loggedIn() => _loggedIn;
}

class LoginHttpRequestException implements Exception {
  final int code;
  final String message;

  LoginHttpRequestException({@required this.code, @required this.message});
}
