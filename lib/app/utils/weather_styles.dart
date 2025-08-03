import 'package:flutter/material.dart';


class WeatherStyles {
  
  static LinearGradient getWeatherGradient(int conditionCode, bool isDark) {
   
    if (conditionCode == 1000) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [
                const Color(0xFF1C1917),
                const Color(0xFF44403C),
                const Color(0xFF78716C),
              ]
            : [
                const Color(0xFFFBBF24),
                const Color(0xFFF59E0B),
                const Color(0xFFD97706),
              ],
      );
    }
    // Códigos de clima parcialmente nublado
    else if (conditionCode == 1003 ||
        conditionCode == 1006 ||
        conditionCode == 1009 ||
        conditionCode == 1030 ||
        conditionCode == 1135 ||
        conditionCode == 1147) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [
                const Color(0xFF374151),
                const Color(0xFF4B5563),
                const Color(0xFF6B7280),
              ]
            : [
                const Color(0xFF9CA3AF),
                const Color(0xFF6B7280),
                const Color(0xFF4B5563),
              ],
      );
    }
    // Códigos de lluvia o llovizna
    else if ((conditionCode >= 1063 && conditionCode <= 1072) ||
        (conditionCode >= 1150 && conditionCode <= 1201) ||
        (conditionCode >= 1240 && conditionCode <= 1252)) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [
                const Color(0xFF1E293B),
                const Color(0xFF334155),
                const Color(0xFF475569),
              ]
            : [
                const Color(0xFF64748B),
                const Color(0xFF475569),
                const Color(0xFF334155),
              ],
      );
    }
    // Códigos de nieve o hielo
    else if ((conditionCode >= 1066 && conditionCode <= 1069) ||
        (conditionCode >= 1114 && conditionCode <= 1117) ||
        (conditionCode >= 1204 && conditionCode <= 1237) ||
        (conditionCode >= 1255 && conditionCode <= 1264)) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [
                const Color(0xFF1E3A8A),
                const Color(0xFF3730A3),
                const Color(0xFF581C87),
              ]
            : [
                const Color(0xFF93C5FD),
                const Color(0xFF60A5FA),
                const Color(0xFF3B82F6),
              ],
      );
    }
    // Códigos de tormenta
    else if (conditionCode == 1087 ||
        (conditionCode >= 1273 && conditionCode <= 1282)) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [
                const Color(0xFF1E1B4B),
                const Color(0xFF312E81),
                const Color(0xFF4338CA),
              ]
            : [
                const Color(0xFF6366F1),
                const Color(0xFF4F46E5),
                const Color(0xFF4338CA),
              ],
      );
    }
    // Gradiente predeterminado (azul)
    else {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [
                const Color(0xFF1E3A8A),
                const Color(0xFF1E40AF),
                const Color(0xFF3730A3),
              ]
            : [
                const Color(0xFF3B82F6),
                const Color(0xFF2563EB),
                const Color(0xFF1D4ED8),
              ],
      );
    }
  }

  /// Devuelve un ícono basado en el código de condición meteorológica
  static IconData getWeatherIcon(int conditionCode) {
    switch (conditionCode) {
      case 1000: // Soleado
        return Icons.wb_sunny;
      case 1003: // Parcialmente nublado
        return Icons.wb_cloudy;
      case 1006: // Nublado
      case 1009: // Cielo cubierto
        return Icons.cloud;
      case 1030: // Neblina
      case 1135: // Niebla
      case 1147: // Niebla helada
        return Icons.foggy;
      case 1063: // Lluvia dispersa
      case 1180: // Lluvia ligera
      case 1183: // Lluvia ligera
      case 1186: // Lluvia moderada
      case 1189: // Lluvia moderada
      case 1192: // Lluvia fuerte
      case 1195: // Lluvia fuerte
        return Icons.grain;
      case 1066: // Nieve dispersa
      case 1114: // Ventisca
      case 1117: // Tormenta de nieve
      case 1210: // Nieve ligera
      case 1213: // Nieve ligera
      case 1216: // Nieve moderada
      case 1219: // Nieve moderada
      case 1222: // Nieve fuerte
      case 1225: // Nieve fuerte
        return Icons.ac_unit;
      case 1087: // Truenos
      case 1273: // Lluvia con truenos ligera
      case 1276: // Lluvia con truenos moderada o fuerte
      case 1279: // Nieve con truenos ligera
      case 1282: // Nieve con truenos moderada o fuerte
        return Icons.flash_on;
      default:
        return Icons.wb_sunny;
    }
  }

  /// Color secundario para el fondo de los widgets del clima
  static Color getWeatherSecondaryColor(int conditionCode, bool isDark) {
    // Códigos de clima soleado
    if (conditionCode == 1000) {
      return isDark
          ? const Color(0xFF44403C).withValues(alpha: 0.7)
          : const Color(0xFFF59E0B).withValues(alpha: 0.7);
    }
    // Códigos de clima parcialmente nublado
    else if (conditionCode == 1003 ||
        conditionCode == 1006 ||
        conditionCode == 1009 ||
        conditionCode == 1030 ||
        conditionCode == 1135 ||
        conditionCode == 1147) {
      return isDark
          ? const Color(0xFF4B5563).withValues(alpha: 0.7)
          : const Color(0xFF6B7280).withValues(alpha: 0.7);
    }
    // Códigos de lluvia o llovizna
    else if ((conditionCode >= 1063 && conditionCode <= 1072) ||
        (conditionCode >= 1150 && conditionCode <= 1201) ||
        (conditionCode >= 1240 && conditionCode <= 1252)) {
      return isDark
          ? const Color(0xFF334155).withValues(alpha: 0.7)
          : const Color(0xFF475569).withValues(alpha: 0.7);
    }
    // Códigos de nieve o hielo
    else if ((conditionCode >= 1066 && conditionCode <= 1069) ||
        (conditionCode >= 1114 && conditionCode <= 1117) ||
        (conditionCode >= 1204 && conditionCode <= 1237) ||
        (conditionCode >= 1255 && conditionCode <= 1264)) {
      return isDark
          ? const Color(0xFF3730A3).withValues(alpha: 0.7)
          : const Color(0xFF60A5FA).withValues(alpha: 0.7);
    }
    // Códigos de tormenta
    else if (conditionCode == 1087 ||
        (conditionCode >= 1273 && conditionCode <= 1282)) {
      return isDark
          ? const Color(0xFF312E81).withValues(alpha: 0.7)
          : const Color(0xFF4F46E5).withValues(alpha: 0.7);
    }
    // Color predeterminado (azul)
    else {
      return isDark
          ? const Color(0xFF1E40AF).withValues(alpha: 0.7)
          : const Color(0xFF2563EB).withValues(alpha: 0.7);
    }
  }
}
