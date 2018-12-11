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

class MainPage extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(
        titleText: "MainPage",
      ),
      body: FloatingActionButton(onPressed: () {}, child: Text("Click")),
      drawer: MainDrawer(),
    );
  }
}
