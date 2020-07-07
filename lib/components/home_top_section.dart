import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:http/http.dart' as http;
import 'package:lemonweather/api/api_keys.dart';
import 'package:lemonweather/api/weather_api.dart';
import 'package:lemonweather/model/time_state.dart';
import 'package:lemonweather/model/weather.dart';

class HomeCurrentWeather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CurrentWeatherState();
  }
}

class _CurrentWeatherState extends State<HomeCurrentWeather> {
  static const String currentCity = 'Budapest';
  Weather currentWeather;
  TimeState state;

  @override
  Widget build(BuildContext context) {
    if (currentWeather == null) {
      loadWeather()
          .then((value) => currentWeather = value)
          .whenComplete(() => setState(() {}));
    }
    state = TimeState.getTimeState(DateTime.now());
    return DefaultTextStyle(
        style: TextStyle(shadows: <Shadow>[
          Shadow(
              offset: Offset(1.5, 1.5),
              blurRadius: 5,
              color: Color.fromARGB(150, 120, 217, 255))
        ], color: Colors.white, decoration: TextDecoration.none),
        child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 10,
                left: 20,
                right: 20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    getGreeting(),
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  )),
              SizedBox(height: 70),
              TemperatureRow(getTemperature()),
              Text(
                currentCity,
                style: new TextStyle(fontSize: 25),
              ),
              SizedBox(height: 15),
              TemperatureDescRow(getDescription(), getFeeling())
            ])));
  }

  String getGreeting() {
    return TimeState.getTimeState(DateTime.now()).greeting;
  }

  String getTemperature() {
    if (currentWeather != null) {
      return currentWeather.temperature.round().toString();
    }
    return '-';
  }

  String getDescription() {
    if (currentWeather != null) {
      return currentWeather.description;
    }
    return '';
  }

  int getFeeling() {
    if (currentWeather != null) {
      return currentWeather.tempFeelsLike.round();
    }
    return 0;
  }

  Future<Weather> loadWeather() {
    final weatherApi = WeatherApiClient(
        httpClient: http.Client(), apiKey: ApiKey.OPEN_WEATHER_API_KEY);
    return weatherApi.getCurrentWeather(currentCity);
  }
}

class TemperatureRow extends StatelessWidget {
  final String temp;

  TemperatureRow(this.temp);

  @override
  Widget build(BuildContext context) {
    TimeState state = TimeState.getTimeState(DateTime.now());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GradientText(
          temp,
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white60, Colors.white]),
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 100),
        ),
        GradientText(
          '°C',
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white60, Colors.white]),
          style: new TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class TemperatureDescRow extends StatelessWidget {
  final String desc;
  final int feels;

  TemperatureDescRow(this.desc, this.feels);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(desc),
        Padding(
            padding: EdgeInsets.only(left: 10, right: 10), child: Text('•')),
        Text('Feels like $feels')
      ],
    );
  }
}
