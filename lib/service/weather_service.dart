import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../model/weather_models.dart';

class weatherservice {
  final String apikey = dotenv.env['OPENWEATHER_API_KEY']!;

  Future<weathermodel> getweather(String city) async {
    final url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apikey&units=metric&lang=kr");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return weathermodel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("날씨 정보를 불러오지 못했습니다.");
    }
  }

}