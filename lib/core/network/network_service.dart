import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/common/keys/keys.dart';
import 'package:weather_app/core/network/network_exception.dart';
import 'package:weather_app/features/current_weather/models/location_model.dart';
import 'package:weather_app/features/current_weather/models/weather_model.dart';

const _baseUrl = 'https://api.openweathermap.org/';

class NetworkService {
  // This function is used to get the current weather of the user's location
  Future<WeatherModel?> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    http.Response response = await http.get(
      Uri.parse(
          '${_baseUrl}data/2.5/weather?lat=$latitude&lon=$longitude&appid=${Keys.apiKey}&units=metric'),
    );

    if (response.statusCode == 200) {
      String data = response.body;
      return WeatherModel.fromJson(jsonDecode(data));
    } else if (response.statusCode >= 400) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      throw NetworkException(json['message']);
    }

    return null;
  }

  // This function is used to get the city location
  Future<LocationModel?> getLocation({required String cityName}) async {
    http.Response response = await http.get(Uri.parse(
        '${_baseUrl}geo/1.0/direct?q=$cityName&limit=5&appid=${Keys.apiKey}'));

    if (response.statusCode == 200) {
      String data = response.body;

      if (jsonDecode(data).length == 0) {
        throw NetworkException('No city found');
      }

      return LocationModel.fromJson(jsonDecode(data)[0]);
    } else if (response.statusCode >= 400) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      throw NetworkException(json['message']);
    }

    return null;
  }
}
