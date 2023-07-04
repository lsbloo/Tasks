// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentWeather _$CurrentWeatherFromJson(Map<String, dynamic> json) =>
    CurrentWeather(
      current: json['current'] == null
          ? null
          : CurrentDataWeather.fromJson(
              json['current'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : LocationDataWeather.fromJson(
              json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrentWeatherToJson(CurrentWeather instance) =>
    <String, dynamic>{
      'current': instance.current?.toJson(),
      'location': instance.location?.toJson(),
    };

CurrentDataWeather _$CurrentDataWeatherFromJson(Map<String, dynamic> json) =>
    CurrentDataWeather(
      temp_c: (json['temp_c'] as num?)?.toDouble(),
      temp_f: (json['temp_f'] as num?)?.toDouble(),
      conditionDataWeather: json['condition'] == null
          ? null
          : ConditionDataWeather.fromJson(
              json['condition'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrentDataWeatherToJson(CurrentDataWeather instance) =>
    <String, dynamic>{
      'temp_c': instance.temp_c,
      'temp_f': instance.temp_f,
      'condition': instance.conditionDataWeather?.toJson(),
    };

ConditionDataWeather _$ConditionDataWeatherFromJson(
        Map<String, dynamic> json) =>
    ConditionDataWeather(
      text: json['text'] as String?,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$ConditionDataWeatherToJson(
        ConditionDataWeather instance) =>
    <String, dynamic>{
      'text': instance.text,
      'icon': instance.icon,
    };

LocationDataWeather _$LocationDataWeatherFromJson(Map<String, dynamic> json) =>
    LocationDataWeather(
      name: json['name'] as String?,
      region: json['region'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$LocationDataWeatherToJson(
        LocationDataWeather instance) =>
    <String, dynamic>{
      'name': instance.name,
      'region': instance.region,
      'country': instance.country,
    };
