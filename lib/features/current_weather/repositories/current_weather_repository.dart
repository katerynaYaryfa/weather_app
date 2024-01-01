import 'package:weather_app/core/network/network_service.dart';
import 'package:weather_app/location_model.dart';
import 'package:weather_app/weather_model.dart';

abstract class ICurrentWeatherRepository {
  Future<WeatherModel?> getData(double latitude, double longitude);

  Future<LocationModel?> getLocation(String cityName);
}

class CurrentWeatherRepository extends ICurrentWeatherRepository {
  CurrentWeatherRepository(this._networkHelper);

  final NetworkService _networkHelper;

  @override
  Future<WeatherModel?> getData(double latitude, double longitude) async {
    return await _networkHelper.getData(latitude, longitude);
  }

  @override
  Future<LocationModel?> getLocation(String cityName) async {
    return await _networkHelper.getLocation(cityName);
  }
}
