import 'package:flutter/material.dart';
import 'package:weather_app/app_text_styles.dart';

class CurrentWeatherPage extends StatelessWidget {
  const CurrentWeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CityName',
              style: TextStyles.s30CWhite,
            ),
            Text(
              '20°',
              style: TextStyles.s50WBoldCWhite,
            ),
            Text(
              'Weather description',
              style: TextStyles.s16CWhite,
            ),
          ],
        ),
      ),
    );
  }
}
