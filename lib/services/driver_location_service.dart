import 'package:geolocator/geolocator.dart';

class DriverLocationService {
  Future<Position> getCurrentLocation() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
