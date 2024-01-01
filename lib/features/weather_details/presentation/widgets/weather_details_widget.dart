import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherDetailsWidget extends StatelessWidget {
  const WeatherDetailsWidget({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade900.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 14,
                offset: const Offset(0, 0),
              ),
            ],
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.blue.shade100.withOpacity(0.6),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              SvgPicture.asset(
                icon,
                color: Colors.blue.shade600,
                height: 48,
                width: 48,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: TextStyle(fontSize: 16, color: Colors.blue.shade800),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
