import 'package:equatable/equatable.dart';

class WeatherCondition extends Equatable {
  final String text;
  final String icon;
  final int code;

  const WeatherCondition({
    required this.text,
    required this.icon,
    required this.code,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      text: json['text'] ?? '',
      icon: json['icon'] ?? '',
      code: json['code'] ?? 0,
    );
  }

  String get fullIconUrl => 'https:$icon';

  @override
  List<Object?> get props => [text, icon, code];
}