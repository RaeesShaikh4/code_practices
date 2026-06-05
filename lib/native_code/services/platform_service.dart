import 'package:flutter/services.dart';

class PlatformService {
  static const MethodChannel _androidChannel = MethodChannel('com.example/platform');

  Future<String?> getPlatformVersion() async {
    try {
      final String version = await _androidChannel.invokeMethod('getPlatformVersion');
      return version;
    } on PlatformException catch (e) {
      print("Failed to get platform version: '${e.message}'.");
      return 'Unknown';
    }
  }

  Future<void> showToast(String message) async {
    try {
      await _androidChannel.invokeMethod('showToastonTap', {
        'message': message
      });
    } catch (e) {
      print("Failed to show toast: $e");
    }
  }
}
