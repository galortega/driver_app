import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = "10.28.1.96:8000";
  final storage = const FlutterSecureStorage();

  Future<String?> login(String code) async {
    final Map<String, dynamic> authData = {
      'code': code,
    };
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent': 'mi-aplicacion-flutter/1.0',
      'X-CSRF-TOKEN': '[token-csrf]',
    };
    final url = Uri.http(_baseUrl, '/api/login');
    final resp =
        await http.post(url, headers: headers, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (decodedResp.containsKey('access_token')) {
      // Token hay que guardarlo en un lugar seguro
      await storage.write(key: 'token', value: decodedResp['access_token']);
      return null;
    } else {
      return decodedResp['error'];
    }
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
