import 'package:equatable/equatable.dart';

class CitySearchResult extends Equatable {
  final int id;
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String url;

  const CitySearchResult({
    required this.id,
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.url,
  });

  factory CitySearchResult.fromJson(Map<String, dynamic> json) {
    return CitySearchResult(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      region: json['region'] ?? '',
      country: json['country'] ?? '',
      lat: (json['lat'] ?? 0.0).toDouble(),
      lon: (json['lon'] ?? 0.0).toDouble(),
      url: json['url'] ?? '',
    );
  }

  String get displayName => '$name, $region, $country';
  String get shortDisplayName => region.isNotEmpty ? '$name, $region' : name;

  @override
  List<Object?> get props => [id, name, region, country, lat, lon, url];
}