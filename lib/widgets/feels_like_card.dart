import 'package:flutter/material.dart';
import 'dart:ui';

class FeelsLikeCard extends StatelessWidget {
  final int feelsLike;
  final int actualTemp;

  const FeelsLikeCard({
    super.key,
    required this.feelsLike,
    required this.actualTemp,
  });

  @override
  Widget build(BuildContext context) {
    final difference = feelsLike - actualTemp;
    
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
                    Icons.thermostat,
                    color: Colors.orange.shade300,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'SENSACIÓN TÉRMICA',
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
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$feelsLike',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: '°C',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                difference > 0 
                    ? 'Se siente ${difference.abs()}° más caliente'
                    : difference < 0 
                        ? 'Se siente ${difference.abs()}° más frío'
                        : 'Igual a la temperatura real',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}