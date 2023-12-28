import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/app_text_styles.dart';
import 'package:weather_app/features/current_weather/provider/current_weather_provider.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({super.key});

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
  void initState() {
    super.initState();
    context.read<CurrentWeatherProvider>().getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentWeatherProvider>(builder: (context, provider, _) {
      return Scaffold(
        backgroundColor: Colors.blue.shade300,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                provider.cityName,
                style: TextStyles.s30CWhite,
              ),
              Text(
                '${provider.temperature}°',
                style: TextStyles.s50WBoldCWhite,
              ),
              Text(
                provider.weatherDescription,
                style: TextStyles.s16CWhite,
              ),
            ],
          ),
        ),
      );
    });
  }
}
