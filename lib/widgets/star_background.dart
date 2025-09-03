import 'package:flutter/material.dart';
import 'dart:math' as math;

class StarBackground extends StatefulWidget {
  final Widget child;
  
  const StarBackground({
    super.key,
    required this.child,
  });

  @override
  State<StarBackground> createState() => _StarBackgroundState();
}

class _StarBackgroundState extends State<StarBackground>
    with TickerProviderStateMixin {
  late AnimationController _twinkleController;
  late List<Star> stars;

  @override
  void initState() {
    super.initState();
    _generateStars();
    _twinkleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  void _generateStars() {
    stars = List.generate(80, (index) {
      return Star(
        x: math.Random().nextDouble(),
        y: math.Random().nextDouble(),
        size: math.Random().nextDouble() * 2 + 0.5,
        opacity: math.Random().nextDouble() * 0.8 + 0.2,
        twinkleSpeed: math.Random().nextDouble() * 2 + 1,
      );
    });
  }

  @override
  void dispose() {
    _twinkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _twinkleController,
            builder: (context, child) {
              return CustomPaint(
                painter: StarPainter(
                  stars: stars,
                  animation: _twinkleController.value,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
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

      // Draw main star point
      canvas.drawCircle(center, star.size, paint);

      // Draw star rays for larger stars
      if (star.size > 1.5) {
        final rayPaint = Paint()
          ..color = Colors.white.withOpacity(currentOpacity * 0.5)
          ..strokeWidth = 0.5
          ..style = PaintingStyle.stroke;

        // Vertical ray
        canvas.drawLine(
          Offset(center.dx, center.dy - star.size * 3),
          Offset(center.dx, center.dy + star.size * 3),
          rayPaint,
        );

        // Horizontal ray
        canvas.drawLine(
          Offset(center.dx - star.size * 3, center.dy),
          Offset(center.dx + star.size * 3, center.dy),
          rayPaint,
        );

        // Add some sparkle
        if (twinkle > 0.8) {
          final sparklePaint = Paint()
            ..color = Colors.white.withOpacity(currentOpacity * 0.8)
            ..style = PaintingStyle.fill;

          canvas.drawCircle(
            center,
            star.size * 1.5,
            sparklePaint..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}