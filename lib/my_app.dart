import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/current_weather/presentation/pages/current_weather_page.dart';
import 'package:weather_app/features/current_weather/provider/current_weather_provider.dart';
import 'package:weather_app/features/current_weather/repositories/current_weather_repository.dart';
import 'package:weather_app/network_service.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  late final networkHelper = NetworkService();
  late final currentWeatherRepository = CurrentWeatherRepository(networkHelper);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrentWeatherProvider>(
          create: (_) =>
              CurrentWeatherProvider(repository: currentWeatherRepository),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CurrentWeatherPage(),
      ),
    );
  }
}
