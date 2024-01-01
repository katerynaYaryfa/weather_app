import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/common/keys/keys.dart';
import 'package:weather_app/common/styles/skeleton_theme_provider.dart';
import 'package:weather_app/core/network/network_service.dart';
import 'package:weather_app/core/services/geolocator_service.dart';
import 'package:weather_app/features/current_weather/presentation/pages/current_weather_page.dart';
import 'package:weather_app/features/current_weather/provider/current_weather_provider.dart';
import 'package:weather_app/features/current_weather/repositories/current_weather_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrentWeatherProvider>(
          create: (_) => CurrentWeatherProvider(
            repository: CurrentWeatherRepository(NetworkService()),
            geoLocatorService: GeoLocatorService(),
          ),
        ),
      ],
      child: SkeletonThemeProvider(
        child: MaterialApp(
          scaffoldMessengerKey: Keys.scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          home: const CurrentWeatherPage(),
        ),
      ),
    );
  }
}
