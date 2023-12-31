import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SunriseWidget extends StatelessWidget {
  const SunriseWidget({
    super.key,
    required this.title,
    required this.timeText,
    required this.leftIconText,
    required this.rightIconText,
  });

  final String title;
  final String timeText;
  final String leftIconText;
  final String rightIconText;

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
          color: Colors.blue.shade100,
        ),
        child: Row(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SvgPicture.asset(
                leftIconText,
                color: Colors.blue.shade400,
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
                  Divider(color: Colors.blue.shade400, thickness: 2),
                  const SizedBox(height: 6),
                  Text(
                    timeText,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SvgPicture.asset(
                rightIconText,
                color: Colors.blue.shade400,
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
