# flutter_mathjs

Flutter plugin to use mathjs parser.

## Getting Started
- Depend on this plugin
  ```yaml
  dependencies:
    flutter_mathjs: ^0.0.2
  ```
  don't forget to run `flutter pub get`.
- Import it.
  ```dart
  import 'package:flutter_mathjs/flutter_mathjs.dart';
  ```
- Use it.
  ```dart
  /// evaluate an expression
  Mathjs.eval("simplify("2x + x")");  // 3 * x
  Mathjs.eval("derivative("2x^2 + 3x + 4", "x")"); // 4 * x + 3
  Mathjs.eval("5cm + 0.2 m in inch"); // 9.8425196850394 inch
  Mathjs.eval("100 degC to fahrenheit"); // 211.99999999999994 fahrenheit


  /// formatted result
  Mathjs.format("100 degC to fahrenheit", ValueFormat(
      "precision": 14,
    ),
  ); // 212 fahrenheit

  /// clear all saved variable and function
  Mathjs.clear();
  ```

  NOTE : Work for android only