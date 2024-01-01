import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/app_text_styles.dart';
import 'package:weather_app/common/widgets/custom_animated_swithcer.dart';
import 'package:weather_app/features/current_weather/presentation/widgets/current_weather_page_skeleton.dart';
import 'package:weather_app/features/current_weather/provider/current_weather_provider.dart';
import 'package:weather_app/features/find_city/presentation/screens/search_by_city_name.dart';
import 'package:weather_app/features/weather_details/presentation/pages/weather_details_page.dart';

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
    final provider = context.watch<CurrentWeatherProvider>();

    final child = provider.cityName == null
        ? const CurrentWeatherPageSkeleton()
        : Column(
            children: [
              const SizedBox(height: 100),
              Text(
                provider.cityName ?? '',
                style: TextStyles.s30CWhite,
              ),
              Text(
                '${provider.temperature}°',
                style: TextStyles.s50WBoldCWhite,
              ),
              Text(
                '${provider.weatherDescription} ${provider.weatherIcon}',
                style: TextStyles.s16CWhite,
              ),
              Container(
                child: Text('${provider.mainIcon}',
                    style: const TextStyle(fontSize: 200)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WeatherDetailsPage(),
                      ));
                },
                child: Text(
                  'See more details',
                  style: TextStyle(fontSize: 18, color: Colors.blue.shade50),
                ),
              ),
            ],
          );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<CurrentWeatherProvider>().getCurrentLocation();
          },
          icon: const Icon(Icons.location_on),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchByCityPage(),
                  ));
            },
            icon: const Icon(Icons.search),
          ),
        ],
        backgroundColor: provider.mainColor ?? Colors.blue.shade300,
        elevation: 0,
      ),
      backgroundColor: provider.mainColor ?? Colors.blue.shade300,
      body: Center(
        child: CustomAnimatedSwitcher(
          child: child,
        ),
      ),
    );
  }
}
