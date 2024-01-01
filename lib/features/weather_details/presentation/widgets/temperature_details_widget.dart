import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TemperatureDetailsWidget extends StatelessWidget {
  const TemperatureDetailsWidget({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(12),
        height: 140,
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
        child: Row(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SvgPicture.asset(
                icon,
                color: Colors.blue.shade600,
                height: 64,
                width: 64,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
