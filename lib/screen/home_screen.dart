import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/service/weather_service.dart';
import '../provider/weather_provider.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  int currentindex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<weatherprovider>().catchweather("seoul");
    });
  }

  String weatherdescription(String description) {
    switch (description) {
      case '맑음':
        return '맑음';

      case '약간의 구름이 낀 하늘':
      case '드문드문 구름이 낀 하늘':
      case '조각 구름':
        return '구름 조금';

      case '튼구름':
      case '흐린 구름':
        return '흐림';

      case '실 비':
      case '가벼운 비':
      case '비':
      case '강한 비':
        return '비';

      case '눈':
        return '눈';

      case '안개':
        return '안개';

      default:
        return description;
    }
  }

  String weatherclothes(String description) {
    switch (description) {
      case '맑음':
        return '사놓았던 예쁜 옷들을 입을 날이에요!';

      case '약간의 구름이 낀 하늘':
      case '드문드문 구름이 낀 하늘':
      case '조각 구름':
        return '오늘은 맨투맨이나 후드티를 추천해요.';

      case '튼구름':
      case '흐린 구름':
        return '오늘은 긴팔 티와 얇은 가디건을 추천해요.';

      case '실 비':
      case '가벼운 비':
        return '우산을 준비하세요.';

      case '비':
      case '강한 비':
        return '우산과 방수 신발을 준비하세요.';

      case '눈':
        return '오늘은 롱패딩과 목도리를 추천해요.';

      case '안개':
        return '오늘은 긴팔 티와 얇은 겉옷을 추천해요.';

      default:
        return '오늘 날씨를 확인하고 옷을 준비하세요.';
    }
  }

  @override
  Widget build(BuildContext context) {
    weatherprovider provider = Provider.of<weatherprovider>(context);
    String? city = provider.weather?.city;
    double? temp = provider.weather?.temp;
    String? description = provider.weather?.description;
    int? humidity = provider.weather?.humidity;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff73d0ff),
        leading: IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.black,
                duration: Duration(seconds: 1),
                behavior: .floating,
                shape: RoundedRectangleBorder(borderRadius: .circular(25)),
                content: Text('아직 준비중인 기능이에요 ㅜ.ㅜ 곧 만나요!', textAlign: .center),
              ),
            );
          },
          icon: Icon(Icons.menu, color: Colors.black),
        ),
        title: Row(
          children: [
            Text(city ?? "도시를 불러오는중 ...", style: TextStyle(fontSize: 17)),
            Icon(Icons.location_on, color: Colors.black),
          ],
        ),
      ),
      body: Container(
        width: .infinity,
        height: .infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: .topCenter,
            end: .bottomCenter,
            colors: [Color(0xff73d0ff),Color(0xffaae3ff),Color(0xffbaebff), Colors.white],
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 200,
              width: .infinity,
              child: Column(
                crossAxisAlignment: .center,
                children: [
                  SizedBox(height: 40),
                  Image.asset('assets/image/logo.png', width: 60, height: 60),
                  Text(
                    weatherdescription(description!) ?? "날씨를 불러오는 중..",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: .bold,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    temp.toString() + "°C" ?? "날씨를 불러오는 중..",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: .bold,
                      fontSize: 50,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: Colors.black, thickness: 1),
            ),
            Container(
              width: .infinity,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text('💧 습도', style: TextStyle(fontSize: 15)),
                  SizedBox(height: 5),
                  Text(
                    humidity.toString() + '%',
                    style: TextStyle(color: Colors.black, fontSize: 25,fontWeight: .bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: Colors.black, thickness: 1),
            ),
            Container(
              width: .infinity,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text('👗 추천', style: TextStyle(fontSize: 15)),
                  SizedBox(height: 5),
                  Text(
                    weatherclothes(description),
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: Colors.black, thickness: 1),
            ),
            Container(
              width: .infinity,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text('💬 한마디', style: TextStyle(fontSize: 15)),
                  SizedBox(height: 5),
                  Text(
                    '오늘도 좋은 하루 보내세요☀️',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Text(
          '현재 서울 날씨만 이용가능합니다.',
          style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 13),
          textAlign: .center,
        ),
      ),
    );
  }
}
