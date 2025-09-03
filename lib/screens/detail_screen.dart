import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/hourly_forecast_card.dart';
import '../widgets/weather_card.dart';
import '../widgets/air_quality_card.dart';
import '../widgets/uv_index_card.dart';
import '../widgets/sun_times_card.dart';
import '../widgets/pressure_card.dart';
import '../widgets/feels_like_card.dart';
import '../widgets/dynamic_background.dart';
import '../models/weather_data.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  // Helper functions para colores adaptativos
  Color _getTextColor(bool isNight, double opacity) {
    return isNight 
      ? Colors.white.withOpacity(opacity)
      : Colors.black.withOpacity(opacity * 0.9);
  }

  Color _getPrimaryTextColor(bool isNight) {
    return isNight ? Colors.white : Colors.black87;
  }

  Color _getSecondaryTextColor(bool isNight) {
    return isNight 
      ? Colors.white.withOpacity(0.7) 
      : Colors.black.withOpacity(0.8);
  }

  Widget _buildDeveloperCredit(String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          const Icon(
            Icons.person,
            color: Colors.white70,
            size: 14,
          ),
          const SizedBox(width: 6),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherState>(
      builder: (context, weatherState, child) {
        final currentWeather = weatherState.currentLocation;
        final weatherCondition = currentWeather.isNight 
          ? WeatherCondition.night 
          : WeatherCondition.sunny;
        
        return Scaffold(
          body: DynamicBackground(
            weatherCondition: weatherCondition,
            child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.blue.shade300,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      currentWeather.cityName,
                      style: TextStyle(
                        color: _getTextColor(currentWeather.isNight, 0.9),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  currentWeather.currentTemperature,
                  style: TextStyle(
                    color: _getPrimaryTextColor(currentWeather.isNight),
                    fontSize: 52,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currentWeather.weatherCondition,
                  style: TextStyle(
                    color: _getTextColor(currentWeather.isNight, 0.8),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),
                
                SizedBox(
                  height: 140,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      HourlyForecastCard(
                        time: 'Ahora',
                        temperature: '16°',
                        icon: Icons.nights_stay,
                        precipitation: 0,
                      ),
                      HourlyForecastCard(
                        time: '22:00',
                        temperature: '15°',
                        icon: Icons.nights_stay,
                        precipitation: 0,
                      ),
                      HourlyForecastCard(
                        time: '23:00',
                        temperature: '14°',
                        icon: Icons.nights_stay,
                        precipitation: 0,
                      ),
                      HourlyForecastCard(
                        time: '00:00',
                        temperature: '13°',
                        icon: Icons.nights_stay,
                        precipitation: 5,
                      ),
                      HourlyForecastCard(
                        time: '01:00',
                        temperature: '12°',
                        icon: Icons.nights_stay,
                        precipitation: 0,
                      ),
                      HourlyForecastCard(
                        time: '02:00',
                        temperature: '12°',
                        icon: Icons.nights_stay,
                        precipitation: 0,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                
                WeatherCard(
                  title: 'CALIDAD DEL AIRE',
                  content: const AirQualityCard(
                    aqi: 38,
                    level: 'Buena',
                    healthRisk: 'La calidad del aire es satisfactoria',
                  ),
                ),
                
                WeatherCard(
                  title: 'ÍNDICE UV',
                  content: const UVIndexCard(
                    uvIndex: 8,
                    level: 'Muy Alto',
                  ),
                ),
                
                WeatherCard(
                  title: 'AMANECER Y ATARDECER',
                  content: const SunTimesCard(
                    sunrise: '5:58 AM',
                    sunset: '6:32 PM',
                  ),
                ),
                
                WeatherCard(
                  title: 'VIENTO',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            '8',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'km/h',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'SO',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.navigation,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                
                WeatherCard(
                  title: 'PRECIPITACIÓN',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            '0',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'mm',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'en la última hora',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                const PressureCard(
                  pressure: 1018,
                  trend: 'up',
                ),
                const SizedBox(height: 16),

                const FeelsLikeCard(
                  feelsLike: 27,
                  actualTemp: 24,
                ),
                const SizedBox(height: 16),

                WeatherCard(
                  title: 'ALTITUD',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.terrain,
                            color: Colors.brown.shade300,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '2,335',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'msnm',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Arequipa está a gran altitud',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                
                WeatherCard(
                  title: 'Hecho por: ',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.group,
                            color: Colors.blue.shade300,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Equipo de Desarrollo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildDeveloperCredit('Condori Cantuta, Joselin Sharon'),
                      _buildDeveloperCredit('Huaynacho Mango, Jerry Anderson'),  
                      _buildDeveloperCredit('Llaique Chullunquia, Jack Franco'),
                      _buildDeveloperCredit('Quispe Mamani, Jose Gabriel'),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.school,
                            color: Colors.orange.shade300,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'UNSA - Ingeniería de Sistemas',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
        ),
      );
    },
    );
  }
}