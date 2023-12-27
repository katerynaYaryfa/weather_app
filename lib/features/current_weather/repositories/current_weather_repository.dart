import 'package:weather_app/network_service.dart';
import 'package:weather_app/weather_model.dart';

abstract class ICurrentWeatherRepository {
  Future<WeatherModel?> getData(double latitude, double longitude);
}

class CurrentWeatherRepository extends ICurrentWeatherRepository {
  CurrentWeatherRepository(this._networkHelper);

  final NetworkService _networkHelper;

  @override
  Future<WeatherModel?> getData(double latitude, double longitude) async {
    return await _networkHelper.getData(latitude, longitude);
  }
}
