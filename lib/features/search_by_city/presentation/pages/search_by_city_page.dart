import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/common/widgets/back_button.dart';
import 'package:weather_app/common/widgets/background_image_container.dart';
import 'package:weather_app/features/current_weather/provider/current_weather_provider.dart';

class SearchByCityPage extends StatelessWidget {
  const SearchByCityPage({super.key});

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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  context
                      .read<CurrentWeatherProvider>()
                      .updateSearchCityName(value);
                },
                decoration: InputDecoration(
                  hintText: 'Enter city name',
                  hintStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () async {
                  context.read<CurrentWeatherProvider>().getWeatherByCityName(
                        cityName: state.searchCityName,
                        onSuccess: () {
                          Navigator.pop(context);
                        },
                      );
                },
                child: Text(
                  'Get weather',
                  style: TextStyle(fontSize: 18, color: Colors.blue.shade50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
