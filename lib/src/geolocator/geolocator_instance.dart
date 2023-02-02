import 'package:another_flutter_helper/another_flutter_helper.dart';

abstract class GeolocatorInstance {
  Future<bool> isLocationServiceEnabled();

  Future<GeolocatorPosition?> getCurrentPosition();

  Future<GeolocatorPosition?> getLastKnownPosition();

  Future<GeolocatorPosition?> getPositionStream();

  Future<double> distanceBetween({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  });

  Future<void> openAppSettings();

  Future<void> openLocationSettings();
}
