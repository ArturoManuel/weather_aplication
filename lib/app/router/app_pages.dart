import 'package:get/get.dart';
import 'package:weatherapp/app/bindings/home_binding.dart';
import 'package:weatherapp/app/router/app_router.dart';
import '../ui/pages/home_page.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}