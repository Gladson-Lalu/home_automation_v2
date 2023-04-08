import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../model/weather_model.dart';

class WeatherRepository {
  static final String _apiKey = dotenv.env["OPENWEATHERMAP_API_KEY"]!;
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Weather> getWeather(
      {required String latitude, required String longitude}) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/weather?lat=$latitude&lon=$longitude&appid=$_apiKey&units=metric'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error getting weather');
    }
  }
}
