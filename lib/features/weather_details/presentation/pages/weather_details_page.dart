import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/common/consts/svg_icons.dart';
import 'package:weather_app/common/widgets/back_button.dart';
import 'package:weather_app/common/widgets/background_image_container.dart';
import 'package:weather_app/features/current_weather/provider/current_weather_provider.dart';
import 'package:weather_app/features/weather_details/presentation/widgets/sunrise_widget.dart';
import 'package:weather_app/features/weather_details/presentation/widgets/temperature_details_widget.dart';
import 'package:weather_app/features/weather_details/presentation/widgets/weather_details_widget.dart';

class WeatherDetailsPage extends StatelessWidget {
  const WeatherDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CurrentWeatherProvider>().state;

    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: BackgroundImageContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BackButtonWidget(),
            TemperatureDetailsWidget(
              title: 't° max ↑ ${state.tempMax}°, min ↓ ${state.tempMin}°',
              description: state.temperatureDescription,
              icon: SvgIcons.temperature,
            ),
            Row(
              children: [
                WeatherDetailsWidget(
                  icon: SvgIcons.humidity,
                  title: 'Humidity',
                  value: '${state.humidity}%',
                ),
                WeatherDetailsWidget(
                  icon: SvgIcons.pressure,
                  title: 'Pressure',
                  value: '${state.pressure} hPa',
                ),
              ],
            ),
            SunriseWidget(
              title: 'Sunrise, Sunset',
              time: '${state.sunriseFormatted}   ${state.sunsetFormatted}',
              leftIcon: SvgIcons.sunrise,
              rightIcon: SvgIcons.sunset,
            ),
            Row(
              children: [
                WeatherDetailsWidget(
                  icon: SvgIcons.cloud,
                  title: 'Cloud coverage',
                  value: '${state.clouds}%',
                ),
                WeatherDetailsWidget(
                  icon: SvgIcons.wind,
                  title: 'Wind',
                  value: '${state.windSpeed} M/S',
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
