import 'package:another_flutter_helper/another_flutter_helper.dart';
import 'package:another_flutter_helper/src/geolocator/geolocator_instance.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorInstanceImpl implements GeolocatorInstance {
  @override
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<GeolocatorPosition?> getCurrentPosition() async {
    final Position position = await Geolocator.getCurrentPosition();
    return GeolocatorPosition(position);
  }

  @override
  Future<GeolocatorPosition?> getLastKnownPosition() async {
    final Position? position = await Geolocator.getLastKnownPosition();
    return GeolocatorPosition(position);
  }

  @override
  Future<GeolocatorPosition?> getPositionStream() async {
    Position? position;
    Stream<Position> positionStream = Geolocator.getPositionStream();
    await for (Position p in positionStream) {
      position = p;
      break;
    }
    return GeolocatorPosition(position);
  }

  /// Return the distance in meters between two coordinates.
  @override
  Future<double> distanceBetween({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) async {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  @override
  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  @override
  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }
}
