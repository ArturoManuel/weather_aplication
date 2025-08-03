

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/app/ui/widgets/city_search_modal.dart';
import 'package:weatherapp/app/ui/widgets/forest_card.dart';
import 'package:weatherapp/app/ui/widgets/hourly_forestcard.dart';
import '../../controllers/weather_controller.dart';
import '../widgets/weather_card.dart';
import '../../utils/weather_styles.dart';

class HomePage extends GetView<WeatherController> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Obx(
          () => Text(
            controller.forecast?.location.name ?? 'Weather App',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () => showCitySearchModal(context),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: const Icon(Icons.search, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        final conditionCode =
            controller.forecast?.current.condition.code ?? 1000;
        final backgroundGradient = WeatherStyles.getWeatherGradient(
          conditionCode,
          isDark,
        );

        return Container(
          decoration: BoxDecoration(gradient: backgroundGradient),
          child: _buildBodyContent(context, isDark),
        );
      }),
    );
  }

  Widget _buildBodyContent(BuildContext context, bool isDark) {
    if (controller.isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
            SizedBox(height: 16),
            Text(
              'Cargando clima...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    if (controller.error.isNotEmpty) {
      return _buildErrorState(context);
    }

    if (controller.forecast != null) {
      return RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.black.withValues(alpha: 0.8),
        onRefresh: () async {
          controller.refreshWeather();
          while (controller.isLoading) {
            await Future.delayed(const Duration(milliseconds: 100));
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      WeatherCard(
                        forecast: controller.forecast!,
                        isCelsius: controller.isCelsius,
                        onTemperatureToggle: controller.toggleTemperatureUnit,
                      ),
                      const SizedBox(height: 16),

                      HourlyForecast(
                        hourlyData: controller
                            .forecast!
                            .forecast
                            .forecastday
                            .first
                            .hour,
                        isCelsius: controller.isCelsius,
                      ),

                      const SizedBox(height: 16),

                      ForecastCard(
                        forecast: controller.forecast!.forecast.forecastday,
                        isCelsius: controller.isCelsius,
                        onDayTap: (index) {
                          // Navegar a detalle del día
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    return const Center(
      child: Text(
        'No hay datos disponibles',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.cloud_off_rounded,
                size: 48,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              '¡Oops! Algo salió mal',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            const Text(
              'No pudimos cargar la información del clima',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.amber, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      controller.error,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: controller.refreshWeather,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.refresh_rounded, size: 20),
                    label: const Text(
                      'Intentar de nuevo',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => showCitySearchModal(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.search, size: 20),
                    label: const Text(
                      'Buscar otra ciudad',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

 
}
