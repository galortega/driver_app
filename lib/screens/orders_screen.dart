import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // for date formatting
import 'package:driver_app/services/orders_service.dart';
import 'package:driver_app/screens/loading_screen.dart';

class OrdersPage extends StatelessWidget {
  final TextEditingController codeController = TextEditingController();

  OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersService = Provider.of<OrdersService>(context);
    if (ordersService.isLoading) return const LoadingScreen();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Orders Page'),
        ),
        body:
            // add a ListView here
            ordersService.orders.isEmpty
                ? const Center(child: Text('No orders yet'))
                : ListView.builder(
                    itemCount: ordersService.orders.length,
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                            onTap: () {
                              ordersService.selectedOrder =
                                  ordersService.orders[index];
                              Navigator.pushNamed(context, 'order');
                            },
                            child: ListTile(
                              title: Text(
                                  "Order ${ordersService.orders[index].copy().id}"),
                              subtitle: Text(
                                  'Created at ${DateFormat('dd/MM/yyyy, HH:mm').format(DateTime.fromMillisecondsSinceEpoch(ordersService.orders[index].copy().createdAt * 1000))}'),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            )),
                  ));
  }
}
