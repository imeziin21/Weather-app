import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  final String apikey = dotenv.env['OPENWEATHER_API_KEY']!;

  Future<Map<String,dynamic>> getweather(String city) async {
    final url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=$dotenv.env['OPENWEATHER_API_KEY']!&units=metric&lang=kr");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("날씨 정보를 불러오지 못했습니다.");
    }
  }

}