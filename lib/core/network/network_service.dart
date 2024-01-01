import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/core/network/network_exception.dart';
import 'package:weather_app/keys.dart';
import 'package:weather_app/location_model.dart';
import 'package:weather_app/weather_model.dart';

class NetworkService {
  Future<WeatherModel?> getData(double latitude, double longitude) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=${Keys.apiKey}&units=metric'));

    if (response.statusCode == 200) {
      String data = response.body;
      return WeatherModel.fromJson(jsonDecode(data));
    } else if (response.statusCode >= 400) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      throw NetworkException(json['message']);
    }

    return null;
  }

  Future<LocationModel?> getLocation(String cityName) async {
    http.Response response = await http.get(Uri.parse(
        'http://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=5&appid=${Keys.apiKey}'));

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
