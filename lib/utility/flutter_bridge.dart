import 'package:flutter/services.dart';
import 'package:tianyue/utility/toast.dart';

class FlutterBridge{

  static const platform = const MethodChannel('samples.flutter.io/battery');

  static Future<Null> getBatteryLevel() async {
    String batteryLevel;
    try {
      var result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result %';
      Toast.show(batteryLevel);
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
  }

  static Future<Null> goAboutActivity() async {
    try {
      platform.invokeMethod('goAboutActivity');
    } on PlatformException catch (e) {
      Toast.show(e.toString());
    }
  }

}