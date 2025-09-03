import 'package:flutter/material.dart';
import 'dart:ui';

class HourlyForecastCard extends StatefulWidget {
  final String time;
  final String temperature;
  final IconData icon;
  final int precipitation;

  const HourlyForecastCard({
    super.key,
    required this.time,
    required this.temperature,
    required this.icon,
    required this.precipitation,
  });

  @override
  State<HourlyForecastCard> createState() => _HourlyForecastCardState();
}

class _HourlyForecastCardState extends State<HourlyForecastCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getIconColor() {
    switch (widget.icon) {
      case Icons.wb_sunny:
        return Colors.orange.shade300;
      case Icons.cloud:
        return Colors.grey.shade300;
      case Icons.nights_stay:
        return Colors.blue.shade300;
      case Icons.grain:
        return Colors.blue.shade400;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _animationController.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _animationController.reverse();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 70,
              height: 140,
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _isPressed
                      ? [
                          Colors.white.withOpacity(0.3),
                          Colors.white.withOpacity(0.2),
                        ]
                      : [
                          Colors.white.withOpacity(0.2),
                          Colors.white.withOpacity(0.1),
                        ],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          widget.time,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _getIconColor().withOpacity(0.2),
                        ),
                        child: Icon(
                          widget.icon,
                          color: _getIconColor(),
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 6),
                      if (widget.precipitation > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${widget.precipitation}%',
                            style: TextStyle(
                              color: Colors.blue.shade200,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      if (widget.precipitation > 0) const SizedBox(height: 4),
                      Flexible(
                        child: Text(
                          widget.temperature,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
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
      ),
    );
  }
}