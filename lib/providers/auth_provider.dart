import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  late String _code;

  String get code => _code;

  set code(String value) {
    _code = value;
    notifyListeners();
  }
}
