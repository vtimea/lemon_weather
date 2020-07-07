class Weather {
  int id; //  Weather condition id
  String main; //  Group of weather parameters
  String description; //  Weather condition within the group
  String iconId;
  String cityName;

  double temperature;
  double tempFeelsLike;

  Weather(
      {this.id,
      this.main,
      this.description,
      this.iconId,
      this.cityName,
      this.temperature,
      this.tempFeelsLike});

  static Weather fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return Weather(
      id: weather['id'],
      main: weather['main'],
      description: weather['description'],
      iconId: weather['icon'],
      cityName: json['name'],
      temperature: json['main']['temp'],
      tempFeelsLike: json['main']['feels_like'],
    );
  }

  static String getWeatherIcon(String id) {
    String firstChar = id.substring(0, 1);
    switch (firstChar) {
      case '2':
        return '2xx.png';
      case '3':
        return '3xx.png';
      case '5':
        return '5xx.png';
      case '6':
        return '6xx.png';
      case '7':
        return '7xx.png';
      case '8':
        if (id != '800') {
          return '8xx.png';
        }
        return '800.png';
      default:
        return '800.png';
    }
  }
}
