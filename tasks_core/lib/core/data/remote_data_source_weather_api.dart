import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import 'model/weather_data_model.dart';

part 'remote_data_source_weather_api.g.dart';

@RestApi(baseUrl: "https://api.weatherapi.com/v1/")
abstract class WeatherRestClient {
  factory WeatherRestClient(Dio dio, {String baseUrl}) = _WeatherRestClient;

  @GET("current.json")
  Future<CurrentWeather> getCurrentWeather(@Query("q") String latLng, @Query("key") String apiKey, @Query("lang") String lang);
}
