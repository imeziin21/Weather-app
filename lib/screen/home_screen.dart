import 'package:flutter/material.dart';
import 'package:weather_app/screen/like_screen.dart';
import 'package:weather_app/screen/search_screen.dart';
import 'package:weather_app/screen/setting_screen.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/service/weather_service.dart';
import '../provider/weather_provider.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

final List<Widget> pages = [
  mainscreen(),
  searchscreen(),
  likescreen(),
  settingscreen()
];


class _homescreenState extends State<homescreen> {
  int currentindex = 0;

  @override
  @override
  void initState() {
    super.initState();
    Future.microtask((){
      context.read<weatherprovider>().catchweather("seoul");
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentindex,
        children: pages,
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: .fixed,
          onTap: (index){
              setState(() {
                currentindex = index;
              });
            },
          selectedLabelStyle: TextStyle(fontSize: 11,color: Colors.blue,fontWeight: .bold),
          unselectedLabelStyle: TextStyle(fontSize: 11,color: Colors.grey,fontWeight: .bold),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
            iconSize: 30,
          currentIndex: currentindex,
            items: [
              BottomNavigationBarItem(icon: currentindex==0 ? Icon(Icons.home) : Icon(Icons.home_outlined),label: '홈'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
              BottomNavigationBarItem(icon: currentindex==2 ? Icon(Icons.favorite) : Icon(Icons.favorite_border),label: '즐겨찾기'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: '설정'),
            ]
        ),
      ),
    );
  }
}

class mainscreen extends StatefulWidget {
  const mainscreen({super.key});

  @override
  State<mainscreen> createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  @override
  Widget build(BuildContext context) {
    weatherprovider provider = Provider.of<weatherprovider>(context);
    String? city = provider.weather?.city;
    double? temp = provider.weather?.temp;
    String? description = provider.weather?.description;

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
          return '비';

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

    String weathercloths(String description) {
      switch (description) {
        case '맑음':
          return '사놓았던 예쁜 옷들을 입을 날이에요!';

        case '약간의 구름이 낀 하늘':
        case '드문드문 구름이 낀 하늘':
        case '조각 구름':
          return '맨투맨이나 후드티를 추천해요.';

        case '튼구름':
        case '흐린 구름':
          return '긴팔 티, 얇은 가디건 추천하고 얇은 겉옷을 챙겨요';

        case '실 비':
        case '가벼운 비':
          return '우산을 준비하세요.';

        case '비':
        case '강한 비':
          return '우산과 장화를 준비하세요.';

        case '눈':
          return '롱패딩과 목도리를 추천해요.';

        case '안개':
          return '긴팔 티, 얇은 가디건을 추천해요.';

        default:
          return description;
      }
    }


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu,color: Colors.black,)),
        title: Row(
          children: [
            Text(
                city ?? "도시를 불러오는중 ...",
              style: TextStyle(
                fontSize: 17
              ),
            ),
            Icon(Icons.location_on,color: Colors.black,)
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: .infinity,
            // color: Colors.lightBlueAccent.withOpacity(0.2),
            child: Column(
              crossAxisAlignment: .center,
              children: [
                SizedBox(height: 40,),
                Text(
                  weatherdescription(description!) ?? "날씨를 불러오는 중..",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: .bold,
                      fontSize: 17
                  ),
                ),
                Text(
                    temp.toString()+"°C" ?? "날씨를 불러오는 중..",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: .bold,
                    fontSize: 50
                  ),
                )
              ],
            )
          ),
          Container(
            width: .infinity,
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: .circular(10),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0.5),
                  spreadRadius: 1,
                  blurRadius: 0.5,
                  color: Colors.black.withOpacity(0.2)
                )
              ]
            ),
            child: Text(
                '오늘의 날씨는 ${weatherdescription(description)}입니다.\n오늘은 ${weathercloths(description)}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: .w500
              ),
            ),
          ),
        ],
      ),
    );
  }
}

