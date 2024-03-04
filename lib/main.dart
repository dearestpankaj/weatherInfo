import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_info_app/core/geolocation/bloc/geolocation_bloc.dart';
import 'package:weather_info_app/features/weather_info/presentation/bloc/weather_info_bloc.dart';
import 'package:weather_info_app/utils/theme.dart';

import 'features/weather_info/domain/usecase/weather_info_usecase.dart';
import 'features/weather_info/presentation/pages/weather_info_page.dart';
import 'injection_container.dart';

void main() async {
  await initializeDependencies();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GeolocationBloc>(create: (context) => locator<GeolocationBloc>()),
        BlocProvider<WeatherInfoBloc>(create: (context) => locator<WeatherInfoBloc>()),
      ], child: MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const Scaffold(
        body: SafeArea(
          child: WeatherInfoPage(),
        ),
      ),
    ),
    );
  }
}

