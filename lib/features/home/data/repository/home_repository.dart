import 'package:http/http.dart';
import 'package:tasks_core/core/data/model/weather_data_model.dart';
import 'package:tasks_flutter_one/features/home/data/model/task_vo.dart';
import 'dart:convert';
import '../datasource/home_task_datasource.dart';
import '../datasource/home_task_weather_datasource.dart';

class HomeRepository {
  final HomeTaskRemoteDataSource _homeTaskRemoteDataSource =
      HomeTaskRemoteDataSource();

  final WeatherRemoteDataSource _weatherRemoteDataSource =
      WeatherRemoteDataSource();

  Future<Response> saveTask(TaskVO taskVO) {
    return _homeTaskRemoteDataSource.insert(jsonEncode(taskVO.toJson()));
  }

  Future<Response> getAllTasks() {
    return _homeTaskRemoteDataSource.list();
  }

  Future<Response> deleteTask(String id) {
    return _homeTaskRemoteDataSource.delete(id);
  }

  Future<Response> updateTask(TaskVO taskVO, String id) {
    return _homeTaskRemoteDataSource.update(id, jsonEncode(taskVO.toJson()));
  }

  Future<CurrentWeather> getWeatherCurrent(double lat, double long) async {
    return _weatherRemoteDataSource.getWeatherCurrentData(lat, long);
  }
}
