import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tracking_cuaca/models/weather_model.dart';

class WeatherService {
  static const String apiKey = 'Drop Your Api';
  Future<Weathers> getApiWeather(String place) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$place&appid=$apiKey&units=metric'));
      final data = json.decode(response.body);
      print(data);
      return Weathers.fromJson(data);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
