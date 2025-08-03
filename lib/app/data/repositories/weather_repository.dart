import 'package:weatherapp/app/data/models/city_search_result.dart';
import 'package:weatherapp/app/data/models/forecast_models.dart';
import 'package:weatherapp/app/data/models/weather_response.dart';
import 'package:weatherapp/app/data/providers/weather_api_provider.dart';

class WeatherRepository {
  final WeatherApiProvider _apiProvider;

  WeatherRepository({WeatherApiProvider? apiProvider})
      : _apiProvider = apiProvider ?? WeatherApiProvider();

  Future<WeatherResponse> getCurrentWeather(String query) async {
    return await _apiProvider.getCurrentWeather(query);
  }
  Future<List<CitySearchResult>> searchCities(String query) async {
  return await _apiProvider.searchCities(query);
}

Future<ForecastResponse> getForecastWeather(String query, int days) async {
  return await _apiProvider.getForecastWeather(query, days);
}

  void dispose() {
    _apiProvider.dispose();
  }
}