import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_mathjs/flutter_mathjs.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final exprs = [
    '1.2 / (3.3 + 1.7)',
    'a = 5.08 cm + 2 inch',
    'a to inch',
    'sin(90 deg)',
    'f(x, y) = x ^ y',
    'f(2, 3)',
    '100 degC to fahrenheit'
  ];

  Future<List<String>> computeAllExprs() async {
    List<String> results = [];
    for (var e in exprs) {
      results.add(await evaluate(e));
    }
    return results;
  }

  Future<String> evaluate(String expr) async {
    if (await Mathjs.eval("typeOf($expr)") == "Function") {
      return "Function";
    } else if (expr == "clear") {
      await Mathjs.clear();
      return "Data and function cleared";
    } else {
      String resStr;
      try {
        resStr = await Mathjs.format(
            expr,
            ValueFormat(
              precision: 14,
            ));
      } on PlatformException catch (e) {
        resStr = e.message;
        print(e);
      }
      return resStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Stack(
          children: <Widget>[
            FutureBuilder(
              future: computeAllExprs(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error.... ${snapshot.error.toString()}');
                }
                if (!snapshot.hasData) {
                  return Text('Computing....');
                }
                List<String> results = snapshot.data;
                // avoids access to invalid position.
                final length = min(results.length, exprs.length);
                return Container(
                  child: ListView(
                    padding: EdgeInsets.only(bottom: 60),
                    children: <Widget>[
                      for (var i = 0; i < length; i++)
                        ListTile(
                          title: Text(exprs[i]),
                          subtitle: Text(results[i]),
                        )
                    ],
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.blue,
                height: 50,
                child: TextField(
                  textInputAction: TextInputAction.send,
                  onSubmitted: (String expr) async {
                    if (expr != "clear") {
                      exprs.add(expr);
                      setState(() {});
                    } else {
                      await Mathjs.clear();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
