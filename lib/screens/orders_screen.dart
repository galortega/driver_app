import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  final TextEditingController codeController = TextEditingController();

  OrdersPage({super.key});

  final options = ['Order 1', 'Order 2', 'Order 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Page'),
      ),
      body:
          // add a ListView here
          ListView.separated(
              itemBuilder: (context, index) => ListTile(
                    title: Text(options[index]),
                    subtitle: Text('${options[index]} details'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
              separatorBuilder: (_, __) => const Divider(),
              itemCount: options.length),
    );
  }
}
