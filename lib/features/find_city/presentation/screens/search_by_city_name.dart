import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/current_weather/provider/current_weather_provider.dart';

class SearchByCityPage extends StatelessWidget {
  const SearchByCityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CurrentWeatherProvider>();
    final searchCityName =
        context.watch<CurrentWeatherProvider>().searchCityName;

    return Scaffold(
      backgroundColor: provider.mainColor,
      appBar: AppBar(
        backgroundColor: provider.mainColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                provider.updateSearchCityName(value);
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
          TextButton(
            onPressed: () async {
              context.read<CurrentWeatherProvider>().getWeatherByCityName(
                    cityName: searchCityName ?? '',
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
        ],
      ),
    );
  }
}
