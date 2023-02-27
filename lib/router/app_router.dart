import 'package:driver_app/services/orders_service.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/screens/screens.dart';
import 'package:provider/provider.dart';

class AppRoutes {
  static const initialRoute = 'login';
  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (BuildContext context) => LoginPage(),
    'orders': (BuildContext context) => OrdersPage(),
    'order': (BuildContext context) {
      final ordersService = Provider.of<OrdersService>(context);
      return OrderDetails(order: ordersService.selectedOrder);
    },
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const AlertScreen(),
    );
  }
}
