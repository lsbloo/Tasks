import 'package:dio/dio.dart';
import 'package:tasks_core/core/data/model/weather_data_model.dart';
import 'package:tasks_core/core/data/remote_data_source_weather_api.dart';

class WeatherRemoteDataSource {
  late final String _apiKey = "91fbe21a8c3c4d3d8ef174846232703";
  late final String _lang = "pt";

  Future<CurrentWeather> getWeatherCurrentData(double lat, double long) {
    final dio = Dio();

    dio.interceptors.add(InterceptorsWrapper(
      onResponse: (response, handler) {
        print(response.data);
        return handler.next(response);
      },
      onError: (error, handler) {
        print(error.response);
        return handler.next(error);
      },
    ));

    final client = WeatherRestClient(dio);
    String latLng = "$lat,$long";
    return client.getCurrentWeather(latLng, _apiKey, _lang);
  }
}
