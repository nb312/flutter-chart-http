///
/// Created by NieBin on 18-12-12
/// Github: https://github.com/nb312
/// Email: niebin312@gmail.com
///
import 'package:flutter/material.dart';
import 'package:flutter_weather/data/CityItem.dart';
import 'package:flutter_weather/util/ResourceUtil.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_weather/const/size_const.dart';
import 'package:flutter_weather/data/event/base_event.dart';
import 'package:flutter_weather/http/HttpUtil.dart';
import 'package:flutter_weather/data/CurrentWeatherItem.dart';
import 'package:flutter_weather/view/MLineChart.dart';
import 'package:flutter_weather/view/char_point.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter_weather/const/color_const.dart';
import 'package:flutter_weather/view/MBarChart.dart';
import 'package:flutter_weather/view/MPieChart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_weather/util/share_prefer.dart';

class TodayPage extends StatefulWidget {
  @override
  _TodayState createState() => _TodayState();
}

// {
//    "id": 1796236,
//    "name": "Shanghai",
//    "country": "CN",
//    "coord": {
//      "lon": 121.458061,
//      "lat": 31.222219
//    }
//  },
class _TodayState extends State<TodayPage> {
  CityItem cityItem;
  CurrentWeatherItem weatherItem;

  Future<Null> updateCity() async {
    var sp = await SharedPreferences.getInstance();
    var list = sp.getStringList(LOCAL_CITY);
    if (list != null && list.isNotEmpty) {
      cityItem =
          CityItem(id: int.parse(list[0]), name: list[1], country: list[2]);
    } else {
      await sp.setStringList(
        LOCAL_CITY,
        ["1796236", "Shanghai", "CN"],
      );
      cityItem = CityItem(id: 1796236, name: "Shanghai", country: "CN");
    }
  }

  void initState() {
    super.initState();
    updateCity().then((_) {
      _updateWeather(cityItem);
    });
    EventUtil.busEvent.on<CityEvent>().listen((event) {
      print("hello aaaaa");
      setState(() {
        cityItem = event.cityItem;
      });
      _updateWeather(event.cityItem);
    });
  }

  void _updateWeather(CityItem item) async {
    if (item == null) return;
    var weather = await HttpUtil.currentWeather(item.id);
    print("weather:${weather.dateString()}");
    setState(() {
      weatherItem = weather == null ? weatherItem : weather;
    });
  }

  Widget _top() {
    return Container(
      constraints: BoxConstraints.expand(height: 200.0),
      child: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(),
            child: ResourceUtil.imageCover("white_cloud.jpg"),
          ),
          Positioned(
            child: FlareActor(
              "assets/animation/sunny_rotate.flr",
              animation: "sunny_rotate",
              fit: BoxFit.contain,
              alignment: Alignment.topRight,
            ),
          ),
          Positioned(
            bottom: 0.1,
            height: 40.0,
            left: 0.1,
            right: 0.1,
            child: Container(
//              constraints: BoxConstraints.expand(),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
                gradient: LinearGradient(
                    colors: [Color(0x55FFD600), Color(0x55BDBDBD)]),
              ),
              child: Center(
                child: Text(
                  cityItem == null
                      ? ""
                      : "${cityItem.name} ${weatherItem == null ? "" : " ${weatherItem.temp}F"}",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w700,
                      fontSize: TEXT_SIZE_LARGE),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _chartLine() {
    if (weatherItem == null) return Container();
    var list = List<LinePoint>();
    var p1 = LinePoint(0, weatherItem.temp / 2.0);
    var p2 = LinePoint(1, weatherItem.pressure / 10.0);
    var p3 = LinePoint(2, weatherItem.humidity);
    list.add(p1);
    list.add(p2);
    list.add(p3);
    return MLineChart(list);
  }

  Widget _chartBar() {
    if (weatherItem == null) return Container();
    var list = List<BarPoint>();
    var p1 = BarPoint("temp", weatherItem.temp / 2.0);
    var p2 = BarPoint("pressure", weatherItem.pressure / 10.0);
    var p3 = BarPoint("humidity", weatherItem.humidity);
    list.add(p1);
    list.add(p2);
    list.add(p3);
    return MBarChart(list);
  }

  Widget _chartPie() {
    if (weatherItem == null) return Container();
    var list = List<PiePoint>();
    var p1 = PiePoint(0, weatherItem.temp / 2.0);
    var p2 = PiePoint(1, weatherItem.pressure / 10.0);
    var p3 = PiePoint(2, weatherItem.humidity);
    list.add(p1);
    list.add(p2);
    list.add(p3);
    return MPieChart(list);
  }

  Widget _tabView() {
    return DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: TabBar(
                tabs: [
                  Tab(
                    text: "Line",
                  ),
                  Tab(text: "Bar"),
                  Tab(text: "Circle"),
                ],
                labelColor: Colors.white,
                unselectedLabelColor: MAIN_COLOR,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BubbleTabIndicator(
                    indicatorColor: MAIN_COLOR,
                    indicatorHeight: 25.0,
                    tabBarIndicatorSize: TabBarIndicatorSize.label),
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                _chartLine(),
                _chartBar(),
                _chartPie(),
              ]),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[_top(), Expanded(child: _tabView())],
        ),
      ),
    );
  }
}
