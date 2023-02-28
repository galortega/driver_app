import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:driver_app/models/models.dart';

class OrdersService extends ChangeNotifier {
  final String _baseUrl = "192.168.100.30:8000";
  final List<Order> orders = [];
  late Order selectedOrder;

  final storage = const FlutterSecureStorage();

  bool isLoading = true;
  bool isSaving = false;

  OrdersService() {
    loadOrders();
  }

  Future<List<Order>> loadOrders() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.http(
      _baseUrl,
      'api/ordersByDriver',
    );
    final resp = await http.get(url, headers: {
      HttpHeaders.authorizationHeader:
          'Bearer ${await storage.read(key: 'token')}',
    });

    final List<dynamic> ordersList = json.decode(resp.body);
    for (final orderJson in ordersList) {
      final order = Order.fromMap(orderJson);
      orders.add(order);
    }

    isLoading = false;
    notifyListeners();

    return orders;
  }
}
