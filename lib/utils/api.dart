import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

class WeatherApi {
  final String apiKey = 'fe255e29d93a41feb99110642240107';
  final String baseUrl = "http://api.weatherapi.com/v1/current.json";

  Future<ApiResponse> getCurrentWeather(String location) async {
    String apiUrl = "$baseUrl?key=$apiKey&q=$location";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return ApiResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load weather: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load weather: $e");
    }
  }
}
