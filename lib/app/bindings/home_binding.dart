

import 'package:get/get.dart';
import 'package:weatherapp/app/controllers/weather_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeatherController>(() => WeatherController());
  }
}