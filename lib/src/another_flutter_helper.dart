import 'package:another_flutter_helper/src/app_tracking/app_tracking_instance.dart';
import 'package:another_flutter_helper/src/app_tracking/app_tracking_instance_impl.dart';
import 'package:another_flutter_helper/src/geolocator/geolocator_instance.dart';
import 'package:another_flutter_helper/src/geolocator/geolocator_instance_impl.dart';
import 'package:another_flutter_helper/src/http/http_instance.dart';
import 'package:another_flutter_helper/src/storage/storage_instance.dart';
import 'package:another_flutter_helper/src/storage/storage_instance_impl.dart';
import 'package:get_it/get_it.dart';

import 'http/http_instance_impl.dart';

/// A helper class to initialize all the instances of the other classes.
///
/// This class is used to initialize all the instances of the other classes.
///
/// Example:
///
/// ```dart
/// final AnotherFlutterHelper anotherFlutterHelper = AnotherFlutterHelper();
///
/// void main() {
///   WidgetsFlutterBinding.ensureInitialized();
///   anotherFlutterHelper.init();
///   runApp(const MyApp());
/// }
///
/// ```

class AnotherFlutterHelper {
  final GetIt _getIt = GetIt.instance;

  final GeolocatorInstance _geolocatorInstance = GeolocatorInstanceImpl();
  final AppTrackingInstance _appTrackingInstance = AppTrackingInstanceImpl();
  final StorageInstance _storageInstance = StorageInstanceImpl();
  final HttpInstance _httpInstance = HttpInstanceImpl();

  AppTrackingInstance get appTrackingInstance => _getIt<AppTrackingInstance>();

  GeolocatorInstance get geolocatorInstance => _getIt<GeolocatorInstance>();

  StorageInstance get storageInstance => _getIt<StorageInstance>();

  HttpInstance get httpInstance => _getIt<HttpInstance>();

  void init() {
    _getIt.registerSingleton<GeolocatorInstance>(_geolocatorInstance);
    _getIt.registerSingleton<AppTrackingInstance>(_appTrackingInstance);
    _getIt.registerSingleton<StorageInstance>(_storageInstance);
    _getIt.registerSingleton<HttpInstance>(_httpInstance);
  }

  void setEncryptionKey(String key) {
    _storageInstance.setEncryptionKey(key);
  }
}
