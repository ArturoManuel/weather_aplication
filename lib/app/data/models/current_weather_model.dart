import 'package:equatable/equatable.dart';
import 'package:weatherapp/app/data/models/weather_condition.dart';

class CurrentWeatherModel extends Equatable {
  final int lastUpdatedEpoch;
  final String lastUpdated;
  final double tempC;
  final double tempF;
  final int isDay;
  final WeatherCondition condition;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final double pressureMb;
  final double precipMm;
  final int humidity;
  final int cloud;
  final double feelslikeC;
  final double feelslikeF;
  final double visKm;
  final double uv;
  final double gustKph;

  const CurrentWeatherModel({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.precipMm,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.visKm,
    required this.uv,
    required this.gustKph,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      lastUpdatedEpoch: json['last_updated_epoch'] ?? 0,
      lastUpdated: json['last_updated'] ?? '',
      tempC: (json['temp_c'] ?? 0.0).toDouble(),
      tempF: (json['temp_f'] ?? 0.0).toDouble(),
      isDay: json['is_day'] ?? 0,
      condition: WeatherCondition.fromJson(json['condition'] ?? {}),
      windMph: (json['wind_mph'] ?? 0.0).toDouble(),
      windKph: (json['wind_kph'] ?? 0.0).toDouble(),
      windDegree: json['wind_degree'] ?? 0,
      windDir: json['wind_dir'] ?? '',
      pressureMb: (json['pressure_mb'] ?? 0.0).toDouble(),
      precipMm: (json['precip_mm'] ?? 0.0).toDouble(),
      humidity: json['humidity'] ?? 0,
      cloud: json['cloud'] ?? 0,
      feelslikeC: (json['feelslike_c'] ?? 0.0).toDouble(),
      feelslikeF: (json['feelslike_f'] ?? 0.0).toDouble(),
      visKm: (json['vis_km'] ?? 0.0).toDouble(),
      uv: (json['uv'] ?? 0.0).toDouble(),
      gustKph: (json['gust_kph'] ?? 0.0).toDouble(),
    );
  }

 
  double getTemperature(bool isCelsius) => isCelsius ? tempC : tempF;
  double getFeelsLike(bool isCelsius) => isCelsius ? feelslikeC : feelslikeF;
  String getTemperatureUnit(bool isCelsius) => isCelsius ? '°C' : '°F';
  bool get isDayTime => isDay == 1;

  @override
  List<Object?> get props => [
    lastUpdatedEpoch, lastUpdated, tempC, tempF, isDay, condition,
    windMph, windKph, windDegree, windDir, pressureMb, precipMm,
    humidity, cloud, feelslikeC, feelslikeF, visKm, uv, gustKph,
  ];
}