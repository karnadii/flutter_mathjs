import 'dart:async';

import 'package:flutter/services.dart';

class Mathjs {
  static const MethodChannel _channel =
      const MethodChannel('flutter_mathjs');


 /// evaluate the given expression
  static Future<String> eval(String exp) async {
    final String result = await _channel.invokeMethod('eval',{'exp':exp});
    return result;
  }

  /// Clear all variable created by eval method
  static Future<String> clear(String exp) async {
    final String result = await _channel.invokeMethod('eval',{'exp':exp});
    return result;
  }
}
