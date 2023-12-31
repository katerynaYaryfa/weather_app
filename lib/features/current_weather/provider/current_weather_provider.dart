import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/extensions/string_extensions.dart';
import 'package:weather_app/features/current_weather/repositories/current_weather_repository.dart';
import 'package:weather_app/weather_model.dart';

class CurrentWeatherProvider extends ChangeNotifier {
  CurrentWeatherProvider({
    required ICurrentWeatherRepository repository,
  }) : _repository = repository {}

  final ICurrentWeatherRepository _repository;

  double? latitude;
  double? longitude;
  String? cityName;
  String? weatherDescription;
  int? temperature;
  int? tempMin;
  int? tempMax;
  int? pressure;
  int? humidity;
  int? windSpeed;
  int? clouds;
  int? sunriseUnix;
  int? sunsetUnix;
  String? sunriseFormatted;
  String? sunsetFormatted;
  String? weatherIcon;
  String? mainIcon;
  Color? mainColor;
  bool shimmer = true;

  void getCurrentLocation() async {
    try {
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      latitude = position.latitude;
      longitude = position.longitude;

      final response = await _repository.getData(latitude ?? 0, longitude ?? 0);

      updateUI(response);
    } catch (error) {
      print(error);
    }

    notifyListeners();
  }

  void updateUI(WeatherModel? weatherData) {
    cityName = weatherData?.name.toString() ?? '';
    weatherDescription =
        weatherData?.weather?[0].description.toString().capitalize() ?? '';
    temperature = weatherData?.main?.temp?.toInt();
    final condition = weatherData?.weather?[0].id ?? 0;
    tempMin = weatherData?.main?.tempMin?.toInt();
    tempMax = weatherData?.main?.tempMax?.toInt();
    pressure = weatherData?.main?.pressure?.toInt();
    humidity = weatherData?.main?.humidity?.toInt();
    windSpeed = weatherData?.wind?.speed?.toInt();
    clouds = weatherData?.clouds?.all?.toInt();
    sunriseUnix = weatherData?.sys?.sunrise?.toInt();
    sunsetUnix = weatherData?.sys?.sunset?.toInt();
    convertFromUnixToDateTime();

    weatherIcon = getWeatherIcon(condition);
    mainIcon = getMainIcon(1);
    mainColor = getMainColor(1);
    shimmer = false;
    print('weatherIcon: $weatherIcon');

    print(
        'tempMin: $tempMin, tempMax: $tempMax, pressure: $pressure, humidity: $humidity, windSpeed: $windSpeed, clouds: $clouds, sunrise: $sunriseUnix, sunset: $sunsetUnix');
    notifyListeners();
  }

  void convertFromUnixToDateTime() {
    final DateTime sunrise =
        DateTime.fromMillisecondsSinceEpoch(sunriseUnix! * 1000);
    final DateTime sunset =
        DateTime.fromMillisecondsSinceEpoch(sunsetUnix! * 1000);
    sunriseFormatted = '${sunrise.hour}:${sunrise.minute}';
    sunsetFormatted = '${sunset.hour}:${sunset.minute}';
    print('sunrise: $sunrise, sunset: $sunset');
    print(
        'sunriseFormatted: $sunriseFormatted, sunsetFormatted: $sunsetFormatted');
  }

  Color getMainColor(int number) {
    switch (number) {
      case == 1:
        return Colors.blue.shade300;
      case == 2:
        return Colors.indigo;

      default:
        return Colors.blue.shade300;
    }
  }

  String getMainIcon(int number) {
    switch (number) {
      case == 1:
        return '☀️';
      case == 2:
        return '🌙';

      default:
        return '';
    }
  }

  String getWeatherIcon(int condition) {
    switch (condition) {
      case < 300:
        return '🌩';
      case < 400:
        return '🌧';
      case < 600:
        return '🌧';
      case < 700:
        return '🌨️';
      case < 800:
        return '🌫';
      case == 800:
        return '☀️';
      case <= 804:
        return '☁️';
      default:
        return '';
    }
  }
}
