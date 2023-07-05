import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tasks_core/core/data/model/weather_data_model.dart';
import 'package:tasks_flutter_one/features/home/contract/home_add_task_contract.dart';
import 'package:tasks_flutter_one/features/home/data/datasource/home_task_weather_datasource.dart';
import 'package:tasks_flutter_one/features/home/data/repository/home_repository.dart';
@GenerateNiceMocks([MockSpec<WeatherRemoteDataSource>()])
import 'package:tasks_flutter_one/features/home/presenter/home_add_task_presenter.dart';

import 'weather_api_test.mocks.dart';

void main() {
  var mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
  test(
      'call getWeatherCurrentData with latitude and longitude and validate successful return of api',
      () {
    // GIVEN
    var lat = 14.42232;
    var lng = 32.4124;

    // WHEN
    when(mockWeatherRemoteDataSource.getWeatherCurrentData(lat, lng))
        .thenAnswer((realInvocation) => Future<CurrentWeather>.value(
            CurrentWeather(
                location:
                    LocationDataWeather(
                        name: "Pedra", region: "Pernambuco", country: "Brasil"),
                current: CurrentDataWeather(
                    temp_c: 19.23,
                    temp_f: 46.44,
                    conditionDataWeather: ConditionDataWeather(
                        text: "Parcialmente Nublado", icon: "https://")))));

    // THEN
    mockWeatherRemoteDataSource
        .getWeatherCurrentData(lat, lng)
        .then((currentWeather) => {
              expect(19.23, currentWeather.current?.temp_c),
              expect(46.44, currentWeather.current?.temp_f),
              expect("Pedra", currentWeather.location?.name),
              expect("Pernambuco", currentWeather.location?.region),
              expect("Brasil", currentWeather.location?.country),
              expect("Parcialmente Nublado",
                  currentWeather.current?.conditionDataWeather?.text),
              expect("https://",
                  currentWeather.current?.conditionDataWeather?.icon)
            });
  });

  test(
      'call getWeatherCurrentData without latitude and longitude and validate unsuccessful return of api',
      () {
    // GIVEN
    var lat = 0.0;
    var lng = 0.0;

    // WHEN
    when(mockWeatherRemoteDataSource.getWeatherCurrentData(lat, lng))
        .thenAnswer(
            (realInvocation) => Future<CurrentWeather>.value(CurrentWeather()));

    // THEN
    mockWeatherRemoteDataSource
        .getWeatherCurrentData(lat, lng)
        .then((currentWeather) => {
              expect(null, currentWeather.current?.temp_c),
              expect(null, currentWeather.current?.temp_f),
              expect(null, currentWeather.location?.name),
              expect(null, currentWeather.location?.region),
              expect(null, currentWeather.location?.country),
              expect(null, currentWeather.current?.conditionDataWeather?.text),
              expect(null, currentWeather.current?.conditionDataWeather?.icon)
            });
  });
}
