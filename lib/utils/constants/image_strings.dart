
class AppImages {

  static WeatherImages getWeatherImage(String iconName) {
    if (iconName.toLowerCase() == 'clear') {
      return WeatherImages.clearWeather;
    } else if (iconName.toLowerCase() == 'clouds') {
      return WeatherImages.cloudyWeather;
    } else if (iconName.toLowerCase() == 'thunderstorm') {
      return WeatherImages.thunderstormWeather;
    } else if (iconName.toLowerCase() == 'drizzle') {
      return WeatherImages.drizzleWeather;
    } else if (iconName.toLowerCase() == 'rain') {
      return WeatherImages.rainWeather;
    } else if (iconName.toLowerCase() == 'snow') {
      return WeatherImages.snowWeather;
    }
    return WeatherImages.clearWeather;
  }
}

enum WeatherImages {
  sunnyWeather('assets/11.png'),
  thunderstormWeather('assets/200.png'),
  drizzleWeather('assets/300.png'),
  rainWeather('assets/500.png'),
  snowWeather('assets/600.png'),
  cloudyWeather('assets/700.png'),
  clearWeather('assets/800.png'),
  littleCloudyWeather('assets/801.png'),
  overcastCloudyWeather('assets/804.png');

  const WeatherImages(this.value);
  final String value;
}
