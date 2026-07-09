import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/screen/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (BuildContext) => weatherprovider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: homescreen(),
      ),
    )
  );
}