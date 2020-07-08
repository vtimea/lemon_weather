import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:http/http.dart' as http;
import 'package:lemonweather/api/api_keys.dart';
import 'package:lemonweather/api/weather_api.dart';
import 'package:lemonweather/model/current_style.dart';
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
  CurrentStyle state;

  @override
  Widget build(BuildContext context) {
    if (currentWeather == null) {
      loadWeather()
          .then((value) => currentWeather = value)
          .whenComplete(() => setState(() {}));
    }
    state = CurrentStyle.getTimeState(DateTime.now());
    return DefaultTextStyle(
        style: TextStyle(shadows: <Shadow>[
          Shadow(
              offset: Offset(0.0, 0.0),
              blurRadius: 10,
              color: state.color.withAlpha(150))
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
              TemperatureRow(getTemperature(), getWeatherId()),
              SizedBox(height: 15),
              Text(
                currentCity,
                style: new TextStyle(fontSize: 25),
              ),
              SizedBox(height: 15),
              TemperatureDescRow(getDescription(), getFeeling())
            ])));
  }

  Future<Weather> loadWeather() {
    final weatherApi = WeatherApiClient(
        httpClient: http.Client(), apiKey: ApiKey.OPEN_WEATHER_API_KEY);
    return weatherApi.getCurrentWeather(currentCity);
  }

  String getGreeting() {
    return CurrentStyle.getTimeState(DateTime.now()).greeting;
  }

  String getTemperature() {
    if (currentWeather != null) {
      return currentWeather.temperature.round().toString();
    }
    return '-';
  }

  String getWeatherId() {
    if (currentWeather != null) {
      return currentWeather.id.toString();
    }
    return '800';
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
}

class TemperatureRow extends StatelessWidget {
  final String temp;
  final String weatherId;

  TemperatureRow(this.temp, this.weatherId);

  @override
  Widget build(BuildContext context) {
    CurrentStyle state = CurrentStyle.getTimeState(DateTime.now());
    return Container(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: EdgeInsets.only(right: 5, top: 20),
                    child: Image(
                        width: 40,
                        alignment: Alignment.center,
                        image: AssetImage(
                            '${CurrentStyle.base}/${Weather.getWeatherIcon(
                                weatherId)}'),
                        color: Colors.white))),
            GradientText(
              temp,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.white]),
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 100),
            ),
            Padding(
                padding: EdgeInsets.only(top: 15),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: GradientText(
                      '°C',
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Colors.white]),
                      style: new TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    )))
          ],
        ));
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
