
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:weather_info_app/core/api/base_client.dart';
import 'package:weather_info_app/core/geolocation/bloc/geolocation_bloc.dart';
import 'package:weather_info_app/core/geolocation/geolocation_repository.dart';
import 'package:weather_info_app/features/weather_info/data/data_source/weather_info_remote_data_source.dart';
import 'package:weather_info_app/features/weather_info/domain/repository/weather_info_repository.dart';
import 'package:weather_info_app/features/weather_info/domain/usecase/weather_info_usecase.dart';
import 'package:weather_info_app/features/weather_info/presentation/bloc/weather_info_bloc.dart';
import 'features/weather_info/data/repository/weather_info_repository_impl.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  locator.registerFactory(() => WeatherInfoBloc(locator()));
  locator.registerLazySingleton<WeatherInfoUseCase>(() => WeatherInfoUseCaseImpl(weatherInfoRepository: locator()));
  locator.registerLazySingleton<WeatherInfoRepository>(() => WeatherInfoRepositoryImpl(weatherInfoRemoteDataSource: locator()));
  locator.registerLazySingleton<WeatherInfoRemoteDataSource>(() => WeatherInfoRemoteDataSourceImpl(client: locator()));

  locator.registerLazySingleton<BaseApiClient>(() => ApiClient(client: locator()));
  locator.registerLazySingleton(() => http.Client());
  locator.registerFactory(() => GeolocationBloc(locator()));
  locator.registerLazySingleton<GeolocationRepository>(() => GeolocationRepository());
}