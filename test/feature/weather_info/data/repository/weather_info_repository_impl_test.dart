

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_info_app/features/weather_info/data/data_source/weather_info_remote_data_source.dart';
import 'package:weather_info_app/features/weather_info/data/model/weather_info_model.dart';
import 'package:weather_info_app/features/weather_info/data/repository/weather_info_repository_impl.dart';
import 'dart:convert';
import '../../../../helpers/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherInfoRemoteDataSource mockWeatherInfoRemoteDataSource;
  late WeatherInfoRepositoryImpl sut;

  setUp(() {
    mockWeatherInfoRemoteDataSource = MockWeatherInfoRemoteDataSource();
    sut = WeatherInfoRepositoryImpl(weatherInfoRemoteDataSource: mockWeatherInfoRemoteDataSource);
  });

  test('TexDetailModel should be returned', () async {

    String lat = 'my_lat';
    String lon = 'my_lng';

    final Map < String, dynamic > jsonMap = jsonDecode(
      readJson('helpers/dummy_data/dummy_weather_forecast_response.json'),
    );
    final weatherForecastList = WeatherInfoModel.fromJson(jsonMap);

    when(mockWeatherInfoRemoteDataSource.getWeatherInfo(lat, lon))
        .thenAnswer((_) async => Future(() => weatherForecastList));

    final result = await sut.getWeatherInfo(lat, lon);

    expect(true, result.isRight());

  });
}