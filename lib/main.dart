import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/cities_screen.dart';
import 'models/weather_data.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherState(),
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          fontFamily: 'SF Pro Display',
        ),
        home: const MainScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const DetailScreen(),
    const CitiesScreen(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: IndexedStack(
          key: ValueKey(_selectedIndex),
          index: _selectedIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF1a1a2e).withOpacity(0.95),
              const Color(0xFF16213e).withOpacity(0.98),
            ],
          ),
          border: Border(
            top: BorderSide(
              color: Colors.blue.withOpacity(0.2),
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blue.shade300,
              unselectedItemColor: Colors.grey.shade400,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 11,
            ),
            items: [
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.all(_selectedIndex == 0 ? 6 : 0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: _selectedIndex == 0
                        ? RadialGradient(
                            colors: [
                              Colors.blue.withOpacity(0.4),
                              Colors.blue.withOpacity(0.1),
                            ],
                          )
                        : null,
                    boxShadow: _selectedIndex == 0
                        ? [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                  child: const Icon(Icons.access_time, size: 24),
                ),
                label: 'Por Horas',
              ),
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.all(_selectedIndex == 1 ? 6 : 0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: _selectedIndex == 1
                        ? RadialGradient(
                            colors: [
                              Colors.blue.withOpacity(0.4),
                              Colors.blue.withOpacity(0.1),
                            ],
                          )
                        : null,
                    boxShadow: _selectedIndex == 1
                        ? [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                  child: const Icon(Icons.add_location, size: 24),
                ),
                label: 'Detalles',
              ),
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.all(_selectedIndex == 2 ? 6 : 0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: _selectedIndex == 2
                        ? RadialGradient(
                            colors: [
                              Colors.blue.withOpacity(0.4),
                              Colors.blue.withOpacity(0.1),
                            ],
                          )
                        : null,
                    boxShadow: _selectedIndex == 2
                        ? [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                  child: const Icon(Icons.location_on, size: 24),
                ),
                label: 'Ciudades',
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}
