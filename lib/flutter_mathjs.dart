import 'dart:async';

import 'package:flutter/services.dart';
import 'documentation.dart';

class Mathjs {
  static const MethodChannel _channel = const MethodChannel('flutter_mathjs');

  /// evaluate the given expression form `math.parser().evaluate()`
  static Future<String> eval(String exp) async {
    final String result = await _channel.invokeMethod('eval', {'exp': exp});
    return result;
  }

  /// Clear all saved function and variable created by eval method from `math.parser().clear()`
  static Future<Null> clear() async {
    await _channel.invokeMethod('clear');
  }

  /// Returns a formatted value of evaluated expression.
  ///
  /// ```dart
  /// Mathjs.format( expr , ValueFormat(
  ///     notation: "fixed",
  ///     lowExp: -3,
  ///     upperExp:3,
  ///     fraction: "decimal"
  ///   ),
  /// )
  /// ```
  static Future<String> format(String expr, ValueFormat format) async {
    return await _channel
        .invokeMethod("format", {"exp": expr, "format": format.toMap()});
  }

  /// Return a JSON documentation
  static Future<Documentation> help(String func) async {
    Documentation doc = documentationFromJson(
        await _channel.invokeMethod("help", {"func": func}));
    return doc;
  }
}

class ValueFormat {
  /// A number between 0 and 16 to round the digits of the number
  int precision;

  /// Number notation
  String notation;

  //  Available values: ‘ratio’ (default) or ‘decimal’.
  String fraction;

  /// Exponent determining the lower boundary for formatting a value with an exponent when `notation=auto`. Default value is -3.
  int lowExp;

  /// Exponent determining the upper boundary for formatting a value with an exponent when `notation='auto`. Default value is 5.
  int upperExp;

  ValueFormat({
    this.precision,
    this.notation,
    this.fraction,
    this.lowExp,
    this.upperExp,
  });

  factory ValueFormat.fromMap(Map<String, dynamic> map) => new ValueFormat(
        precision: map["precision"],
        notation: map["notation"],
        fraction: map["fraction"],
        lowExp: map["lowExp"],
        upperExp: map["upperExp"],
      );

  Map<String, dynamic> toMap() => {
        "precision": precision,
        "notation": notation,
        "fraction": fraction,
        "lowExp": lowExp,
        "upperExp": upperExp,
      };
}
