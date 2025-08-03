import 'package:equatable/equatable.dart';
import 'package:weatherapp/app/data/models/current_weather_model.dart';
import 'package:weatherapp/app/data/models/location_model.dart';
import 'package:weatherapp/app/data/models/weather_condition.dart';

class ForecastResponse extends Equatable {
  final LocationModel location;
  final CurrentWeatherModel current;
  final ForecastData forecast;

  const ForecastResponse({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory ForecastResponse.fromJson(Map<String, dynamic> json) {
    return ForecastResponse(
      location: LocationModel.fromJson(json['location'] ?? {}),
      current: CurrentWeatherModel.fromJson(json['current'] ?? {}),
      forecast: ForecastData.fromJson(json['forecast'] ?? {}),
    );
  }

  @override
  List<Object?> get props => [location, current, forecast];
}


class ForecastData extends Equatable {
  final List<ForecastDay> forecastday;

  const ForecastData({required this.forecastday});

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    return ForecastData(
      forecastday: (json['forecastday'] as List<dynamic>? ?? [])
          .map((day) => ForecastDay.fromJson(day))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [forecastday];
}

// Día del pronóstico
class ForecastDay extends Equatable {
  final String date;
  final int dateEpoch;
  final DayWeather day;
  final AstroData astro;
  final List<HourWeather> hour;

  const ForecastDay({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.astro,
    required this.hour,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      date: json['date'] ?? '',
      dateEpoch: json['date_epoch'] ?? 0,
      day: DayWeather.fromJson(json['day'] ?? {}),
      astro: AstroData.fromJson(json['astro'] ?? {}),
      hour: (json['hour'] as List<dynamic>? ?? [])
          .map((hour) => HourWeather.fromJson(hour))
          .toList(),
    );
  }

  // Helper para obtener el día de la semana
  String get dayOfWeek {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(dateEpoch * 1000);
    final weekdays = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    return weekdays[dateTime.weekday - 1];
  }

  // Helper para formatear fecha
  String get formattedDate {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(dateEpoch * 1000);
    return '${dateTime.day}/${dateTime.month}';
  }

  @override
  List<Object?> get props => [date, dateEpoch, day, astro, hour];
}

// Datos del día
class DayWeather extends Equatable {
  final double maxtempC;
  final double maxtempF;
  final double mintempC;
  final double mintempF;
  final double avgtempC;
  final double avgtempF;
  final double maxwindKph;
  final double totalprecipMm;
  final double avghumidity;
  final int dailyChanceOfRain;
  final int dailyChanceOfSnow;
  final WeatherCondition condition;
  final double uv;

  const DayWeather({
    required this.maxtempC,
    required this.maxtempF,
    required this.mintempC,
    required this.mintempF,
    required this.avgtempC,
    required this.avgtempF,
    required this.maxwindKph,
    required this.totalprecipMm,
    required this.avghumidity,
    required this.dailyChanceOfRain,
    required this.dailyChanceOfSnow,
    required this.condition,
    required this.uv,
  });

  factory DayWeather.fromJson(Map<String, dynamic> json) {
    return DayWeather(
      maxtempC: (json['maxtemp_c'] ?? 0.0).toDouble(),
      maxtempF: (json['maxtemp_f'] ?? 0.0).toDouble(),
      mintempC: (json['mintemp_c'] ?? 0.0).toDouble(),
      mintempF: (json['mintemp_f'] ?? 0.0).toDouble(),
      avgtempC: (json['avgtemp_c'] ?? 0.0).toDouble(),
      avgtempF: (json['avgtemp_f'] ?? 0.0).toDouble(),
      maxwindKph: (json['maxwind_kph'] ?? 0.0).toDouble(),
      totalprecipMm: (json['totalprecip_mm'] ?? 0.0).toDouble(),
      avghumidity: (json['avghumidity'] ?? 0.0).toDouble(),
      dailyChanceOfRain: json['daily_chance_of_rain'] ?? 0,
      dailyChanceOfSnow: json['daily_chance_of_snow'] ?? 0,
      condition: WeatherCondition.fromJson(json['condition'] ?? {}),
      uv: (json['uv'] ?? 0.0).toDouble(),
    );
  }

  // Helpers para temperaturas
  double getMaxTemp(bool isCelsius) => isCelsius ? maxtempC : maxtempF;
  double getMinTemp(bool isCelsius) => isCelsius ? mintempC : mintempF;
  double getAvgTemp(bool isCelsius) => isCelsius ? avgtempC : avgtempF;

  @override
  List<Object?> get props => [
    maxtempC, maxtempF, mintempC, mintempF, avgtempC, avgtempF,
    maxwindKph, totalprecipMm, avghumidity, dailyChanceOfRain,
    dailyChanceOfSnow, condition, uv,
  ];
}

// Datos astronómicos
class AstroData extends Equatable {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;
  final int moonIllumination;

  const AstroData({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.moonIllumination,
  });

  factory AstroData.fromJson(Map<String, dynamic> json) {
    return AstroData(
      sunrise: json['sunrise'] ?? '',
      sunset: json['sunset'] ?? '',
      moonrise: json['moonrise'] ?? '',
      moonset: json['moonset'] ?? '',
      moonPhase: json['moon_phase'] ?? '',
      moonIllumination: json['moon_illumination'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [
    sunrise, sunset, moonrise, moonset, moonPhase, moonIllumination,
  ];
}


class HourWeather extends Equatable {
  final String time;
  final int timeEpoch;
  final double tempC;
  final double tempF;
  final int isDay;
  final WeatherCondition condition;
  final double windKph;
  final double precipMm;
  final int humidity;
  final int chanceOfRain;
  final double feelslikeC;
  final double feelslikeF;

  const HourWeather({
    required this.time,
    required this.timeEpoch,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.precipMm,
    required this.humidity,
    required this.chanceOfRain,
    required this.feelslikeC,
    required this.feelslikeF,
  });

  factory HourWeather.fromJson(Map<String, dynamic> json) {
    return HourWeather(
      time: json['time'] ?? '',
      timeEpoch: json['time_epoch'] ?? 0,
      tempC: (json['temp_c'] ?? 0.0).toDouble(),
      tempF: (json['temp_f'] ?? 0.0).toDouble(),
      isDay: json['is_day'] ?? 0,
      condition: WeatherCondition.fromJson(json['condition'] ?? {}),
      windKph: (json['wind_kph'] ?? 0.0).toDouble(),
      precipMm: (json['precip_mm'] ?? 0.0).toDouble(),
      humidity: json['humidity'] ?? 0,
      chanceOfRain: json['chance_of_rain'] ?? 0,
      feelslikeC: (json['feelslike_c'] ?? 0.0).toDouble(),
      feelslikeF: (json['feelslike_f'] ?? 0.0).toDouble(),
    );
  }

 
  double getTemperature(bool isCelsius) => isCelsius ? tempC : tempF;
  double getFeelsLike(bool isCelsius) => isCelsius ? feelslikeC : feelslikeF;
  bool get isDayTime => isDay == 1;
  
  String get hourOnly {
    try {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(timeEpoch * 1000);
      return '${dateTime.hour.toString().padLeft(2, '0')}:00';
    } catch (e) {
      return time.split(' ').last;
    }
  }

  @override
  List<Object?> get props => [
    time, timeEpoch, tempC, tempF, isDay, condition,
    windKph, precipMm, humidity, chanceOfRain, feelslikeC, feelslikeF,
  ];
}