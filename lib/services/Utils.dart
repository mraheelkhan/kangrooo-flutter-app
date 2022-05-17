import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:kangrooo/services/StayTimer.dart';
class Utils {
  late String deviceName;
  Future<String> getDeviceName() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model!;

      } else if (Platform.isIOS) {
        var build = await deviceInfoPlugin.iosInfo;
        deviceName = build.model!;
      }
    } on PlatformException {
      deviceName = 'Failed to get platform version';
    }
    return deviceName;
  }
}