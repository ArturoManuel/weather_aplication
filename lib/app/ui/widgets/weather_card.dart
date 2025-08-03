

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/app/data/models/forecast_models.dart';
import '../../utils/weather_styles.dart';

class WeatherCard extends StatelessWidget {
  final ForecastResponse forecast;
  final bool isCelsius;
  final VoidCallback onTemperatureToggle;

  const WeatherCard({
    super.key,
    required this.forecast,
    required this.isCelsius,
    required this.onTemperatureToggle,
  });

  @override
  Widget build(BuildContext context) {
    final current = forecast.current;
    final location = forecast.location;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: WeatherStyles.getWeatherGradient(
          current.condition.code,
          isDark,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Ícono grande centrado
            CachedNetworkImage(
              imageUrl: current.condition.fullIconUrl,
              width: 140,
              height: 140,
              fit: BoxFit.contain,
              placeholder: (context, url) => Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.cloud, size: 70, color: Colors.white),
              ),
            ),

            const SizedBox(height: 32),

            // Temperatura masiva
            GestureDetector(
              onTap: onTemperatureToggle,
              child: Text(
                '${current.getTemperature(isCelsius).round()}°',
                style: const TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                  height: 0.8,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Condición centrada
            Text(
              current.condition.text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            Text(
              _formatTime(location.localtime),
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),

            const SizedBox(height: 24),

            // Información compacta en una línea
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInlineDetail(Icons.water_drop, '${current.humidity}%'),
                  _buildDivider(),
                  _buildInlineDetail(Icons.air, '${current.windKph.round()}'),
                  _buildDivider(),
                  _buildInlineDetail(
                    Icons.visibility,
                    '${current.visKm.round()}km',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInlineDetail(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: Colors.white.withValues(alpha: 0.8)),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 20,
      color: Colors.white.withValues(alpha: 0.3),
    );
  }

  String _formatTime(String datetime) {
    try {
      final parts = datetime.split(' ');
      if (parts.length == 2) {
        return parts[1];
      }
      return datetime;
    } catch (e) {
      return datetime;
    }
  }
}
