import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:bloc/bloc.dart';
import 'package:weather_info_app/core/geolocation/geolocation_repository.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final GeolocationRepository _geolocationRepository;
  StreamSubscription? _geolocationSubscription;

  GeolocationBloc(this._geolocationRepository) : super(GeolocationLoading()) {
    on<LoadGeolocationEvent>((event, emit) async {
      _geolocationSubscription?.cancel();
      try {
        final Position position = await _geolocationRepository.getCurrentLocation();
        emit(GeolocationLoaded(position: position));
      } catch(e) {
        emit(GeolocationError());
      }
    });

    on<UpdateGeolocationEvent>((event, emit) async {
      try {
        emit(GeolocationLoaded(position: event.position));
      } catch (e) {
        emit(GeolocationError());
      }
    });
  }

  @override
  Future<void> close() {
    _geolocationSubscription?.cancel();
    return super.close();
  }
}

//
// @override
// Stream<GeolocationState> mapEventToState(
//   GeolocationEvent event,
// ) async* {
//   if (event is LoadGeolocationEvent) {
//     yield* _mapLoadGeoLocationToState();
//   } else if (event is UpdateGeolocationEvent) {
//     yield* _mapUpdateGeoLocationToState(event);
//   }
// }
//
// Stream<GeolocationState> _mapLoadGeoLocationToState() async* {
//   _geolocationSubscription?.cancel();
//   final Position position = await _geolocationRepository.getCurrentLocation();
//   add(UpdateGeolocationEvent(position: position));
// }
//
// Stream<GeolocationState> _mapUpdateGeoLocationToState(UpdateGeolocationEvent event) async*{
//   yield GeolocationLoaded(position: event.position);
// }