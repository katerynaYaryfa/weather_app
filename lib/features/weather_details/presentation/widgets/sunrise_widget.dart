import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SunriseWidget extends StatelessWidget {
  const SunriseWidget({
    super.key,
    required this.title,
    required this.time,
    required this.leftIcon,
    required this.rightIcon,
  });

  final String title;
  final String time;
  final String leftIcon;
  final String rightIcon;

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
                leftIcon,
                color: Colors.blue.shade600,
                height: 64,
                width: 64,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800),
                  ),
                  const SizedBox(height: 6),
                  Divider(color: Colors.blue.shade500, thickness: 2),
                  const SizedBox(height: 6),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SvgPicture.asset(
                rightIcon,
                color: Colors.blue.shade600,
                height: 64,
                width: 64,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
