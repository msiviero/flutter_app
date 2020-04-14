import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_learning/state/login_objects.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginState with ChangeNotifier {
  final Client _httpClient;

  LoginState(this._httpClient);

  Future<void> login(String email, String password) async {
    const timeout = 5000;
    try {
      final response = await _httpClient
          .post(
            "https://jsonplaceholder.typicode.com/users",
            body: jsonEncode(
              LoginRequest(
                email: email,
                password: password,
              ).toJson(),
            ),
          )
          .timeout(const Duration(milliseconds: timeout));
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
    } on TimeoutException {
      throw LoginHttpRequestException(
          message: "Login request timed out [ms=$timeout");
    } catch (error) {
      throw LoginHttpRequestException(
        message:
            "Generic error: [msg=${error.message} class=${error.runtimeType}]",
      );
    }
  }

  Future<LoginInfo> getLoginInfo() async {
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
    @required this.message,
    this.code = 0,
  });

  @override
  String toString() {
    return "{code=$code message=$message}";
  }
}
