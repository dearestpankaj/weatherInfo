part of 'weather_info_bloc.dart';

@immutable
abstract class WeatherInfoEvent {
  @override
  List<Object> get props => [];
}

class WeatherInfoFetchEvent extends WeatherInfoEvent {
  final Position position;

  WeatherInfoFetchEvent({ required this.position });
}

