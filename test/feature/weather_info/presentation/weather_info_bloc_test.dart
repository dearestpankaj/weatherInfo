import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_info_app/core/error/failure.dart';
import 'package:weather_info_app/features/weather_info/domain/entity/weather_info.dart';
import 'package:weather_info_app/features/weather_info/presentation/bloc/weather_info_bloc.dart';
import 'package:weather_info_app/utils/constants/text_strings.dart';

import '../../../helpers/test_helper.mocks.dart';


void main() {
  late MockWeatherInfoUseCase mockWeatherInfoUseCase;
  late WeatherInfoBloc sut;

  String lat = '51.50998';
  String lon = '-0.1337';

  setUp(() {
    mockWeatherInfoUseCase = MockWeatherInfoUseCase();
    sut = WeatherInfoBloc(mockWeatherInfoUseCase);
  });

  test(
      'initial state should be empty',
          () {
        expect(sut.state, WeatherInfoInitial());
      }
  );

  group('Fetch test details', () {
    List<WeatherInfo> weatherInfoList = [WeatherInfo(mainTitle: 'aaa', mainTitleDescription: 'asas', temp: 10, tempMax: 10, tempMin: 10, humidity: 110, pressure: 10, windSpeed: 10, iconURL: 'iconURL', date: '2024-02-28 21:00:00')];
    List<WeatherInfoViewModel> weatherInfoViewModelList = [WeatherInfoViewModel(weather: '', day: '', temp: '', humidity: '', pressure: '', wind: '', tempMin: '', tempMax: '', iconURL: '', titleImage: '')];

    blocTest<WeatherInfoBloc, WeatherInfoState>(
        'should emit [WeatherInfoFetchingState, WeatherInfoFetchingSuccessState] when tax detail is received',
        build: () {
          when(
              mockWeatherInfoUseCase.getWeatherInfo(lat, lon)
          ).thenAnswer((_) async => Right(weatherInfoList));
          return sut;
        },
        act: (bloc) => bloc.add(WeatherInfoFetchEvent(position: Position(latitude: 51.50998, longitude: -0.1337, timestamp: DateTime.now(), accuracy: 1.0, altitude: 1.0, altitudeAccuracy: 1.0, heading: 1.0, headingAccuracy: 1.0, speed: 1.0, speedAccuracy: 1.0))),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          WeatherInfoFetchingState(),
          WeatherInfoFetchingSuccessState(weatherInfoList: weatherInfoViewModelList)
        ]
    );

    blocTest<WeatherInfoBloc, WeatherInfoState>(
        'should emit [WeatherInfoFetchingState, WeatherInfoFetchingFailureState] when tax detail request is failed',
        build: () {
          when(
              mockWeatherInfoUseCase.getWeatherInfo(lat, lon)
          ).thenAnswer((_) async => Left(
              ServerFailure(AppTexts.failureFetchWeatherInfo)
          ));
          return sut;
        },
        act: (bloc) => bloc.add(WeatherInfoFetchEvent(position: Position(latitude: 51.50998, longitude: -0.1337, timestamp: DateTime.now(), accuracy: 1.0, altitude: 1.0, altitudeAccuracy: 1.0, heading: 1.0, headingAccuracy: 1.0, speed: 1.0, speedAccuracy: 1.0))),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          WeatherInfoFetchingState(),
          WeatherInfoFetchingFailureState(AppTexts.failureFetchWeatherInfo)
        ]
    );
  });
}