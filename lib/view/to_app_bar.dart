///
/// Created by NieBin on 18-12-11
/// Github: https://github.com/nb312
/// Email: niebin312@gmail.com
///
import 'package:flutter/material.dart';
import 'package:flutter_weather/const/size_const.dart';
import 'package:flutter_weather/const/color_const.dart';
class MainBar extends AppBar {
  MainBar(
      {Key key,
      this.titleText,
      this.titleColor = Colors.white,
        this.backgroundColor = MAIN_COLOR})
      : super(
            key: key,
            title: Text(
              titleText,
              style: TextStyle(color: titleColor, fontSize: TEXT_SIZE_LARGE),
            ),
      backgroundColor: backgroundColor, elevation: 0.0);
  final String titleText;
  final Color titleColor;
  final Color backgroundColor;
}


