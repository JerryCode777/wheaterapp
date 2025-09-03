import 'package:flutter/material.dart';

class UVIndexCard extends StatelessWidget {
  final int uvIndex;
  final String level;

  const UVIndexCard({
    super.key,
    required this.uvIndex,
    required this.level,
  });

  Color _getUVColor() {
    if (uvIndex <= 2) return Colors.green;
    if (uvIndex <= 5) return Colors.yellow;
    if (uvIndex <= 7) return Colors.orange;
    if (uvIndex <= 10) return Colors.red;
    return Colors.purple;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$uvIndex',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          level,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.white.withOpacity(0.2),
          ),
          child: FractionallySizedBox(
            widthFactor: (uvIndex / 11).clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: _getUVColor(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}