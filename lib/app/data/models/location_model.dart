import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tzId;
  final String localtime;

  const LocationModel({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtime,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'] ?? '',
      region: json['region'] ?? '',
      country: json['country'] ?? '',
      lat: (json['lat'] ?? 0.0).toDouble(),
      lon: (json['lon'] ?? 0.0).toDouble(),
      tzId: json['tz_id'] ?? '',
      localtime: json['localtime'] ?? '',
    );
  }

  @override
  List<Object?> get props => [name, region, country, lat, lon, tzId, localtime];

  @override
  String toString() => '$name, $region, $country';
}