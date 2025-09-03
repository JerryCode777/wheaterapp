import 'package:flutter/material.dart';
import 'dart:math' as math;

class SunTimesCard extends StatelessWidget {
  final String sunrise;
  final String sunset;

  const SunTimesCard({
    super.key,
    required this.sunrise,
    required this.sunset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sunrise',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  sunrise,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Sunset',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  sunset,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 60,
          child: CustomPaint(
            size: const Size(double.infinity, 60),
            painter: SunPathPainter(),
          ),
        ),
      ],
    );
  }
}

class SunPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height);
    
    for (double x = 0; x <= size.width; x += 1) {
      final y = size.height - (math.sin((x / size.width) * math.pi) * size.height * 0.8);
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);

    final sunPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    final currentTime = DateTime.now().hour;
    final sunProgress = (currentTime - 6) / 12;
    final clampedProgress = sunProgress.clamp(0.0, 1.0);
    
    final sunX = clampedProgress * size.width;
    final sunY = size.height - (math.sin(clampedProgress * math.pi) * size.height * 0.8);
    
    canvas.drawCircle(Offset(sunX, sunY), 4, sunPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}