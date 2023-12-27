import 'package:flutter/material.dart';
import 'package:weather_app/features/current_weather/presentation/pages/current_weather_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CurrentWeatherPage(),
    );
  }
}
