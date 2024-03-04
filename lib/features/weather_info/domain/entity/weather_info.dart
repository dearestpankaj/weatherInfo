import 'dart:ffi';

class WeatherInfo {
  String mainTitle;
  String mainTitleDescription;
  double? temp;
  double? tempMax;
  double? tempMin;
  int? humidity;
  int? pressure;
  double? windSpeed;
  String iconURL;
  String date;

  WeatherInfo(
      {required this.mainTitle,
      required this.mainTitleDescription,
      required this.temp,
      required this.tempMax,
      required this.tempMin,
      required this.humidity,
      required this.pressure,
      required this.windSpeed,
      required this.iconURL,
      required this.date});
}
