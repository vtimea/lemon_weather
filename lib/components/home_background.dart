import 'package:flutter/material.dart';
import 'package:lemonweather/model/time_state.dart';

class HomeBackground extends StatelessWidget {
  static const String base = 'graphics';
  static const String BG_NIGHT = '$base/background_night.jpg';
  static const String BG_SUNRISE = '$base/background_sunrise.jpg';
  static const String BG_SUNSET = '$base/background_sunset.jpg';
  static const String BG_DAY = '$base/background_day.jpg';

  static const int NIGHT_END = 21;
  static const int NIGHT_START = 5;
  static const int SUNRISE_START = 6;
  static const int SUNRISE_END = 9;
  static const int DAY_START = 10;
  static const int DAY_END = 17;

  @override
  Widget build(BuildContext context) {
    return Image(
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        image: AssetImage(getCurrentAsset()));
  }

  String getCurrentAsset() {
    return CurrentStyle.getTimeState(DateTime.now()).background;
  }
}
