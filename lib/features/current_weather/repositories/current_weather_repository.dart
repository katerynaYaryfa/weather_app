import 'package:weather_app/core/network/network_service.dart';
import 'package:weather_app/features/current_weather/models/location_model.dart';
import 'package:weather_app/features/current_weather/models/weather_model.dart';

abstract class ICurrentWeatherRepository {
  Future<WeatherModel?> getWeather({
    required double latitude,
    required double longitude,
  });

  Future<LocationModel?> getLocation({
    required String cityName,
  });
}

class CurrentWeatherRepository extends ICurrentWeatherRepository {
  CurrentWeatherRepository(this._networkHelper);

  final NetworkService _networkHelper;

  @override
  Future<WeatherModel?> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    return await _networkHelper.getWeather(
      latitude: latitude,
      longitude: longitude,
    );
  }

  @override
  Future<LocationModel?> getLocation({
    required String cityName,
  }) async {
    return await _networkHelper.getLocation(cityName: cityName);
  }
}
