import 'package:flutter/material.dart';
import 'dart:math' as math;

enum WeatherCondition {
  sunny,
  cloudy,
  rainy,
  night,
  cold,
}

class DynamicBackground extends StatefulWidget {
  final Widget child;
  final WeatherCondition weatherCondition;
  
  const DynamicBackground({
    super.key,
    required this.child,
    required this.weatherCondition,
  });

  @override
  State<DynamicBackground> createState() => _DynamicBackgroundState();
}

class _DynamicBackgroundState extends State<DynamicBackground>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _cloudController;
  late List<CloudParticle> clouds;
  late List<Star> stars;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    
    _cloudController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
    
    _generateParticles();
  }

  void _generateParticles() {
    // Generate clouds for day time
    clouds = List.generate(6, (index) {
      return CloudParticle(
        x: math.Random().nextDouble(),
        y: math.Random().nextDouble() * 0.4, // Upper part of screen
        size: math.Random().nextDouble() * 30 + 20,
        opacity: math.Random().nextDouble() * 0.6 + 0.2,
        speed: math.Random().nextDouble() * 0.5 + 0.3,
      );
    });

    // Generate stars for night time
    stars = List.generate(60, (index) {
      return Star(
        x: math.Random().nextDouble(),
        y: math.Random().nextDouble(),
        size: math.Random().nextDouble() * 2 + 0.5,
        opacity: math.Random().nextDouble() * 0.8 + 0.2,
        twinkleSpeed: math.Random().nextDouble() * 2 + 1,
      );
    });
  }

  LinearGradient _getGradientForWeather() {
    switch (widget.weatherCondition) {
      case WeatherCondition.sunny:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF4FC3F7), // Light blue sky
            Color(0xFF29B6F6), // Medium blue
            Color(0xFF03A9F4), // Blue
            Color(0xFF0288D1), // Darker blue
          ],
          stops: [0.0, 0.3, 0.7, 1.0],
        );
      case WeatherCondition.cloudy:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF90A4AE), // Gray blue
            Color(0xFF78909C), // Medium gray
            Color(0xFF607D8B), // Blue gray
            Color(0xFF546E7A), // Darker gray
          ],
          stops: [0.0, 0.3, 0.7, 1.0],
        );
      case WeatherCondition.rainy:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF546E7A), // Dark gray
            Color(0xFF455A64), // Darker gray
            Color(0xFF37474F), // Very dark gray
            Color(0xFF263238), // Almost black
          ],
          stops: [0.0, 0.3, 0.7, 1.0],
        );
      case WeatherCondition.cold:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF81D4FA), // Light cyan
            Color(0xFF4FC3F7), // Cyan
            Color(0xFF29B6F6), // Blue cyan
            Color(0xFF0288D1), // Blue
          ],
          stops: [0.0, 0.3, 0.7, 1.0],
        );
      case WeatherCondition.night:
      default:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1A1A2E),
            Color(0xFF16213E),
            Color(0xFF0F3460),
            Color(0xFF533483),
          ],
          stops: [0.0, 0.3, 0.7, 1.0],
        );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _cloudController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: _getGradientForWeather(),
          ),
        ),
        // Add particles based on weather condition
        if (widget.weatherCondition == WeatherCondition.night)
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return CustomPaint(
                  painter: StarPainter(
                    stars: stars,
                    animation: _animationController.value,
                  ),
                );
              },
            ),
          ),
        if (widget.weatherCondition == WeatherCondition.sunny ||
            widget.weatherCondition == WeatherCondition.cloudy)
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _cloudController,
              builder: (context, child) {
                return CustomPaint(
                  painter: CloudPainter(
                    clouds: clouds,
                    animation: _cloudController.value,
                  ),
                );
              },
            ),
          ),
        widget.child,
      ],
    );
  }
}

class CloudParticle {
  final double x;
  final double y;
  final double size;
  final double opacity;
  final double speed;

  CloudParticle({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
    required this.speed,
  });
}

class Star {
  final double x;
  final double y;
  final double size;
  final double opacity;
  final double twinkleSpeed;

  Star({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
    required this.twinkleSpeed,
  });
}

class CloudPainter extends CustomPainter {
  final List<CloudParticle> clouds;
  final double animation;

  CloudPainter({
    required this.clouds,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final cloud in clouds) {
      final currentX = (cloud.x + animation * cloud.speed * 0.1) % 1.2 - 0.1;
      final paint = Paint()
        ..color = Colors.white.withOpacity(cloud.opacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      final center = Offset(
        currentX * size.width,
        cloud.y * size.height,
      );

      // Draw fluffy cloud shape
      canvas.drawCircle(center, cloud.size * 0.6, paint);
      canvas.drawCircle(
        Offset(center.dx + cloud.size * 0.4, center.dy),
        cloud.size * 0.5,
        paint,
      );
      canvas.drawCircle(
        Offset(center.dx - cloud.size * 0.3, center.dy),
        cloud.size * 0.4,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class StarPainter extends CustomPainter {
  final List<Star> stars;
  final double animation;

  StarPainter({
    required this.stars,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final star in stars) {
      final twinkle = (math.sin(animation * 2 * math.pi * star.twinkleSpeed) + 1) / 2;
      final currentOpacity = star.opacity * twinkle * 0.8;
      
      final paint = Paint()
        ..color = Colors.white.withOpacity(currentOpacity)
        ..style = PaintingStyle.fill;

      final center = Offset(
        star.x * size.width,
        star.y * size.height,
      );

      canvas.drawCircle(center, star.size, paint);

      if (star.size > 1.5) {
        final rayPaint = Paint()
          ..color = Colors.white.withOpacity(currentOpacity * 0.5)
          ..strokeWidth = 0.5
          ..style = PaintingStyle.stroke;

        canvas.drawLine(
          Offset(center.dx, center.dy - star.size * 3),
          Offset(center.dx, center.dy + star.size * 3),
          rayPaint,
        );

        canvas.drawLine(
          Offset(center.dx - star.size * 3, center.dy),
          Offset(center.dx + star.size * 3, center.dy),
          rayPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}