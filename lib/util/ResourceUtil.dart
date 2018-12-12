///
/// Created by NieBin on 18-12-11
/// Github: https://github.com/nb312
/// Email: niebin312@gmail.com
///
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_weather/data/CityItem.dart';
import 'package:flutter_weather/const/string_const.dart';

const _CITIES_JSON = "assets/json/citys.json";

class ResourceUtil {
  static List<CityItem> items;

  static Future<List<CityItem>> readCityJson(context) async {
    var jsonString =
        await DefaultAssetBundle.of(context).loadString(_CITIES_JSON);
    JsonDecoder decoder = new JsonDecoder();
    var cities = await decoder.convert(jsonString);
    var list = List<CityItem>();
    for (var json in cities) {
      var item = CityItem.pareJson(json);
      list.add(item);
    }
    return list;
  }

  static Image imageCover(name, {double size}) {
    return Image.asset(
      "$ASSET_IMAGE_PATH$name",
      fit: BoxFit.fitHeight,
      width: size,
      height: size,
    );
  }
}
