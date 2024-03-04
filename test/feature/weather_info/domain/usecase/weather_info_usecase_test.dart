
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_info_app/core/error/failure.dart';
import 'package:weather_info_app/features/weather_info/data/model/weather_info_model.dart';
import 'package:weather_info_app/features/weather_info/data/repository/weather_info_repository_impl.dart';
import 'package:weather_info_app/features/weather_info/domain/entity/weather_info.dart';
import 'package:weather_info_app/features/weather_info/domain/repository/weather_info_repository.dart';
import 'package:weather_info_app/features/weather_info/domain/usecase/weather_info_usecase.dart';
import 'package:weather_info_app/utils/constants/Urls.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main(){
  late WeatherInfoRepository mockWeatherInfoRepository;
  late WeatherInfoUseCaseImpl sut;

  List<WeatherInfo>? weatherInfoList = [WeatherInfo(mainTitle: '', mainTitleDescription: '', temp: 0.0, tempMax: 10.0, tempMin: 0, date: "2024-02-28 21:00:00", humidity: 0, pressure: 0, iconURL:
  '', windSpeed: 0 )];
  String lat = 'my_lat';
  String lon = 'my_lng';

  setUp(() {
    mockWeatherInfoRepository = MockWeatherInfoRepository();
    sut = WeatherInfoUseCaseImpl(weatherInfoRepository: mockWeatherInfoRepository);
  });


  test(
      'should get weather forecast detail',
          () async {
        
      final Map < String, dynamic > jsonMap = jsonDecode(
        readJson('helpers/dummy_data/dummy_weather_forecast_response.json'),
      );
      final weatherForecastList = WeatherInfoModel.fromJson(jsonMap);

      List<WeatherInfo>? weatherInfo = weatherForecastList.list
          ?.map((e) => WeatherInfo(
          mainTitle: e.weather?.first.main ?? "",
          mainTitleDescription: e.weather?.first.description ?? "",
          temp: e.main?.temp,
          tempMax: e.main?.tempMax,
          tempMin: e.main?.tempMin,
          humidity: e.main?.humidity,
          pressure: e.main?.pressure,
          windSpeed: e.wind?.speed,
          iconURL: Urls.iconURL(e.weather?.first.icon ?? ""),
          date: e.dtTxt ?? ""))
          .toList();
      
        when(
            mockWeatherInfoRepository.getWeatherInfo(lat, lon)
        ).thenAnswer((_) async =>  Right(weatherInfo));

        final result = await sut.getWeatherInfo(lat, lon);

        expect(result.isRight(), true);
      }
  );

  test(
      'should get Left(Failure) for nil data',
          () async {
        when(
            mockWeatherInfoRepository.getWeatherInfo(lat, lon)
        ).thenAnswer((_) async => const Left(ServerFailure('failed')) );

        final result = await sut.getWeatherInfo(lat, lon);

        expect(result,  const Left(ServerFailure('failed')));
      }
  );
}