import 'dart:convert';
import 'package:flutter/services.dart';

class AuthService {
  Future<Map<String, dynamic>?> login(String username, String password) async {
    final data = await rootBundle.loadString('lib/data/users.json');
    final users = jsonDecode(data) as List;

    for (final user in users) {
      if (user['username'] == username && user['password'] == password) {
        return user;
      }
    }
    return null;
  }
}
