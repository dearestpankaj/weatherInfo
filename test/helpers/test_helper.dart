import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:weather_info_app/core/api/base_client.dart';
import 'package:weather_info_app/features/weather_info/data/data_source/weather_info_remote_data_source.dart';
import 'package:weather_info_app/features/weather_info/domain/repository/weather_info_repository.dart';
import 'package:weather_info_app/features/weather_info/domain/usecase/weather_info_usecase.dart';

@GenerateMocks([
  WeatherInfoUseCase,
  WeatherInfoRepository,
  WeatherInfoRemoteDataSource,
  BaseApiClient
],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)

void main() { }