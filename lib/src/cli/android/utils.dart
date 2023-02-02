// ignore_for_file: avoid_print

import 'dart:io';

/// Return line postion of a value in a file
///
/// If the value is not found, return -1
int lineOfAndroidManifest(String valueToFind) {
  final Directory current = Directory.current;
  final String androidManifestDir =
      '${current.path}/android/app/src/main/AndroidManifest.xml';
  final File file = File(androidManifestDir);
  final lines = file.readAsLinesSync();
  for (var i = 0; i < lines.length; i++) {
    if (lines[i].contains(valueToFind)) {
      return i;
    }
  }
  return -1;
}

/// Insert a line in android/app/src/main/AndroidManifest.xml
///
/// The line is inserted after the line <manifest xmlns:android="http://schemas.android.com/apk/res/android" package=
///
/// Example:
///
/// <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
///
/// insertLineInAndroid('ACCESS_FINE_LOCATION');
///
void insertLineInAndroid(String key) {
  final Directory current = Directory.current;
  final String androidManifestDir =
      '${current.path}/android/app/src/main/AndroidManifest.xml';

  final File file = File(androidManifestDir);
  final List<String> lines = file.readAsLinesSync();
  final int line = lineOfAndroidManifest(
      '<manifest xmlns:android="http://schemas.android.com/apk/res/android" package=');
  lines.insert(line + 1, '<uses-permission android:name="$key"/>');

  file.writeAsStringSync(lines.join('\n'));
}

/// Add a permission in android/app/src/main/AndroidManifest.xml
///
/// If the permission is already added, it will not be added again
void addPermissionInAndroid(String key) {
  final int line = lineOfAndroidManifest(key);
  if (line == -1) {
    insertLineInAndroid(key);
    print('Added $key permission to android/app/src/main/AndroidManifest.xml');
  } else {
    print(
        '$key permission already added to android/app/src/main/AndroidManifest.xml');
  }
}
