import 'dart:convert';
import '../../../../core/api/base_client.dart';
import '../../../../utils/constants/Urls.dart';
import '../model/weather_info_model.dart';

abstract class WeatherInfoRemoteDataSource {
  Future<WeatherInfoModel> getWeatherInfo(String latitude, String longitude);
}

class WeatherInfoRemoteDataSourceImpl extends WeatherInfoRemoteDataSource {
  final BaseApiClient client;

  WeatherInfoRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherInfoModel> getWeatherInfo(
      String latitude, String longitude) async {
    final response = await client.get(Urls.weatherForcast(latitude, longitude));
    return WeatherInfoModel.fromJson(json.decode(response));
  }
}
