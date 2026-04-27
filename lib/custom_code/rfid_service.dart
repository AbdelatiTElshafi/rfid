import 'package:flutter/services.dart';

class RFIDService {
  static const MethodChannel _channel = MethodChannel('rfid_channel');

  static Future<bool> connectRFID() async {
    final bool? result = await _channel.invokeMethod<bool>('connectRFID');
    return result ?? false;
  }

  static Future<bool> startScan() async {
    final bool? result = await _channel.invokeMethod<bool>('startScan');
    return result ?? false;
  }

  static Future<bool> stopScan() async {
    final bool? result = await _channel.invokeMethod<bool>('stopScan');
    return result ?? false;
  }

  static Future<bool> disableRFID() async {
    final bool? result = await _channel.invokeMethod<bool>('disableRFID');
    return result ?? false;
  }

  static Future<bool> disconnectRFID() async {
    final bool? result = await _channel.invokeMethod<bool>('disconnectRFID');
    return result ?? false;
  }

  static void setTagReadListener(Function(List<String> tags) onTagsRead) {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onTagRead') {
        final args = call.arguments;

        List<String> tags = [];

        if (args is List) {
          tags = args.map((e) => e.toString()).toList();
        } else if (args is String) {
          tags = [args];
        } else if (args != null) {
          tags = [args.toString()];
        }

        onTagsRead(tags);
      }
    });
  }
}
