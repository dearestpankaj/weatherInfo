import 'package:flutter_dotenv/flutter_dotenv.dart';

class Urls {
  static String baseURL = 'https://api.openweathermap.org/data/';

  static String weatherForcast(String lat, String lon) {
    String apiKey = dotenv.env['API_KEY'] ?? "";
    return '$baseURL/2.5/forecast?lat=$lat&lon=$lon&units=metric&APPID=$apiKey';
  }

  static String iconURL(String icon) => 'https://openweathermap.org/img/wn/$icon@2x.png';
}
