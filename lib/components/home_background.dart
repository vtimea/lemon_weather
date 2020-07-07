import 'package:flutter/material.dart';

class HomeBackground extends StatelessWidget {
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
    int nowHour = new DateTime.now().hour;
    if (nowHour >= 21 || nowHour <= 5) {
      return 'graphics/background_night.jpg';
    }
    if (nowHour >= 6 && nowHour <= 9) {
      return 'graphics/background_sunrise.jpg';
    }
    if (nowHour >= 10 && nowHour <= 17) {
      return 'graphics/background_day.jpg';
    }
    return 'graphics/background_sunset.jpg';
  }
}
