import 'package:flutter/material.dart';

class CityCard extends StatefulWidget {
  final String cityName;
  final String country;
  final String currentTemperature;
  final String highTemp;
  final String lowTemp;
  final String weatherCondition;
  final IconData weatherIcon;
  final VoidCallback? onTap;

  const CityCard({
    super.key,
    required this.cityName,
    required this.country,
    required this.currentTemperature,
    required this.highTemp,
    required this.lowTemp,
    required this.weatherCondition,
    required this.weatherIcon,
    this.onTap,
  });

  @override
  State<CityCard> createState() => _CityCardState();
}

class _CityCardState extends State<CityCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.15),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.cityName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          widget.country,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.weatherCondition,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'H:${widget.highTemp} L:${widget.lowTemp}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Icon(
                        widget.weatherIcon,
                        color: Colors.white,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.currentTemperature,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}