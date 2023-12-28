import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/keys.dart';
import 'package:weather_app/weather_model.dart';

class NetworkService {
  Future<WeatherModel?> getData(double latitude, double longitude) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=${Keys.apiKey}&units=metric'));

    if (response.statusCode == 200) {
      String data = response.body;
      return WeatherModel.fromJson(jsonDecode(data));
    }

    return null;
  }
}
