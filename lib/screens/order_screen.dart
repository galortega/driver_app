import 'package:driver_app/services/orders_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:driver_app/models/models.dart';
import 'package:driver_app/services/driver_location_service.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatefulWidget {
  final Order order;

  const OrderDetails({Key? key, required this.order}) : super(key: key);

  @override
  OrderDetailsState createState() => OrderDetailsState();
}

class OrderDetailsState extends State<OrderDetails> {
  LatLng _driverLocation = const LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _loadDriverLocation();
  }

  Future<void> _loadDriverLocation() async {
    final driverLocationService = DriverLocationService();

    // Call the service to get the current driver location
    final driverLocation = await driverLocationService.getCurrentLocation();

    // Set the driver location state
    setState(() {
      _driverLocation =
          LatLng(driverLocation.latitude, driverLocation.longitude);
    });
  }

  Future<String?> _deliverOrder() async {
    final ordersService = Provider.of<OrdersService>(context, listen: false);
    final resp = await ordersService.deliverOrder(widget.order);
    ordersService.resetOrders();
    ordersService.loadOrders();
    return resp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          _deliverOrder().then((resp) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(resp != null ? 'Error' : 'Success'),
                  content: Text(resp ?? 'Order delivered'),
                  actions: [
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'orders', (route) => false);
                      },
                    ),
                  ],
                );
              },
            );
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Origin:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Latitude: ${widget.order.originLat.toString()}'),
            Text('Longitude: ${widget.order.originLng.toString()}'),
            const SizedBox(height: 16.0),
            const Text(
              'Destination:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Latitude: ${widget.order.destLat.toString()}'),
            Text('Longitude: ${widget.order.destLng.toString()}'),
            const SizedBox(height: 16.0),
            const Text(
              'Current Driver Location:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            _driverLocation.latitude != 0 && _driverLocation.longitude != 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Latitude: ${_driverLocation.latitude.toStringAsFixed(6)}'),
                      Text(
                          'Longitude: ${_driverLocation.longitude.toStringAsFixed(6)}'),
                    ],
                  )
                : const Text('Loading driver location...'),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
