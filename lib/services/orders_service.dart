import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:driver_app/models/models.dart';

class OrdersService extends ChangeNotifier {
  final String _baseUrl = "10.28.1.96:8000";
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

  Future<String?> deliverOrder(Order order) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.http(
      _baseUrl,
      'api/orders/${order.id}/deliver',
    );
    final resp = await http.put(url, headers: {
      HttpHeaders.authorizationHeader:
          'Bearer ${await storage.read(key: 'token')}',
    });

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    isLoading = false;
    notifyListeners();

    if (decodedResp.containsKey('error')) {
      return decodedResp['error'];
    } else {
      return null;
    }
  }

  // reset orders
  void resetOrders() {
    orders.clear();
    notifyListeners();
  }
}
