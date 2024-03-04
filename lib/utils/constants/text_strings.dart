
class AppTexts {
  static String humidity(String value) => 'Humidity: $value %';
  static String pressure(String value) => 'Pressure: $value hPa';
  static String wind(String value) => 'Wind: $value km/h';
  static String failureFetchWeatherInfo = 'Failed to get weather info';
  static String defaultFailureText = 'Failed to get weather info';
  static String retryText = 'Retry';
  static String userPermissionDenied = 'You have denied location permissions, please enable it in Settings and try again';
}