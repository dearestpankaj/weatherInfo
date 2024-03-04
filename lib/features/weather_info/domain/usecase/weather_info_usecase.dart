import 'package:dartz/dartz.dart';
import 'package:weather_info_app/features/weather_info/data/repository/weather_info_repository_impl.dart';

import '../../../../core/error/failure.dart';
import '../entity/weather_info.dart';
import '../repository/weather_info_repository.dart';

abstract class WeatherInfoUseCase {
  Future<Either<Failure, List<WeatherInfo>?>> getWeatherInfo(
      String latitude, String longitude);
}

class WeatherInfoUseCaseImpl extends WeatherInfoUseCase {
  WeatherInfoRepository weatherInfoRepository;

  WeatherInfoUseCaseImpl({required this.weatherInfoRepository});

  Future<Either<Failure, List<WeatherInfo>?>> getWeatherInfo(
      String latitude, String longitude) async {
    final weatherInfoList =
        await weatherInfoRepository.getWeatherInfo(latitude, longitude);

    return weatherInfoList.fold((l) {
      return Left(l);
    }, (r) {
      List<WeatherInfo> tempWeatherInfoList = [];
      String date = "";

      r?.forEach((element) {
        if (date.isEmpty || date != element.date.split(" ").first) {
          tempWeatherInfoList.add(element);
        }
        date = element.date.split(" ").first;
      });

      return Right(tempWeatherInfoList);
    });
  }
}
