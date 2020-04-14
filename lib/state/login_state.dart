import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_learning/state/login_objects.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginState with ChangeNotifier {
  Future<void> login(String email, String password) async {
    final http.Response response = await http.post(
      "https://jsonplaceholder.typicode.com/users",
      body: jsonEncode(LoginRequest(email: email, password: password).toJson()),
    );
    if (response.statusCode == 201) {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString("authToken", "abcd");
      notifyListeners();
    } else {
      throw LoginHttpRequestException(
        code: response.statusCode,
        message: response.body,
      );
    }
  }

  Future<LoginInfo> getLoginInfo() async {
    await http.get("https://jsonplaceholder.typicode.com/users");
    print("Rember to remove me");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = await preferences.get("authToken");
    return LoginInfo(loggedIn: token != null, token: token);
  }

  void logout() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove("authToken");
    notifyListeners();
  }
}

class LoginHttpRequestException implements Exception {
  final int code;
  final String message;

  LoginHttpRequestException({
    @required this.code,
    @required this.message,
  });
}
