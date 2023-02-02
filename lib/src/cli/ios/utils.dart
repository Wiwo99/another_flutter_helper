// ignore_for_file: avoid_print

import 'dart:io';

/// Return line postion of a value in a file
///
/// If the value is not found, return -1
int lineOfInfoPlist(String valueToFind) {
  final Directory current = Directory.current;
  final String iosInfoPlistDir = '${current.path}/ios/Runner/Info.plist';
  final File file = File(iosInfoPlistDir);
  final lines = file.readAsLinesSync();
  for (var i = 0; i < lines.length; i++) {
    if (lines[i].contains(valueToFind)) {
      return i + 1;
    }
  }
  return -1;
}

/// Insert a line in ios/Runner/Info.plist
///
/// The line is inserted after the line <key>CFBundleShortVersionString</key>
///
/// Example:
///
/// <key>NSLocationWhenInUseUsageDescription</key>
///
/// <string>$(PRODUCT_NAME) would like to use your location</string>
///
/// _insertLineInIos('NSLocationWhenInUseUsageDescription', '<string>$(PRODUCT_NAME) would like to use your location</string>');
///
void insertLineInIos(String key, String value) {
  final Directory current = Directory.current;
  final String iosInfoPlistDir = '${current.path}/ios/Runner/Info.plist';
  final File file = File(iosInfoPlistDir);
  final List<String> lines = file.readAsLinesSync();
  final int line = lineOfInfoPlist('<key>CFBundleShortVersionString</key>');
  lines.insert(line + 1, ' <key>$key</key> ');
  lines.insert(line + 2, value);

  file.writeAsStringSync(lines.join('\n'));
}

/// Add a permission in ios/Runner/Info.plist
///
/// If the permission is already added, it will not be added again

void addPermissionInIos(String key, String value) {
  final int line = lineOfInfoPlist(key);
  if (line == -1) {
    insertLineInIos(key, value);
    print('Added $key permission to ios/Runner/Info.plist');
  } else {
    print('$key permission already added to ios/Runner/Info.plist');
  }
}
