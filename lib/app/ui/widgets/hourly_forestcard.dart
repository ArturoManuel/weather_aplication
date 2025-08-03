import 'package:flutter/material.dart';
import 'package:weatherapp/app/data/models/forecast_models.dart';

class HourlyForecast extends StatelessWidget {
  final List<HourWeather> hourlyData;
  final bool isCelsius;

  const HourlyForecast({
    super.key,
    required this.hourlyData,
    required this.isCelsius,
  });

  @override
  Widget build(BuildContext context) {
    
    final next24Hours = hourlyData.take(24).toList();
    
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
              const Icon(Icons.schedule, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Próximas 24 horas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: next24Hours.length,
              itemBuilder: (context, index) {
                final hour = next24Hours[index];
                return _buildHourItem(hour);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourItem(HourWeather hour) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          // Hora
          Text(
            hour.hourOnly,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Ícono
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getWeatherIcon(hour.condition.code),
              color: Colors.white,
              size: 20,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Temperatura
          Text(
            '${hour.getTemperature(isCelsius).round()}°',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          // Probabilidad de lluvia
          if (hour.chanceOfRain > 0)
            Text(
              '${hour.chanceOfRain}%',
              style: TextStyle(
                color: Colors.blue[200],
                fontSize: 10,
              ),
            ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(int code) {
    switch (code) {
      case 1000: return Icons.wb_sunny;
      case 1003: return Icons.wb_cloudy;
      case 1063: return Icons.grain;
      case 1087: return Icons.flash_on;
      default: return Icons.wb_sunny;
    }
  }
}