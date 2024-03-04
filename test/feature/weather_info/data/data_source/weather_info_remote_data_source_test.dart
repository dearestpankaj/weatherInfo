import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:weather_info_app/features/weather_info/data/data_source/weather_info_remote_data_source.dart';
import 'package:weather_info_app/features/weather_info/data/model/weather_info_model.dart';
import 'package:weather_info_app/utils/constants/Urls.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockBaseApiClient mockBaseApiClient;

  late WeatherInfoRemoteDataSourceImpl sut;

  setUp(() async {
    mockBaseApiClient = MockBaseApiClient();
    await dotenv.load(fileName: ".env");
    sut =
        WeatherInfoRemoteDataSourceImpl(client: mockBaseApiClient);
  });

  group('', () {
    test('should return weather model when the response code is 200', () async {
      String lat = 'my_lat';
      String lon = 'my_lng';
      String url = Urls.weatherForcast(lat, lon);
      when(
          mockBaseApiClient.get(url)
      ).thenAnswer(
              (_) async =>
              http.Response(
                  readJson('helpers/dummy_data/dummy_weather_forecast_response.json'),
                  200
              ).body
      );
      final result = await sut.getWeatherInfo(lat, lon);
      expect(true, result.list != null);
    });
  });
}