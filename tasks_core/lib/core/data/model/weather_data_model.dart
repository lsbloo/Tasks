import 'package:json_annotation/json_annotation.dart';
import 'dart:ffi';
part 'weather_data_model.g.dart';

T? toNull<T>(_) => null;

@JsonSerializable(explicitToJson: true)
class CurrentWeather {

  @JsonKey(name: "current")
  CurrentDataWeather? current;

  @JsonKey(name: "location")
  LocationDataWeather? location;

  CurrentWeather({this.current, this.location});

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherToJson(this);

}

@JsonSerializable(explicitToJson: true)
class CurrentDataWeather {
  double? temp_c;
  double? temp_f;

  @JsonKey(name: "condition")
  ConditionDataWeather? conditionDataWeather;

  CurrentDataWeather({this.temp_c, this.temp_f, this.conditionDataWeather});

  factory CurrentDataWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentDataWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentDataWeatherToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ConditionDataWeather {
  String? text;
  String? icon;

  ConditionDataWeather({this.text,this.icon});

  factory ConditionDataWeather.fromJson(Map<String, dynamic> json) =>
      _$ConditionDataWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$ConditionDataWeatherToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LocationDataWeather {
  String? name;
  String? region;
  String? country;

  LocationDataWeather({this.name, this.region, this.country});

  factory LocationDataWeather.fromJson(Map<String, dynamic> json) =>
      _$LocationDataWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDataWeatherToJson(this);
}
