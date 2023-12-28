import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/features/current_weather/repositories/current_weather_repository.dart';
import 'package:weather_app/weather_model.dart';

class CurrentWeatherProvider extends ChangeNotifier {
  CurrentWeatherProvider({
    required ICurrentWeatherRepository repository,
  }) : _repository = repository;

  final ICurrentWeatherRepository _repository;

  late double latitude;
  late double longitude;
  late String cityName;
  late String weatherDescription;
  late int? temperature;
  late int? condition;

  void getCurrentLocation() async {
    try {
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      latitude = position.latitude;
      longitude = position.longitude;

      final response = await _repository.getData(latitude, longitude);

      updateUI(response);
    } catch (error) {
      print(error);
    }

    notifyListeners();
  }

  void updateUI(WeatherModel? weatherData) {
    cityName = weatherData?.name.toString() ?? '';
    weatherDescription = weatherData?.weather?[0].description.toString() ?? '';
    temperature = weatherData?.main?.temp?.toInt();
    condition = weatherData?.weather?[0].id;

    notifyListeners();
  }
}
