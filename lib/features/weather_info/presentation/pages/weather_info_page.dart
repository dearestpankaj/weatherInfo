import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_info_app/core/geolocation/bloc/geolocation_bloc.dart';
import 'package:weather_info_app/features/weather_info/presentation/bloc/weather_info_bloc.dart';
import 'package:weather_info_app/utils/constants/sizes.dart';
import 'package:weather_info_app/utils/constants/text_strings.dart';
import 'package:weather_info_app/utils/device/device_utility.dart';

import '../../../../core/error/UI/error_page.dart';
import '../../../../injection_container.dart';
import '../widget/forecast_tile.dart';

class WeatherInfoPage extends StatefulWidget {
  const WeatherInfoPage({super.key});

  @override
  State<WeatherInfoPage> createState() => _WeatherInfoPageState();
}

class _WeatherInfoPageState extends State<WeatherInfoPage> {
  late WeatherInfoBloc _weatherInfoBloc;
  late GeolocationBloc _geolocationBloc;
  late Position _userPosition;
  late int _selectedDay = 0;

  @override
  void initState() {
    super.initState();
    _weatherInfoBloc = locator<WeatherInfoBloc>();
    _geolocationBloc = locator<GeolocationBloc>()..add(LoadGeolocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          children: [
            BlocConsumer<GeolocationBloc, GeolocationState>(
              bloc: _geolocationBloc,
              listener: (context, state) {
                if (state is GeolocationError) {
                  Navigator.of(context)
                      .push(
                    CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => ErrorPage(
                          errorMessage: AppTexts.userPermissionDenied),
                    ),
                  )
                      .then((value) {
                    _geolocationBloc.add(LoadGeolocationEvent());
                  });
                }
              },
              builder: (context, state) {
                if (state is GeolocationLoading) {
                  return _buildLoading();
                } else if (state is GeolocationLoaded) {
                  _userPosition = state.position;
                  _weatherInfoBloc
                      .add(WeatherInfoFetchEvent(position: state.position));
                }
                return Container();
              },
            ),
            BlocConsumer<WeatherInfoBloc, WeatherInfoState>(
              bloc: _weatherInfoBloc,
              listener: (context, state) {
                if (state is WeatherInfoFetchingFailureState) {
                  Navigator.of(context)
                      .push(
                    CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => ErrorPage(
                          errorMessage: AppTexts.failureFetchWeatherInfo),
                    ),
                  )
                      .then((value) {
                    _weatherInfoBloc
                        .add(WeatherInfoFetchEvent(position: _userPosition));
                  });
                }
              },
              builder: (context, state) {
                if (state is WeatherInfoFetchingState) {
                  return _buildLoading();
                } else if (state is WeatherInfoFetchingSuccessState) {
                  return _buildWeatherForcastView(
                      context, state.weatherInfoList);
                }
                return Container();
              },
            ),
          ],
        ));
  }

  Widget _buildWeatherForcastView(
      BuildContext context, List<WeatherInfoViewModel> weatherInfoList) {
    if (DeviceUtility.getDeviceOrientation(context) == Orientation.portrait) {
      return _buildPortraitForcastView(weatherInfoList);
    } else {
      return _buildLandscapeForcastView(weatherInfoList);
    }
  }

  Widget _buildPortraitForcastView(List<WeatherInfoViewModel> weatherInfoList) {
    return RefreshIndicator(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleView(weatherInfoList[_selectedDay].day ?? ""),
              _weatherMainView(weatherInfoList[_selectedDay].weather ?? ""),
              _weatherImage(weatherInfoList[_selectedDay].titleImage),
              _weatherDetail(weatherInfoList[_selectedDay]),
              const SizedBox(
                height: AppSizes.spaceBetweenItems,
              ),
              _dailyForcastScrollView(
                  weatherInfoList, Axis.horizontal, AppSizes.standardTileSize),
            ],
          ),
        ),
        onRefresh: () async {
          _weatherInfoBloc.add(WeatherInfoFetchEvent(position: _userPosition));
        });
  }

  Widget _buildLandscapeForcastView(
      List<WeatherInfoViewModel> weatherInfoList) {
    return RefreshIndicator(
        child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Row(
              children: [
                Column(
                  children: [
                    _titleView(weatherInfoList[_selectedDay].day ?? ""),
                    SizedBox(
                      height: DeviceUtility.getScreenHeight(context) * 0.7,
                      child: _weatherImage(
                          weatherInfoList[_selectedDay].titleImage),
                    ),
                    _weatherMainView(
                        weatherInfoList[_selectedDay].weather ?? ""),
                  ],
                ),
                _weatherDetail(weatherInfoList[_selectedDay]),
                Expanded(
                  child: _dailyForcastScrollView(weatherInfoList, Axis.vertical,
                      DeviceUtility.getScreenHeight(context) * 0.8),
                )
              ],
            )),
        onRefresh: () async {
          _weatherInfoBloc.add(WeatherInfoFetchEvent(position: _userPosition));
        });
  }

  Widget _titleView(String day) {
    return Container(
        alignment: Alignment.center,
        child: Text(
          day,
          style: Theme.of(context).textTheme.headlineMedium,
        ));
  }

  Widget _weatherMainView(String selectedDay) {
    return Text(selectedDay ?? "",
        style: Theme.of(context).textTheme.titleLarge);
  }

  Widget _weatherImage(String mainImage) {
    return Image.asset(mainImage);
  }

  Widget _weatherDetail(WeatherInfoViewModel weatherViewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.center,
            child: Text(weatherViewModel.temp ?? "",
                style: Theme.of(context).textTheme.displayLarge)),
        Text(weatherViewModel.humidity.toString(),
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(
          height: AppSizes.spaceBetweenItems,
        ),
        Text(weatherViewModel.pressure.toString(),
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(
          height: AppSizes.spaceBetweenItems,
        ),
        Text(weatherViewModel.wind.toString(),
            style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }

  Widget _dailyForcastScrollView(List<WeatherInfoViewModel> weatherInfoList,
      Axis direction, double height) {
    return SizedBox(
        height: height,
        child: ListView.builder(
          scrollDirection: direction,
          itemBuilder: (context, index) {
            return ForecastTile(
              weatherInfoViewModel: weatherInfoList[index],
              index: index,
              onForecastPressed: (index) {
                _selectedDay = index;
                setState(() {});
              },
            );
          },
          itemCount: weatherInfoList.length,
        ));
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
