import 'package:flutter/material.dart';
import '../../data/models/forecast_models.dart';
import '../../utils/weather_styles.dart';

class ForecastCard extends StatelessWidget {
  final List<ForecastDay> forecast;
  final bool isCelsius;
  final Function(int) onDayTap;

  const ForecastCard({
    super.key,
    required this.forecast,
    required this.isCelsius,
    required this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Pronóstico 7 días',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Lista de días
          ...forecast.take(7).map((day) => _buildDayItem(context, day)),
        ],
      ),
    );
  }

  Widget _buildDayItem(BuildContext context, ForecastDay day) {
   
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Día de la semana
          SizedBox(
            width: 50,
            child: Text(
              day.dayOfWeek,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Ícono del clima
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              WeatherStyles.getWeatherIcon(day.day.condition.code),
              color: Colors.white,
              size: 24,
            ),
          ),

          const SizedBox(width: 16),

          // Condición
          Expanded(
            child: Text(
              day.day.condition.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),

          // Probabilidad de lluvia
          if (day.day.dailyChanceOfRain > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${day.day.dailyChanceOfRain}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

          const SizedBox(width: 12),

          // Temperaturas
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${day.day.getMaxTemp(isCelsius).round()}°',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${day.day.getMinTemp(isCelsius).round()}°',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
