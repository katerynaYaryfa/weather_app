import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weather_app/core/extensions/string_extensions.dart';
import 'package:weather_app/core/network/network_exception.dart';
import 'package:weather_app/features/current_weather/repositories/current_weather_repository.dart';
import 'package:weather_app/keys.dart';
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
  String? temperatureDescription;

  String? searchCityName;

  void updateSearchCityName(String value) {
    searchCityName = value;
    notifyListeners();
  }

  void getWeatherByCityName({
    required String cityName,
    required VoidCallback onSuccess,
  }) async {
    try {
      final response = await _repository.getLocation(cityName);
      latitude = response?.lat;
      longitude = response?.lon;

      final weatherData =
          await _repository.getData(latitude ?? 0, longitude ?? 0);

      updateUI(weatherData);
      onSuccess();
    } catch (error) {
      if (error is ClientException) {
        Keys.scaffoldMessengerKey.currentState!.showSnackBar(
          const SnackBar(
            content: Text('No Internet Connection'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (error is NetworkException) {
        Keys.scaffoldMessengerKey.currentState!.showSnackBar(
          SnackBar(
            content: Text(error.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    notifyListeners();
  }

  void getCurrentLocation() async {
    try {
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );

      latitude = position.latitude;
      longitude = position.longitude;

      final response = await _repository.getData(latitude ?? 0, longitude ?? 0);

      updateUI(response);
    } catch (error) {
      if (error is ClientException) {
        Keys.scaffoldMessengerKey.currentState!.showSnackBar(
          const SnackBar(
            content: Text('No Internet Connection'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (error is NetworkException) {
        Keys.scaffoldMessengerKey.currentState!.showSnackBar(
          SnackBar(
            content: Text(error.message),
            backgroundColor: Colors.red,
          ),
        );
      }
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

    compareDateTime();
    temperatureDescription = getTemperatureDescription(temperature ?? 0);
    notifyListeners();
  }

  void convertFromUnixToDateTime() {
    final DateTime sunrise =
        DateTime.fromMillisecondsSinceEpoch(sunriseUnix! * 1000);
    final DateTime sunset =
        DateTime.fromMillisecondsSinceEpoch(sunsetUnix! * 1000);
    sunriseFormatted = '${sunrise.hour}:${sunrise.minute}';
    sunsetFormatted = '${sunset.hour}:${sunset.minute}';
  }

  void compareDateTime() {
    final DateTime sunrise =
        DateTime.fromMillisecondsSinceEpoch(sunriseUnix! * 1000);
    final DateTime sunset =
        DateTime.fromMillisecondsSinceEpoch(sunsetUnix! * 1000);
    final DateTime now = DateTime.now();
    final isAfterSunrise = now.isAfter(sunrise);
    final isBeforeSunset = now.isBefore(sunset);

    if (isAfterSunrise && isBeforeSunset) {
      mainIcon = getMainIcon(1);
      mainColor = getMainColor(1);
    } else {
      mainIcon = getMainIcon(2);
      mainColor = getMainColor(2);
    }
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

  String getTemperatureDescription(int temperature) {
    switch (temperature) {
      case < 0:
        return "It's cold outside. Don’t forget your gloves.";
      case < 10:
        return "It's quite cold. Wear puffer jacket.";
      case < 20:
        return "It's chilly. A light jacket should do.";
      case < 30:
        return "It's warm. Short sleeves are perfect.";
      case > 30:
        return "It's very hot! Stay cool and hydrated.";
      default:
        return '';
    }
  }
}
