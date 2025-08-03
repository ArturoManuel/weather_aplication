import 'package:dio/dio.dart';
import 'package:weatherapp/app/data/models/city_search_result.dart';
import 'package:weatherapp/app/data/models/forecast_models.dart';
import 'package:weatherapp/app/data/models/weather_response.dart';

import '../../utils/constants.dart';

class WeatherApiProvider {
  late final Dio _dio;
  
  WeatherApiProvider() {
    _dio = Dio(BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: Constants.connectTimeout,
      receiveTimeout: Constants.receiveTimeout,
      headers: {'Content-Type': 'application/json'},
    ));
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) {
        final customError = _handleDioError(error);
        handler.reject(DioException(
          requestOptions: error.requestOptions,
          error: customError,
        ));
      },
    ));
  }

  Future<WeatherResponse> getCurrentWeather(String query) async {
    try {
      final response = await _dio.get(
        '/current.json',
        queryParameters: {
          'key': Constants.apiKey,
          'q': query,
          'lang': 'es',
        },
      );

      return WeatherResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Tiempo de conexión agotado';
      case DioExceptionType.sendTimeout:
        return 'Tiempo de envío agotado';
      case DioExceptionType.receiveTimeout:
        return 'Tiempo de respuesta agotado';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        switch (statusCode) {
          case 400:
            return 'Solicitud inválida';
          case 401:
            return 'API key inválida';
          case 403:
            return 'Acceso denegado';
          case 404:
            return 'Ciudad no encontrada';
          default:
            return 'Error del servidor ($statusCode)';
        }
      case DioExceptionType.cancel:
        return 'Solicitud cancelada';
      default:
        return 'Error de conexión a internet';
    }
  }

  Future<List<CitySearchResult>> searchCities(String query) async {
  if (query.trim().isEmpty) return [];
  
  try {
    final response = await _dio.get(
      '/search.json',
      queryParameters: {
        'key': Constants.apiKey,
        'q': query.trim(),
      },
    );

    if (response.data is List) {
      return (response.data as List)
          .map((json) => CitySearchResult.fromJson(json))
          .toList();
    }
    
    return [];
  } on DioException catch (e) {
    throw _handleDioError(e);
  }
}


Future<ForecastResponse> getForecastWeather(String query, int days) async {
  try {
    final response = await _dio.get(
      '/forecast.json',
      queryParameters: {
        'key': Constants.apiKey,
        'q': query,
        'days': days.clamp(1, 14), 
        'lang': 'es',
        'aqi': 'no',
        'alerts': 'no',
      },
    );

    return ForecastResponse.fromJson(response.data);
  } on DioException catch (e) {
    throw _handleDioError(e);
  }
}

  void dispose() {
    _dio.close();
  }
}