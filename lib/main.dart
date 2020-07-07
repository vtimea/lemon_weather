import 'package:flutter/material.dart';
import 'package:lemonweather/components/home_background.dart';
import 'package:lemonweather/components/home_top_section.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(children: <Widget>[
        HomeBackground(),
        HomeCurrentWeather(),
      ]),
    );
  }
}
