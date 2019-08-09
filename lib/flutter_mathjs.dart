import 'dart:async';

import 'package:flutter/services.dart';

class Mathjs {
  static const MethodChannel _channel =
      const MethodChannel('flutter_mathjs');

  static Future<String> eval(String exp) async {
    final String result = await _channel.invokeMethod('eval',{'exp':exp});
    return result;
  }
}
