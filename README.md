# Weather Application

Una aplicación de clima desarrollada con Flutter que muestra información meteorológica actual y pronósticos de 7 días, con una interfaz moderna y adaptativa según las condiciones climáticas.

## Requisitos

- Flutter: ^3.8.1
- Dart: ^3.8.1
- Android: minSdkVersion 21 (Android 5.0 Lollipop)
- iOS: iOS 11.0+

## Configuración del Proyecto

### Variables de Entorno

La aplicación utiliza la API de WeatherAPI para obtener datos meteorológicos. Para configurar correctamente el proyecto:

1. Crea una cuenta en [WeatherAPI](https://www.weatherapi.com/) y obtén tu API key
2. En el archivo [lib/app/utils/constants.dart](cci:7://file:///c:/Users/Arturon/WindSurf/weatherapp/lib/app/utils/constants.dart:0:0-0:0), reemplaza el valor de `apiKey` con tu propia clave:

```dart
static const String apiKey = 'tu_api_key_aquí';
