# flutter_mathjs

Flutter plugin to use mathjs using [liquidcore](https://github.com/LiquidPlayer/LiquidCore/). Curently work from android only


> I create this plugin for my own app. so only some necesary function that I implemented, if you need more function from Mathjs, you can just open an issue and I will try to add it if I have time. Or you can simply make a pull request, add new function and fix my messy code.


## Getting Started
### Depend on this plugin
```yaml
dependencies:
  flutter_mathjs: any
```
don't forget to run `flutter pub get`.

### Import it.
  ```dart
  import 'package:flutter_mathjs/flutter_mathjs.dart';
  ```
### Use it.
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

/// get a documentation of a function
Mathjs.help("log");

/// it will return Documentation object
//{
//  "name": "log",
//  "category": "Arithmetic",
//  "syntax": [
//    "log(x)",
//    "log(x, base)"
//  ],
//  "description": "Compute the logarithm of a value. If no base is provided, the natural logarithm of x is calculated. If base if provided, the logarithm is calculated for the specified base. log(x, base) is defined as log(x) / log(base).",
//  "examples": [
//    "log(3.5)",
//    "a = log(2.4)",
//    "exp(a)",
//    "10 ^ 4",
//    "log(10000, 10)",
//    "log(10000) / log(10)",
//    "b = log(1024, 2)",
//    "2 ^ b"
//  ],
//  "seealso": [
//    "exp",
//    "log1p",
//    "log2",
//    "log10"
//  ],
//  "mathjs": "Help"
//}
```

