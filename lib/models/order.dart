// To parse this JSON data, do
//
//     final order = orderFromMap(jsonString);

import 'dart:convert';

Order orderFromMap(String str) => Order.fromMap(json.decode(str));

String orderToMap(Order data) => json.encode(data.toMap());

class Order {
  Order({
    required this.id,
    required this.originLat,
    required this.originLng,
    required this.destLat,
    required this.destLng,
    required this.createdAt,
    required this.driver,
  });

  int id;
  String originLat;
  String originLng;
  String destLat;
  String destLng;
  int createdAt;
  Driver driver;

  Order copy() => Order(
        id: id,
        originLat: originLat,
        originLng: originLng,
        destLat: destLat,
        destLng: destLng,
        createdAt: createdAt,
        driver: driver,
      );

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        id: json["id"],
        originLat: json["origin_lat"],
        originLng: json["origin_lng"],
        destLat: json["dest_lat"],
        destLng: json["dest_lng"],
        createdAt: json["created_at"],
        driver: Driver.fromMap(json["driver"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "origin_lat": originLat,
        "origin_lng": originLng,
        "dest_lat": destLat,
        "dest_lng": destLng,
        "created_at": createdAt,
        "driver": driver.toMap(),
      };
}

class Driver {
  Driver({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  int id;
  String name;
  String latitude;
  String longitude;

  Driver copy() => Driver(
        id: id,
        name: name,
        latitude: latitude,
        longitude: longitude,
      );

  factory Driver.fromMap(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
      };
}
