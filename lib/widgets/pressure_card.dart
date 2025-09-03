import 'package:flutter/material.dart';
import 'dart:ui';

class PressureCard extends StatelessWidget {
  final double pressure;
  final String trend;

  const PressureCard({
    super.key,
    required this.pressure,
    required this.trend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.25),
            Colors.white.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.compress,
                    color: Colors.green.shade300,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'PRESIÓN ATMOSFÉRICA',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    pressure.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'hPa',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    trend == 'up' ? Icons.trending_up : 
                    trend == 'down' ? Icons.trending_down : Icons.trending_flat,
                    color: trend == 'up' ? Colors.green.shade300 :
                           trend == 'down' ? Colors.red.shade300 : Colors.grey.shade300,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    trend == 'up' ? 'Subiendo' :
                    trend == 'down' ? 'Bajando' : 'Estable',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}