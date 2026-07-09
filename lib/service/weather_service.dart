import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apikey = "ed5a037652f50c78bd4a08a81bec4db3";

  Future<Map<String,dynamic>> getweather(String city) async {
    final url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=ed5a037652f50c78bd4a08a81bec4db3&units=metric&lang=kr");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("날씨 정보를 불러오지 못했습니다.");
    }
  }

}