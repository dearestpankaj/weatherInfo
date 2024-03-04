part of 'weather_info_bloc.dart';

@immutable
abstract class WeatherInfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeatherInfoInitial extends WeatherInfoState {}

class WeatherInfoFetchingState extends WeatherInfoState {}

class WeatherInfoFetchingFailureState extends WeatherInfoState {
  final String message;
  WeatherInfoFetchingFailureState(this.message);
}

class WeatherInfoFetchingSuccessState extends WeatherInfoState {
  final List<WeatherInfoViewModel> weatherInfoList;
  WeatherInfoFetchingSuccessState({ required this.weatherInfoList });
}
