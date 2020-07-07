import 'dart:ui';

class CurrentStyle {
  String greeting;
  String background;
  Color color;

  CurrentStyle(this.greeting, this.background, this.color);

  static CurrentStyle getTimeState(DateTime dateTime) {
    int nowHour = dateTime.hour;
    if (nowHour >= _NIGHT_END || nowHour <= _NIGHT_START) {
      return CurrentStyle(_greetings[_KEY_NIGHT], _backgrounds[_KEY_NIGHT],
          _colors[_KEY_NIGHT]);
    }
    if (nowHour >= _SUNRISE_START && nowHour <= _SUNRISE_END) {
      return CurrentStyle(_greetings[_KEY_MORNING], _backgrounds[_KEY_MORNING],
          _colors[_KEY_MORNING]);
    }
    if (nowHour >= _DAY_START && nowHour <= _DAY_END) {
      return CurrentStyle(
          _greetings[_KEY_DAY], _backgrounds[_KEY_DAY], _colors[_KEY_DAY]);
    }
    return CurrentStyle(_greetings[_KEY_EVENING], _backgrounds[_KEY_EVENING],
        _colors[_KEY_EVENING]);
  }

  static const String _KEY_MORNING = 'morning';
  static const String _KEY_DAY = 'day';
  static const String _KEY_EVENING = 'evening';
  static const String _KEY_NIGHT = 'night';

  static const int _NIGHT_END = 21;
  static const int _NIGHT_START = 5;
  static const int _SUNRISE_START = 6;
  static const int _SUNRISE_END = 9;
  static const int _DAY_START = 10;
  static const int _DAY_END = 17;

  static const Map<String, String> _greetings = {
    _KEY_MORNING: 'Good morning!',
    _KEY_DAY: 'How\'s your day?',
    _KEY_EVENING: 'Good evening!',
    _KEY_NIGHT: 'Good night!'
  };

  static const String _base = 'graphics';
  static const Map<String, String> _backgrounds = {
    _KEY_MORNING: '$_base/background_sunrise.jpg',
    _KEY_DAY: '$_base/background_day.jpg',
    _KEY_EVENING: '$_base/background_sunset.jpg',
    _KEY_NIGHT: '$_base/background_night.jpg'
  };

  static const Map<String, Color> _colors = {
    _KEY_MORNING: Color.fromARGB(255, 191, 103, 90),
    _KEY_DAY: Color.fromARGB(255, 120, 217, 255),
    _KEY_EVENING: Color.fromARGB(255, 240, 130, 86),
    _KEY_NIGHT: Color.fromARGB(255, 25, 195, 255),
  };
}
