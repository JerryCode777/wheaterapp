import 'package:flutter/material.dart';

class WeatherData {
  final String cityName;
  final String country;
  final String currentTemperature;
  final String highTemp;
  final String lowTemp;
  final String weatherCondition;
  final IconData weatherIcon;
  final bool isNight;
  final String description;
  final Map<String, dynamic> additionalInfo;

  const WeatherData({
    required this.cityName,
    required this.country,
    required this.currentTemperature,
    required this.highTemp,
    required this.lowTemp,
    required this.weatherCondition,
    required this.weatherIcon,
    required this.isNight,
    required this.description,
    required this.additionalInfo,
  });
}

class WeatherState with ChangeNotifier {
  WeatherData _currentLocation = const WeatherData(
    cityName: 'UNSA - Arequipa',
    country: 'Universidad Nacional San Agustín',
    currentTemperature: '16°',
    highTemp: '28°',
    lowTemp: '12°',
    weatherCondition: 'Noche despejada',
    weatherIcon: Icons.nights_stay,
    isNight: true,
    description: 'Noche tranquila y estrellada en la Ciudad Blanca',
    additionalInfo: {
      'humidity': '55%',
      'pressure': '1015 hPa',
      'visibility': '15 km',
      'dewPoint': '8°C',
      'uvIndex': 0,
      'uvLevel': 'Bajo',
      'windSpeed': '5 km/h',
      'windDirection': 'SO',
      'sunrise': '5:58 AM',
      'sunset': '6:32 PM',
      'altitude': '2,335 msnm',
      'feelsLike': '18°',
    },
  );

  WeatherData get currentLocation => _currentLocation;

  void updateLocation(WeatherData newLocation) {
    _currentLocation = newLocation;
    notifyListeners();
  }
}