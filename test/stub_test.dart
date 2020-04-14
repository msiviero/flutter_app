import 'dart:convert';

import 'package:flutter_learning/state/login_objects.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Login objects', () {
    test('value should start at 0', () {
      final request = LoginRequest(
        email: "m.siviero83@gmail.com",
        password: "12345",
      );
      expect(
        jsonEncode(request.toJson()),
        '{"email":"m.siviero83@gmail.com","password":"12345"}',
      );
    });
  });
}
