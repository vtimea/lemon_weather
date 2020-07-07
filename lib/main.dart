import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lemonweather/api/api_keys.dart';
import 'package:lemonweather/api/weather_api.dart';
import 'package:lemonweather/components/home_background.dart';
import 'package:lemonweather/model/weather.dart';

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
  Weather currentWeather;

  String getCurrentTemperature() {
    if (currentWeather != null) {
      return currentWeather.description;
    }
    return "No data.";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Stack(children: <Widget>[
        HomeBackground(),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
              child: FlatButton(
                  onPressed: () {
                    getWeather()
                        .then((value) => currentWeather = value)
                        .whenComplete(() => setState(() {}));
                  },
                  child: Text('Get weather'))),
          Center(
            child: new DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyText1,
                child: Text(getCurrentTemperature())),
          ),
        ])
      ]),
    );
  }

  Future<Weather> getWeather() {
    final weatherApi = WeatherApiClient(
        httpClient: http.Client(), apiKey: ApiKey.OPEN_WEATHER_API_KEY);
    return weatherApi.getCurrentWeather("Budapest");
  }
}
