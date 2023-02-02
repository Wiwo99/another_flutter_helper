import 'dart:convert';

import 'package:another_flutter_helper/src/storage/storage_instance.dart';
import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageInstanceImpl extends StorageInstance {
  late SharedPreferences sharedPreferences;
  String? _encryptionKey;

  final IV _iv = IV.fromLength(16);

  StorageInstanceImpl() {
    _onInit();
  }

  Encrypter get encrypter => Encrypter(AES(Key.fromUtf8(_encryptionKey!)));

  @override
  void clear() {
    sharedPreferences.clear();
  }

  @override
  bool containsKey(String key) {
    return sharedPreferences.containsKey(key);
  }

  @override
  void delete(String key) {
    sharedPreferences.remove(key);
  }

  @override
  Map<String, dynamic> get(String key) {
    final String? value = sharedPreferences.getString(key);

    if (value == null) {
      return <String, dynamic>{};
    }

    return jsonDecode(encrypter.decrypt64(value, iv: _iv))
        as Map<String, dynamic>;
  }

  @override
  Map<String, dynamic> getAll() {
    final Map<String, dynamic> all = <String, dynamic>{};

    sharedPreferences.getKeys().forEach((String key) {
      all[key] = {
        'key': key,
        'value': get(key),
      };
    });

    return all;
  }

  @override
  Future<void> reload() {
    return sharedPreferences.reload();
  }

  @override
  void set(String key, Map<String, dynamic> value) {
    final String encryptedValue =
        encrypter.encrypt(jsonEncode(value), iv: _iv).base64;
    sharedPreferences.setString(key, encryptedValue);
  }

  @override
  void setEncryptionKey(String key) {
    _encryptionKey = key;
  }

  Future<void> _onInit() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
