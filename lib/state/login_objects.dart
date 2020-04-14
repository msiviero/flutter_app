import 'package:flutter/material.dart';
import "package:json_annotation/json_annotation.dart";

part "login_objects.g.dart";

@JsonSerializable()
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({this.email, this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class LoginResponse {
  final String token;

  LoginResponse({this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

class LoginInfo {
  final String token;
  final bool loggedIn;

  LoginInfo({
    @required this.loggedIn,
    @required this.token,
  });
}
