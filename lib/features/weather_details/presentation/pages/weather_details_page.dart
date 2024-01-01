import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/app_text_styles.dart';
import 'package:weather_app/common/consts/svg_icons.dart';
import 'package:weather_app/features/current_weather/provider/current_weather_provider.dart';
import 'package:weather_app/features/weather_details/presentation/widgets/sunrise_widget.dart';
import 'package:weather_app/features/weather_details/presentation/widgets/temperature_details_widget.dart';
import 'package:weather_app/features/weather_details/presentation/widgets/weather_details_widget.dart';

class WeatherDetailsPage extends StatelessWidget {
  const WeatherDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CurrentWeatherProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
        backgroundColor: provider.mainColor,
        title: Text(provider.cityName ?? '', style: TextStyles.s22CWhite),
      ),
      backgroundColor: provider.mainColor,
      body: Column(
        children: [
          TemperatureDetailsWidget(
            title: 't° max ↑ ${provider.tempMax}°, min ↓ ${provider.tempMin}°',
            description: '${provider.temperatureDescription}',
            iconText: SvgIcons.temperature,
          ),
          Row(
            children: [
              WeatherDetailsWidget(
                iconText: SvgIcons.humidity,
                title: 'Humidity',
                value: '${provider.humidity}%',
              ),
              WeatherDetailsWidget(
                iconText: SvgIcons.pressure,
                title: 'Pressure',
                value: '${provider.pressure} hPa',
              ),
            ],
          ),
          SunriseWidget(
            title: 'Sunrise, Sunset',
            timeText:
                '${provider.sunriseFormatted}   ${provider.sunsetFormatted}',
            leftIconText: SvgIcons.sunrise,
            rightIconText: SvgIcons.sunset,
          ),
          Row(
            children: [
              WeatherDetailsWidget(
                iconText: SvgIcons.cloud,
                title: 'Cloud coverage',
                value: '${provider.clouds}%',
              ),
              WeatherDetailsWidget(
                iconText: SvgIcons.wind,
                title: 'Wind',
                value: '${provider.windSpeed} M/S',
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
