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
}
