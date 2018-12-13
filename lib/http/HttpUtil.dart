///
/// Created by NieBin on 18-12-12
/// Github: https://github.com/nb312
/// Email: niebin312@gmail.com
///
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_weather/data/CurrentWeatherItem.dart';
import 'package:flutter_weather/data/ForecastWeatherItem.dart';

const WEATHER_API_KEY = "fc7852ac3500e10480b5ae9f46e21e59";
const WEATHER_HOST = "http://api.openweathermap.org";
const WEATHER_URL = "$WEATHER_HOST/data/2.5";
const WEATHER_CURRENT = "$WEATHER_URL/weather";
const WEATHER_FORECAST = "$WEATHER_URL/forecast";
const APP_ID = "APPID";
const JSON_HEADER = {"Accept": "application/json"};

class HttpUtil {
  static Future<CurrentWeatherItem> currentWeather(cityId) async {
    var response = await http.get(
        "$WEATHER_CURRENT?$APP_ID=$WEATHER_API_KEY&id=$cityId",
        headers: JSON_HEADER);
    if (response.statusCode == 200) {
      print("current:${response.body}");
      var item = await CurrentWeatherItem.pareItem(response.body);
      print("temp:${item.temp}");
      return item;
    }
    return null;
  }

  static Future<List<ForecastWeatherItem>> forecastWeather(cityId) async {
    var response = await http.get(
        "$WEATHER_FORECAST?$APP_ID=$WEATHER_API_KEY&id=$cityId",
        headers: JSON_HEADER);
    if (response.statusCode == 200) {
      print("forecast:${response.body}");
      var list = await ForecastWeatherItem.pareItems(response.body);
      print("size:${list.length}");
      return list;
//      JsonDecoder decoder = new JsonDecoder();
//      var cities = await decoder.convert(response.body);
    }
    return null;
  }
}
