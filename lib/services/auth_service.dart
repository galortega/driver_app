import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = "http://localhost:8000/api";

  Future<String> login(String code) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/login"),
      body: json.encode({
        "code": code,
      }),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Failed to login");
    }
  }
}
