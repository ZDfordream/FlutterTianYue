import 'package:flutter/services.dart';
import 'package:tianyue/utility/toast.dart';

class FlutterBridge{

  static const _platform = const MethodChannel('samples.flutter.io/battery');

  static Future<void> getBatteryLevel() async {
    String batteryLevel;
    try {
      var result = await _platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result %';
      Toast.show(batteryLevel);
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
  }

  static Future<void> goAboutActivity() async {
    try {
      _platform.invokeMethod('goAboutActivity');
    } on PlatformException catch (e) {
      Toast.show(e.toString());
    }
  }

}