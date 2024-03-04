import 'dart:async';
// import 'package:injectable/injectable.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:weather_info_app/features/weather_info/domain/usecase/weather_info_usecase.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../domain/entity/weather_info.dart';

part 'weather_info_event.dart';
part 'weather_info_state.dart';

// @injectable
class WeatherInfoBloc extends Bloc<WeatherInfoEvent, WeatherInfoState> {
  final WeatherInfoUseCase _weatherInfoUseCase;

  WeatherInfoBloc(this._weatherInfoUseCase) : super(WeatherInfoInitial()) {
    on<WeatherInfoFetchEvent>((event, emit) async {
      emit(WeatherInfoFetchingState());
      final response = await _weatherInfoUseCase.getWeatherInfo(
          event.position.latitude.toString(),
          event.position.longitude.toString());
      response.fold(
          (failure) => {emit(WeatherInfoFetchingFailureState(failure.message))},
          (success) {
        if (success != null) {
          final weatherInfoViewModelList =
              success.map((e) => _convertToViewModel(e)).toList();
          emit(WeatherInfoFetchingSuccessState(
              weatherInfoList: weatherInfoViewModelList));
        } else {
          emit(WeatherInfoFetchingFailureState(
              AppTexts.failureFetchWeatherInfo));
        }
      });
    });
  }

  WeatherInfoViewModel _convertToViewModel(WeatherInfo weatherInfo) {
    DateTime date = DateFormat("yyyy-MM-dd").parse(weatherInfo.date);

    return WeatherInfoViewModel(
        weather: weatherInfo.mainTitle,
        day: DateFormat('EEEE').format(date),
        temp: '${weatherInfo.temp?.toStringAsFixed(1)}°',
        humidity: AppTexts.humidity(weatherInfo.humidity.toString()),
        pressure: AppTexts.pressure(weatherInfo.pressure.toString()),
        wind: AppTexts.wind(weatherInfo.windSpeed.toString()),
        tempMin: '${weatherInfo.tempMin?.toStringAsFixed(1)}°',
        tempMax: '${weatherInfo.tempMax?.toStringAsFixed(1)}°',
        iconURL: weatherInfo.iconURL,
        titleImage: AppImages.getWeatherImage(weatherInfo.mainTitle).value);
  }
}

class WeatherInfoViewModel extends Equatable {
  final String weather;
  final String day;
  final String temp;
  final String humidity;
  final String pressure;
  final String wind;
  final String tempMin;
  final String tempMax;
  final String iconURL;
  final String titleImage;

  WeatherInfoViewModel(
      {required this.weather,
      required this.day,
      required this.temp,
      required this.humidity,
      required this.pressure,
      required this.wind,
      required this.tempMin,
      required this.tempMax,
      required this.iconURL,
      required this.titleImage});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
