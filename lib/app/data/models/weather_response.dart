import 'package:equatable/equatable.dart';
import 'package:weatherapp/app/data/models/current_weather_model.dart';
import 'package:weatherapp/app/data/models/location_model.dart';

class WeatherResponse extends Equatable {
  final LocationModel location;
  final CurrentWeatherModel current;

  const WeatherResponse({
    required this.location,
    required this.current,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      location: LocationModel.fromJson(json['location'] ?? {}),
      current: CurrentWeatherModel.fromJson(json['current'] ?? {}),
    );
  }

  @override
  List<Object?> get props => [location, current];
}