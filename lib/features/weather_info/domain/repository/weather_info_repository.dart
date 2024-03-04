import 'package:dartz/dartz.dart';
import 'package:weather_info_app/features/weather_info/domain/entity/weather_info.dart';

import '../../../../core/error/failure.dart';

abstract class WeatherInfoRepository {
  Future<Either<Failure, List<WeatherInfo>?>> getWeatherInfo(String latitude, String longitude);
}