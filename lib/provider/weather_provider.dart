import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_models.dart';
import 'package:weather_app/service/weather_service.dart';


class weatherprovider extends ChangeNotifier {
  final weatherservice service = weatherservice();
  weathermodel? weather;
  bool isLoading = false;

  Future<void> catchweather(String city) async {
    try {
      isLoading = true;
      notifyListeners();
      weather = await service.getweather(city);
    }
    catch(e){
      print(e);
    }
    finally {
      isLoading = false;
      notifyListeners();
    }
  }
}