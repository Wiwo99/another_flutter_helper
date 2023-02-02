import 'dart:io';

import 'package:another_flutter_helper/src/app_tracking/app_tracking_instance.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';

class AppTrackingInstanceImpl implements AppTrackingInstance {
  /// Returns the current status of the user's permission to track the user or their device.
  ///
  /// If the user has not yet been asked for permission, this will return [AppTrackingStatus.notDetermined].
  ///
  /// If the user has denied permission, this will return [AppTrackingStatus.denied].
  ///
  /// If the user has authorized permission, this will return [AppTrackingStatus.authorized].
  ///
  /// If the user is restricted from tracking, this will return [AppTrackingStatus.restricted].
  ///
  /// If the platform is not iOS or the iOS version is below 14.0, this will return [AppTrackingStatus.notSupported].
  @override
  Future<AppTrackingStatus> get status async {
    final TrackingStatus trackingStatus =
        await AppTrackingTransparency.trackingAuthorizationStatus;

    return AppTrackingStatus.values
        .firstWhere((element) => element == trackingStatus);
  }

  /// Requests permission to track the user or their device.
  ///
  /// If the user has already been asked for permission, this will return the current status.
  ///
  /// If the user has not yet been asked for permission, this will show the permission dialog.
  @override
  Future<AppTrackingStatus?> request() async {
    bool isIos = defaultTargetPlatform == TargetPlatform.iOS;
    bool isIos14 =
        isIos && int.parse(Platform.operatingSystemVersion.split('.')[0]) >= 14;

    if (isIos) {
      if (!isIos14) {
        return AppTrackingStatus.notSupported;
      }

      final TrackingStatus trackingStatus =
          await AppTrackingTransparency.requestTrackingAuthorization();

      return AppTrackingStatus.values
          .firstWhere((element) => element == trackingStatus);
    }
    return null;
  }

  /// Returns the advertising identifier for the device.
  ///
  /// The advertising identifier is a unique, non-resettable identifier for a device.
  ///
  /// If the user has limited ad tracking enabled, the advertising identifier will be all zeros.
  ///
  /// If the user has not yet been asked for permission to track, this will return null.
  @override
  Future<String> get identifier =>
      AppTrackingTransparency.getAdvertisingIdentifier();
}
