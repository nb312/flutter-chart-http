///
/// Created by NieBin on 18-12-11
/// Github: https://github.com/nb312
/// Email: niebin312@gmail.com
///
import 'package:flutter/material.dart';
import 'package:flutter_weather/view/to_app_bar.dart';
import 'dart:convert';
import 'package:flutter_weather/page/main_drawer.dart';
import 'package:flutter_weather/util/ResourceUtil.dart';
import 'package:flutter_weather/const/color_const.dart';
import 'package:flutter_weather/const/string_const.dart';
import 'package:flutter_weather/page/future_page.dart';
import 'package:flutter_weather/page/today_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<MainPage> {
  var _currentPage = 0;

  BottomNavigationBarItem _bottomItem(index) {
    var bgColor = index == _currentPage ? BOTTOM_COLORS[0] : BOTTOM_COLORS[1];
    return BottomNavigationBarItem(
      title: Text(
        BOTTOM_STR_ITEMS[index],
        style: TextStyle(color: bgColor),
      ),
      icon: Icon(
        BOTTOM_ICONS[index],
        color: bgColor,
      ),
    );
  }

  List<BottomNavigationBarItem> _bottomItems() {
    var list = List<BottomNavigationBarItem>();
    for (var i = 0; i < BOTTOM_STR_ITEMS.length; i++) {
      list.add(_bottomItem(i));
    }
    return list;
  }

  void initState() {
    super.initState();
  }

  Widget _body() {
    switch (_currentPage) {
      case 0:
        return TodayPage();
      case 1:
        return FuturePage();
      default:
        return TodayPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(
        titleText: BOTTOM_STR_ITEMS[_currentPage],
      ),
      body: _body(),
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomItems(),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }
}
