///
/// Created by NieBin on 18-12-12
/// Github: https://github.com/nb312
/// Email: niebin312@gmail.com
///
import 'package:flutter/material.dart';
import 'package:flutter_weather/data/CityItem.dart';
import 'package:flutter_weather/data/event/base_event.dart';
import 'package:flutter_weather/http/HttpUtil.dart';
import 'package:flutter_weather/data/ForecastWeatherItem.dart';
import 'package:flutter_weather/view/char_point.dart';
import 'package:flutter_weather/view/MLineChart.dart';
import 'package:flutter_weather/const/size_const.dart';
import 'package:flutter_weather/view/MBarChart.dart';
import 'package:flutter_weather/view/MPieChart.dart';
import 'package:flutter_weather/const/color_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_weather/util/share_prefer.dart';

class FuturePage extends StatefulWidget {
  @override
  _FutureState createState() => _FutureState();
}

class _FutureState extends State<FuturePage> {
  CityItem cityItem;
  List<ForecastWeatherItem> forecastItems;

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

  @override
  void initState() {
    super.initState();
    updateCity().then((_) {
      _updateData(cityItem);
    });
    EventUtil.busEvent.on<CityEvent>().listen((event) {
      print("hello aaaaa");
      setState(() {
        cityItem = event.cityItem;
      });
      _updateData(cityItem);
    });
  }

  void _updateData(CityItem item) async {
    if (item == null) return;
    var list = await HttpUtil.forecastWeather(item.id);
    setState(() {
      forecastItems = list == null ? forecastItems : list;
    });
  }

  Widget _chartBase(name, child) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      constraints: BoxConstraints.expand(height: 240.0),
      child: Card(
        elevation: 4.0,
        child: Column(
          children: <Widget>[
            Text(
              name,
              style:
                  TextStyle(color: Colors.grey[900], fontSize: TEXT_SIZE_LARGE),
            ),
            SizedBox(
              height: 4.0,
            ),
            Expanded(child: child)
          ],
        ),
      ),
    );
  }

  num _measureValue(ForecastWeatherItem item, WeatherType type) {
    var num = 0.0;
    switch (type) {
      case WeatherType.Temperature:
        num = item.temp / 300.0;
        break;
      case WeatherType.Humidity:
        num = item.humidity / 100.0;
        break;
      case WeatherType.Pressure:
        num = item.pressure / 1000.0;
        break;
    }
    return num;
  }

  Widget _lineChart(WeatherType type) {
    if (forecastItems == null || forecastItems.isEmpty) return Container();
    var points = List<LinePoint>();
    for (var i = 0; i < forecastItems.length; i++) {
      var num = _measureValue(forecastItems[i], type);
      var p = LinePoint(i, num);
      points.add(p);
    }
    return Container(
      child: MLineChart(points),
    );
  }

  Widget _barChart(WeatherType type) {
    if (forecastItems == null || forecastItems.isEmpty) return Container();
    var points = List<BarPoint>();
    for (var i = 0; i < forecastItems.length; i++) {
      var num = _measureValue(forecastItems[i], type);
      var p = BarPoint("$i", num);
      points.add(p);
    }
    return Container(
      child: MBarChart(points),
    );
  }

  Widget _pieChart(WeatherType type) {
    if (forecastItems == null || forecastItems.isEmpty) return Container();
    var points = List<PiePoint>();
    for (var i = 0; i < forecastItems.length; i++) {
      var num = _measureValue(forecastItems[i], type);
      var p = PiePoint(i, num);
      points.add(p);
    }
    return Container(
      child: MPieChart(points),
    );
  }

  Widget _tabs() {
    return Container(
      color: MAIN_COLOR,
      constraints: BoxConstraints.expand(height: 40.0),
      child: TabBar(
        tabs: [
          Tab(
            text: "Line",
          ),
          Tab(
            text: "Bar",
          ),
          Tab(
            text: "Circle",
          ),
        ],
        isScrollable: false,
        labelColor: Colors.blue,
        indicatorColor: Colors.blue,
        unselectedLabelColor: Colors.white,
      ),
    );
  }

  Widget _bodyChart(ChartType type) {
    var list = List<Widget>();
    switch (type) {
      case ChartType.Line:
        list = [
          _chartBase("Temperature", _lineChart(WeatherType.Temperature)),
          _chartBase("Humidity", _lineChart(WeatherType.Humidity)),
          _chartBase("Pressure", _lineChart(WeatherType.Pressure)),
        ];
        break;
      case ChartType.Bar:
        list = [
          _chartBase("Temperature", _barChart(WeatherType.Temperature)),
          _chartBase("Humidity", _barChart(WeatherType.Humidity)),
          _chartBase("Pressure", _barChart(WeatherType.Pressure)),
        ];
        break;
      case ChartType.Circle:
        list = [
          _chartBase("Temperature", _pieChart(WeatherType.Temperature)),
          _chartBase("Humidity", _pieChart(WeatherType.Humidity)),
          _chartBase("Pressure", _pieChart(WeatherType.Pressure)),
        ];
        break;
    }
    return ListView(
      children: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              _tabs(),
              cityItem == null
                  ? Container()
                  : Expanded(
                      child: TabBarView(children: [
                        _bodyChart(ChartType.Line),
                        _bodyChart(ChartType.Bar),
                        _bodyChart(ChartType.Circle),
                      ]),
                    ),
            ],
          )),
    );
  }
}

enum WeatherType { Temperature, Pressure, Humidity }
enum ChartType { Line, Bar, Circle }
