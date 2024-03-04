import 'package:flutter/material.dart';
import 'package:weather_info_app/features/weather_info/presentation/bloc/weather_info_bloc.dart';
import 'package:weather_info_app/utils/constants/sizes.dart';


class ForecastTile extends StatelessWidget {
  final WeatherInfoViewModel weatherInfoViewModel;
  final int index;
  final void Function(int index) ? onForecastPressed;

  const ForecastTile({super.key, required this.weatherInfoViewModel, required this.index, required this.onForecastPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: SizedBox(width: AppSizes.standardTileSize, height: AppSizes.standardTileSize, child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(weatherInfoViewModel.day, style: Theme.of(context).textTheme.titleMedium),
          Image.network(weatherInfoViewModel.iconURL, height: AppSizes.iconLg,
              fit:BoxFit.fill),
          Text("${weatherInfoViewModel.tempMin} / ${weatherInfoViewModel.tempMax}" , style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),),
    );
  }

  void _onTap() {
    if (onForecastPressed != null) {
      onForecastPressed!(index);
    }
  }
}
