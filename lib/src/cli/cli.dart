// ignore_for_file: avoid_print

import 'package:another_flutter_helper/src/cli/android/utils.dart';
import 'package:another_flutter_helper/src/cli/ios/utils.dart';

void main(
  List<String> arguments,
) {
  for (var argument in arguments) {
    switch (argument) {
      case 'add-geolocation-permission':
        _addGeolocationPermission();
        break;
      case 'add-tracking-permission':
        _addTrackingPermission();
        break;
      case 'add-all-permissions':
        _addAllPermissions();
        break;
      default:
        print('Unknown argument: $argument');
    }
  }
}

void _addAllPermissions() {
  _addGeolocationPermission();
  _addTrackingPermission();
}

void _addGeolocationPermission() {
  addPermissionInIos('NSLocationWhenInUseUsageDescription',
      r' <string>$(PRODUCT_NAME) would like to use your location</string> ');
  addPermissionInAndroid('android.permission.ACCESS_FINE_LOCATION');
}

void _addTrackingPermission() {
  addPermissionInIos('NSUserTrackingUsageDescription',
      r' <string>$(PRODUCT_NAME) would like to use your tracking</string> ');
}
