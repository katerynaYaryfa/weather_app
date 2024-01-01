import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/common/styles/app_text_styles.dart';
import 'package:weather_app/common/widgets/background_image_container.dart';
import 'package:weather_app/common/widgets/custom_animated_swithcer.dart';
import 'package:weather_app/features/current_weather/presentation/widgets/current_weather_page_skeleton.dart';
import 'package:weather_app/features/current_weather/provider/current_weather_provider.dart';
import 'package:weather_app/features/search_by_city/presentation/pages/search_by_city_page.dart';
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
    context.read<CurrentWeatherProvider>().getWeather();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CurrentWeatherProvider>().state;

    final child = state.cityName.isEmpty
        ? const CurrentWeatherPageSkeleton()
        : BackgroundImageContainer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const _HeaderIcons(),
                const SizedBox(height: 45),
                Center(
                    child: Column(
                  children: [
                    Text(
                      state.cityName,
                      style: TextStyles.s30CWhite,
                    ),
                    Text(
                      '${state.temperature}°',
                      style: TextStyles.s50WBoldCWhite,
                    ),
                    Text(
                      '${state.weatherDescription} ${state.weatherIcon}',
                      style: TextStyles.s16CWhite,
                    ),
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Image.asset(state.mainImage),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WeatherDetailsPage(),
                      ),
                    );
                  },
                  child: Text(
                    'See more details',
                    style: TextStyle(fontSize: 18, color: Colors.blue.shade50),
                  ),
                ),
              ],
            ),
          );

    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: Center(
        child: CustomAnimatedSwitcher(
          child: child,
        ),
      ),
    );
  }
}

class _HeaderIcons extends StatelessWidget {
  const _HeaderIcons();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 50,
        left: 16,
        right: 16,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              context.read<CurrentWeatherProvider>().getWeather();
            },
            icon: const Icon(
              Icons.location_on,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchByCityPage(),
                  ));
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
