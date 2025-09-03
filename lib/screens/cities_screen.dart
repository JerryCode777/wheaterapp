import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/city_card.dart';
import '../widgets/dynamic_background.dart';
import '../models/weather_data.dart';

class CitiesScreen extends StatefulWidget {
  const CitiesScreen({super.key});

  @override
  State<CitiesScreen> createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _allCities = [
    {
      'cityName': 'UNSA - Arequipa',
      'country': 'Universidad Nacional San Agustín',
      'currentTemperature': '16°',
      'highTemp': '28°',
      'lowTemp': '12°',
      'weatherCondition': 'Noche despejada',
      'weatherIcon': Icons.nights_stay,
      'isNight': true,
      'description': 'Noche tranquila y estrellada en la Ciudad Blanca',
      'additionalInfo': {
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
    },
    // Ciudades de Perú (noche - 21:00 hora local)
    {
      'cityName': 'Lima',
      'country': 'Perú - Costa',
      'currentTemperature': '18°',
      'highTemp': '25°',
      'lowTemp': '16°',
      'weatherCondition': 'Noche despejada',
      'weatherIcon': Icons.nights_stay,
      'isNight': true,
      'description': 'Noche tranquila en la capital con brisa marina',
      'additionalInfo': {
        'humidity': '82%',
        'pressure': '1016 hPa',
        'visibility': '6 km',
        'dewPoint': '15°C',
        'uvIndex': 0,
        'uvLevel': 'Bajo',
        'windSpeed': '8 km/h',
        'windDirection': 'SO',
        'sunrise': '6:15 AM',
        'sunset': '6:45 PM',
        'altitude': '154 msnm',
        'feelsLike': '20°',
      },
    },
    {
      'cityName': 'Cusco',
      'country': 'Perú - Sierra Imperial',
      'currentTemperature': '12°',
      'highTemp': '21°',
      'lowTemp': '6°',
      'weatherCondition': 'Noche estrellada',
      'weatherIcon': Icons.nights_stay,
      'isNight': true,
      'description': 'Noche fría y clara en los Andes cusqueños',
      'additionalInfo': {
        'humidity': '65%',
        'pressure': '758 hPa',
        'visibility': '15 km',
        'dewPoint': '6°C',
        'uvIndex': 0,
        'uvLevel': 'Bajo',
        'windSpeed': '4 km/h',
        'windDirection': 'E',
        'sunrise': '5:45 AM',
        'sunset': '6:15 PM',
        'altitude': '3,399 msnm',
        'feelsLike': '10°',
      },
    },
    {
      'cityName': 'Trujillo',
      'country': 'Perú - Ciudad de la Primavera',
      'currentTemperature': '22°',
      'highTemp': '29°',
      'lowTemp': '19°',
      'weatherCondition': 'Noche cálida',
      'weatherIcon': Icons.nights_stay,
      'isNight': true,
      'description': 'Noche templada con brisa norteña',
      'additionalInfo': {
        'humidity': '75%',
        'pressure': '1015 hPa',
        'visibility': '12 km',
        'dewPoint': '18°C',
        'uvIndex': 0,
        'uvLevel': 'Bajo',
        'windSpeed': '10 km/h',
        'windDirection': 'SO',
        'sunrise': '6:05 AM',
        'sunset': '6:35 PM',
        'altitude': '34 msnm',
        'feelsLike': '25°',
      },
    },
    {
      'cityName': 'Iquitos',
      'country': 'Perú - Puerta de la Amazonía',
      'currentTemperature': '26°',
      'highTemp': '35°',
      'lowTemp': '23°',
      'weatherCondition': 'Noche húmeda',
      'weatherIcon': Icons.nights_stay,
      'isNight': true,
      'description': 'Noche cálida en la selva amazónica',
      'additionalInfo': {
        'humidity': '88%',
        'pressure': '1011 hPa',
        'visibility': '5 km',
        'dewPoint': '24°C',
        'uvIndex': 0,
        'uvLevel': 'Bajo',
        'windSpeed': '3 km/h',
        'windDirection': 'N',
        'sunrise': '6:00 AM',
        'sunset': '6:30 PM',
        'altitude': '106 msnm',
        'feelsLike': '30°',
      },
    },
    // Ciudades de Inglaterra (día - 14:00 hora local, UTC+0)
    {
      'cityName': 'London',
      'country': 'Reino Unido - Inglaterra',
      'currentTemperature': '11°',
      'highTemp': '14°',
      'lowTemp': '8°',
      'weatherCondition': 'Parcialmente nublado',
      'weatherIcon': Icons.wb_cloudy,
      'isNight': false,
      'description': 'Tarde londinense típica con nubes dispersas',
      'additionalInfo': {
        'humidity': '75%',
        'pressure': '1012 hPa',
        'visibility': '8 km',
        'dewPoint': '7°C',
        'uvIndex': 3,
        'uvLevel': 'Moderado',
        'windSpeed': '15 km/h',
        'windDirection': 'SO',
        'sunrise': '7:45 AM',
        'sunset': '4:15 PM',
        'altitude': '35 msnm',
        'feelsLike': '8°',
      },
    },
    {
      'cityName': 'Manchester',
      'country': 'Reino Unido - Inglaterra',
      'currentTemperature': '9°',
      'highTemp': '12°',
      'lowTemp': '6°',
      'weatherCondition': 'Nublado',
      'weatherIcon': Icons.cloud,
      'isNight': false,
      'description': 'Tarde gris típica del norte de Inglaterra',
      'additionalInfo': {
        'humidity': '80%',
        'pressure': '1010 hPa',
        'visibility': '6 km',
        'dewPoint': '6°C',
        'uvIndex': 2,
        'uvLevel': 'Bajo',
        'windSpeed': '18 km/h',
        'windDirection': 'O',
        'sunrise': '8:00 AM',
        'sunset': '4:00 PM',
        'altitude': '38 msnm',
        'feelsLike': '6°',
      },
    },
    {
      'cityName': 'Birmingham',
      'country': 'Reino Unido - Inglaterra',
      'currentTemperature': '10°',
      'highTemp': '13°',
      'lowTemp': '7°',
      'weatherCondition': 'Niebla ligera',
      'weatherIcon': Icons.cloud,
      'isNight': false,
      'description': 'Tarde con neblina en el centro de Inglaterra',
      'additionalInfo': {
        'humidity': '85%',
        'pressure': '1011 hPa',
        'visibility': '4 km',
        'dewPoint': '8°C',
        'uvIndex': 1,
        'uvLevel': 'Bajo',
        'windSpeed': '10 km/h',
        'windDirection': 'SO',
        'sunrise': '7:50 AM',
        'sunset': '4:10 PM',
        'altitude': '140 msnm',
        'feelsLike': '7°',
      },
    },
    {
      'cityName': 'Liverpool',
      'country': 'Reino Unido - Inglaterra',
      'currentTemperature': '12°',
      'highTemp': '15°',
      'lowTemp': '9°',
      'weatherCondition': 'Ventoso',
      'weatherIcon': Icons.wb_cloudy,
      'isNight': false,
      'description': 'Tarde ventosa junto al río Mersey',
      'additionalInfo': {
        'humidity': '72%',
        'pressure': '1008 hPa',
        'visibility': '12 km',
        'dewPoint': '7°C',
        'uvIndex': 2,
        'uvLevel': 'Bajo',
        'windSpeed': '24 km/h',
        'windDirection': 'NO',
        'sunrise': '8:05 AM',
        'sunset': '3:55 PM',
        'altitude': '70 msnm',
        'feelsLike': '8°',
      },
    },
  ];

  List<Map<String, dynamic>> _filteredCities = [];

  @override
  void initState() {
    super.initState();
    _filteredCities = _allCities;
    _searchController.addListener(_filterCities);
  }

  void _filterCities() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCities = _allCities
          .where((city) =>
              city['cityName'].toLowerCase().contains(query) ||
              city['country'].toLowerCase().contains(query))
          .toList();
    });
  }

  void _onCitySelected(Map<String, dynamic> city) {
    final weatherData = WeatherData(
      cityName: city['cityName'],
      country: city['country'],
      currentTemperature: city['currentTemperature'],
      highTemp: city['highTemp'],
      lowTemp: city['lowTemp'],
      weatherCondition: city['weatherCondition'],
      weatherIcon: city['weatherIcon'],
      isNight: city['isNight'],
      description: city['description'],
      additionalInfo: city['additionalInfo'],
    );
    
    Provider.of<WeatherState>(context, listen: false).updateLocation(weatherData);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${city['cityName']} seleccionada - ${city['weatherCondition']}',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.withOpacity(0.8),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'El Tiempo',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Buscar ciudad o aeropuerto',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _filteredCities.length,
                  itemBuilder: (context, index) {
                    final city = _filteredCities[index];
                    return AnimatedOpacity(
                      opacity: 1.0,
                      duration: Duration(milliseconds: 200 + (index * 50)),
                      child: CityCard(
                        cityName: city['cityName'],
                        country: city['country'],
                        currentTemperature: city['currentTemperature'],
                        highTemp: city['highTemp'],
                        lowTemp: city['lowTemp'],
                        weatherCondition: city['weatherCondition'],
                        weatherIcon: city['weatherIcon'],
                        onTap: () => _onCitySelected(city),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
        ),
      );
    },
    );
  }
}