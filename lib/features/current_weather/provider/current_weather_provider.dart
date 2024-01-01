import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_app/common/keys/keys.dart';
import 'package:weather_app/core/extensions/string_extensions.dart';
import 'package:weather_app/core/network/network_exception.dart';
import 'package:weather_app/core/services/geolocator_service.dart';
import 'package:weather_app/features/current_weather/models/weather_model.dart';
import 'package:weather_app/features/current_weather/provider/current_weather_state.dart';
import 'package:weather_app/features/current_weather/repositories/current_weather_repository.dart';

class CurrentWeatherProvider extends ChangeNotifier {
  CurrentWeatherProvider({
    required ICurrentWeatherRepository repository,
    required GeoLocatorService geoLocatorService,
  })  : _repository = repository,
        _geoLocatorService = geoLocatorService;

  final ICurrentWeatherRepository _repository;
  final GeoLocatorService _geoLocatorService;

  CurrentWeatherState state = CurrentWeatherState();

  Future<void> getWeatherByCityName({
    required String cityName,
    required VoidCallback onSuccess,
  }) async {
    try {
      final location = await _repository.getLocation(cityName: cityName);
      final weatherModel = await _repository.getWeather(
        latitude: location?.latitude ?? 0,
        longitude: location?.longitude ?? 0,
      );

      _updateUI(weatherModel);
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

  Future<void> getWeather() async {
    try {
      await _geoLocatorService.requestPermission();
      final position = await _geoLocatorService.getCurrentPosition();

      final weatherModel = await _repository.getWeather(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      _updateUI(weatherModel);
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

  void updateSearchCityName(String value) {
    state = state.copyWith(searchCityName: value);
    notifyListeners();
  }

  // This method convert WeatherModel to CurrentWeatherState
  void _updateUI(WeatherModel? weatherModel) {
    final condition = weatherModel?.weather?[0].id ?? 0;

    state = state.copyWith(
      cityName: weatherModel?.name.toString() ?? '',
      weatherDescription:
          weatherModel?.weather?[0].description.toString().capitalize() ?? '',
      temperature: weatherModel?.main?.temp?.toInt() ?? 0,
      weatherIcon: _getWeatherIcon(condition),
      tempMin: weatherModel?.main?.tempMin?.toInt() ?? 0,
      tempMax: weatherModel?.main?.tempMax?.toInt() ?? 0,
      pressure: weatherModel?.main?.pressure?.toInt() ?? 0,
      humidity: weatherModel?.main?.humidity?.toInt() ?? 0,
      windSpeed: weatherModel?.wind?.speed?.toInt() ?? 0,
      clouds: weatherModel?.clouds?.all?.toInt() ?? 0,
      temperatureDescription: _getTemperatureDescription(
        weatherModel?.main?.temp?.toInt() ?? 0,
      ),
    );
    _convertFromUnixToDateTime(
      sunriseUnix: weatherModel?.sys?.sunrise?.toInt(),
      sunsetUnix: weatherModel?.sys?.sunset?.toInt(),
    );
    _compareDateTime(
      sunriseUnix: weatherModel?.sys?.sunrise?.toInt(),
      sunsetUnix: weatherModel?.sys?.sunset?.toInt(),
    );

    notifyListeners();
  }

  void _convertFromUnixToDateTime({
    int? sunriseUnix,
    int? sunsetUnix,
  }) {
    final DateTime sunrise =
        DateTime.fromMillisecondsSinceEpoch((sunriseUnix ?? 0) * 1000);
    final DateTime sunset =
        DateTime.fromMillisecondsSinceEpoch((sunsetUnix ?? 0) * 1000);

    state = state.copyWith(
      sunriseFormatted: '${sunrise.hour}:${sunrise.minute}',
      sunsetFormatted: '${sunset.hour}:${sunset.minute}',
    );
    notifyListeners();
  }

  void _compareDateTime({
    int? sunriseUnix,
    int? sunsetUnix,
  }) {
    final sunrise =
        DateTime.fromMillisecondsSinceEpoch((sunriseUnix ?? 0) * 1000);
    final sunset =
        DateTime.fromMillisecondsSinceEpoch((sunsetUnix ?? 0) * 1000);
    final now = DateTime.now();
    final isAfterSunrise = now.isAfter(sunrise);
    final isBeforeSunset = now.isBefore(sunset);

    if (isAfterSunrise && isBeforeSunset) {
      state = state.copyWith(
        mainImage: _getMainImage(1),
        backgroundImage: _getBackgroundImage(1),
      );
    } else {
      state = state.copyWith(
        mainImage: _getMainImage(2),
        backgroundImage: _getBackgroundImage(2),
      );
    }
  }

  String _getBackgroundImage(int number) {
    switch (number) {
      case == 1:
        return 'images/day_background.jpg';
      case == 2:
        return 'images/night_background.jpg';
      default:
        return 'images/day_background.jpg';
    }
  }

  String _getMainImage(int number) {
    switch (number) {
      case == 1:
        return 'images/day_house.png';
      case == 2:
        return 'images/night_house.png';
      default:
        return 'images/day_house.png';
    }
  }

  String _getWeatherIcon(int condition) {
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

  String _getTemperatureDescription(int temperature) {
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
