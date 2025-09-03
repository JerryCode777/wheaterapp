import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/hourly_forecast_card.dart';
import '../widgets/weather_summary_card.dart';
import '../widgets/dynamic_background.dart';
import '../models/weather_data.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Helper functions para colores adaptativos
  Color _getTextColor(bool isNight, double opacity) {
    return isNight 
      ? Colors.white.withOpacity(opacity)
      : Colors.black.withOpacity(opacity * 0.9); // Más oscuro para día
  }

  Color _getPrimaryTextColor(bool isNight) {
    return isNight ? Colors.white : Colors.black87;
  }

  Color _getSecondaryTextColor(bool isNight) {
    return isNight 
      ? Colors.white.withOpacity(0.7) 
      : Colors.black.withOpacity(0.8);
  }

  Color _getContainerColor(bool isNight, Color baseColor, double opacity) {
    if (isNight) {
      return baseColor.withOpacity(opacity);
    } else {
      // Para día, usar colores más contrastantes
      return baseColor.withOpacity(opacity * 1.5).withValues(
        red: baseColor.red * 0.8,
        green: baseColor.green * 0.8,
        blue: baseColor.blue * 0.8,
        alpha: opacity * 1.5,
      );
    }
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
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: _getContainerColor(currentWeather.isNight, Colors.blue, 0.3),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: _getTextColor(currentWeather.isNight, 0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.location_on,
                                      color: _getTextColor(currentWeather.isNight, 0.9),
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          currentWeather.cityName,
                                          style: TextStyle(
                                            color: _getTextColor(currentWeather.isNight, 0.95),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.3,
                                          ),
                                        ),
                                        Text(
                                          currentWeather.country,
                                          style: TextStyle(
                                            color: _getSecondaryTextColor(currentWeather.isNight),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: _getContainerColor(currentWeather.isNight, Colors.green, 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: _getContainerColor(currentWeather.isNight, Colors.green, 0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.my_location,
                                      color: currentWeather.isNight 
                                        ? Colors.green.shade300
                                        : Colors.green.shade700,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Ubicación actual',
                                      style: TextStyle(
                                        color: currentWeather.isNight 
                                          ? Colors.green.shade100
                                          : Colors.green.shade800,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Mostrar imágenes de UNSA solo si es la ubicación de UNSA
                              if (currentWeather.cityName.contains('UNSA')) ...[
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: _getTextColor(currentWeather.isNight, 0.2),
                                          width: 1,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image.asset(
                                          'assets/images/LOGO_UNSA.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: _getTextColor(currentWeather.isNight, 0.2),
                                          width: 1,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image.asset(
                                          'assets/images/sistemas.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Universidad Nacional de San Agustín',
                                      style: TextStyle(
                                        color: _getSecondaryTextColor(currentWeather.isNight),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.school,
                                      color: _getSecondaryTextColor(currentWeather.isNight),
                                      size: 14,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Escuela Profesional de Ingeniería de Sistemas',
                                      style: TextStyle(
                                        color: _getSecondaryTextColor(currentWeather.isNight),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showDeveloperCredits(context, currentWeather.isNight);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: _getContainerColor(currentWeather.isNight, Colors.white, 0.15),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: _getTextColor(currentWeather.isNight, 0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  Icons.info_outline,
                                  color: _getTextColor(currentWeather.isNight, 0.9),
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    Colors.orange.withOpacity(0.3),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                            Icon(
                              currentWeather.weatherIcon,
                              size: 80,
                              color: currentWeather.isNight 
                                ? Colors.blue.shade300 
                                : Colors.orange.shade300,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: currentWeather.currentTemperature.replaceAll('°', ''),
                                style: TextStyle(
                                  color: _getPrimaryTextColor(currentWeather.isNight),
                                  fontSize: 88,
                                  fontWeight: FontWeight.w100,
                                  height: 0.9,
                                ),
                              ),
                              TextSpan(
                                text: '°C',
                                style: TextStyle(
                                  color: _getTextColor(currentWeather.isNight, 0.8),
                                  fontSize: 32,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          currentWeather.weatherCondition,
                          style: TextStyle(
                            color: _getTextColor(currentWeather.isNight, 0.9),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Se siente como ${currentWeather.additionalInfo['feelsLike']}',
                          style: TextStyle(
                            color: _getSecondaryTextColor(currentWeather.isNight),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currentWeather.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _getSecondaryTextColor(currentWeather.isNight),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildTempInfo('Máx', currentWeather.highTemp, Icons.keyboard_arrow_up),
                            Container(
                              height: 20,
                              width: 1,
                              color: _getTextColor(currentWeather.isNight, 0.3),
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                            ),
                            _buildTempInfo('Mín', currentWeather.lowTemp, Icons.keyboard_arrow_down),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: const WeatherSummaryCard(),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      'Pronóstico por Horas',
                      style: TextStyle(
                        color: _getTextColor(currentWeather.isNight, 0.9),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 140,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
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
                        HourlyForecastCard(
                          time: '03:00',
                          temperature: '11°',
                          icon: Icons.nights_stay,
                          precipitation: 0,
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
        ),
      );
    },
    );
  }

  void _showDeveloperCredits(BuildContext context, bool isNight) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isNight 
                      ? [
                          const Color(0xFF1a1a2e),
                          const Color(0xFF16213e),
                          const Color(0xFF0f3460),
                        ]
                      : [
                          const Color(0xFFF8F9FA),
                          const Color(0xFFE9ECEF),
                          const Color(0xFFDEE2E6),
                        ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isNight 
                      ? Colors.blue.withOpacity(0.3)
                      : Colors.blue.withOpacity(0.2),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isNight
                        ? Colors.blue.withOpacity(0.2)
                        : Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 0,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isNight 
                            ? Colors.white.withOpacity(0.3)
                            : Colors.black.withOpacity(0.2),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/LOGO_UNSA.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.group,
                          color: Colors.blue.shade300,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Hecho por:',
                          style: TextStyle(
                            color: isNight ? Colors.white : Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildDialogDeveloperName('Condori Cantuta, Joselin Sharon', isNight),
                    _buildDialogDeveloperName('Huaynacho Mango, Jerry Anderson', isNight),
                    _buildDialogDeveloperName('Llaique Chullunquia, Jack Franco', isNight),
                    _buildDialogDeveloperName('Quispe Mamani, Jose Gabriel', isNight),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isNight
                            ? [
                                Colors.orange.withOpacity(0.2),
                                Colors.deepOrange.withOpacity(0.1),
                              ]
                            : [
                                Colors.orange.withOpacity(0.15),
                                Colors.deepOrange.withOpacity(0.08),
                              ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.orange.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.school,
                            color: Colors.orange.shade400,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'UNSA - Ingeniería de Sistemas',
                            style: TextStyle(
                              color: isNight ? Colors.white.withOpacity(0.9) : Colors.black87,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          shadowColor: Colors.blue.withOpacity(0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.close, size: 18),
                            const SizedBox(width: 8),
                            const Text(
                              'Cerrar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogDeveloperName(String name, bool isNight) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            Icons.person,
            color: isNight ? Colors.white70 : Colors.black54,
            size: 16,
          ),
          const SizedBox(width: 12),
          Text(
            name,
            style: TextStyle(
              color: isNight ? Colors.white.withOpacity(0.9) : Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildTempInfo(String label, String temp, IconData icon) {
    return Consumer<WeatherState>(
      builder: (context, weatherState, child) {
        final currentWeather = weatherState.currentLocation;
        return Column(
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: _getSecondaryTextColor(currentWeather.isNight),
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: _getSecondaryTextColor(currentWeather.isNight),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              temp,
              style: TextStyle(
                color: _getPrimaryTextColor(currentWeather.isNight),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
    );
  }
}