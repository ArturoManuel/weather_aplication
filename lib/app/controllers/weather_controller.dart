import 'package:get/get.dart';
import 'package:weatherapp/app/data/models/current_weather_model.dart';
import 'package:weatherapp/app/data/models/forecast_models.dart';
import 'package:weatherapp/app/data/models/location_model.dart';
import 'package:weatherapp/app/data/repositories/weather_repository.dart';
import 'package:weatherapp/app/utils/constants.dart';

class WeatherController extends GetxController {
  final WeatherRepository _repository = Get.find();

  final _forecast = Rxn<ForecastResponse>();
  final _isLoading = false.obs;
  final _error = ''.obs;
  final _selectedCity = Constants.defaultCity.obs;
  final _isCelsius = true.obs;
  final _selectedDays = 7.obs;

  // Getters
  ForecastResponse? get forecast => _forecast.value;
  bool get isLoading => _isLoading.value;
  String get error => _error.value;
  String get selectedCity => _selectedCity.value;
  bool get isCelsius => _isCelsius.value;
  int get selectedDays => _selectedDays.value;

  CurrentWeatherModel? get currentWeather => _forecast.value?.current;
  LocationModel? get location => _forecast.value?.location;
  List<ForecastDay> get forecastDays =>
      _forecast.value?.forecast.forecastday ?? [];

  @override
  void onInit() {
    super.onInit();
    fetchForecast();
  }

  @override
  void onClose() {
    _repository.dispose();
    super.onClose();
  }

  Future<void> fetchForecast([String? city, int? days]) async {
    try {
      _isLoading.value = true;
      _error.value = '';

      final cityName = city ?? _selectedCity.value;
      final forecastDays = days ?? _selectedDays.value;

      final forecastData = await _repository.getForecastWeather(
        cityName,
        forecastDays,
      );

      _forecast.value = forecastData;
      _selectedCity.value = cityName;
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  void toggleTemperatureUnit() {
    _isCelsius.value = !_isCelsius.value;
  }

  void changeCity(String city) {
    if (city != _selectedCity.value) {
      fetchForecast(city);
    }
  }

  void setForecastDays(int days) {
    _selectedDays.value = days.clamp(1, 14);
    fetchForecast();
  }

  void refreshWeather() {
    fetchForecast();
  }
}
