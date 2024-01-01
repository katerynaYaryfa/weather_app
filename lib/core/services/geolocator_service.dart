import 'package:geolocator/geolocator.dart';

class GeoLocatorService {
  Future<void> requestPermission() async {
    await Geolocator.requestPermission();
  }

  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
  }
}
