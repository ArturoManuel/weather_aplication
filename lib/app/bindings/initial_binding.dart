
import 'package:get/get.dart';
import 'package:weatherapp/app/data/repositories/weather_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WeatherRepository>(WeatherRepository(), permanent: true);
  }
}