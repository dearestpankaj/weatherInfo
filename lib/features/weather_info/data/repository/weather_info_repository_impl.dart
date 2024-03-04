import 'package:dartz/dartz.dart';

import 'package:weather_info_app/core/error/failure.dart';
import 'package:weather_info_app/features/weather_info/data/data_source/weather_info_remote_data_source.dart';

import 'package:weather_info_app/features/weather_info/domain/entity/weather_info.dart';
import 'package:weather_info_app/utils/constants/Urls.dart';

import '../../domain/repository/weather_info_repository.dart';

class WeatherInfoRepositoryImpl extends WeatherInfoRepository {
  WeatherInfoRemoteDataSource weatherInfoRemoteDataSource;

  WeatherInfoRepositoryImpl({required this.weatherInfoRemoteDataSource});

  @override
  Future<Either<Failure, List<WeatherInfo>?>> getWeatherInfo(
      String latitude, String longitude) async {
    try {
      final result =
          await weatherInfoRemoteDataSource.getWeatherInfo(latitude, longitude);
      List<WeatherInfo>? weatherInfo = result.list
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
      return Right(weatherInfo);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
