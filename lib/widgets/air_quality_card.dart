import 'package:flutter/material.dart';

class AirQualityCard extends StatelessWidget {
  final int aqi;
  final String level;
  final String healthRisk;

  const AirQualityCard({
    super.key,
    required this.aqi,
    required this.level,
    required this.healthRisk,
  });

  Color _getAQIColor() {
    if (aqi <= 50) return Colors.green;
    if (aqi <= 100) return Colors.yellow;
    if (aqi <= 150) return Colors.orange;
    if (aqi <= 200) return Colors.red;
    return Colors.purple;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '$aqi',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              level,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.white.withOpacity(0.2),
          ),
          child: FractionallySizedBox(
            widthFactor: (aqi / 300).clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: _getAQIColor(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          healthRisk,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}