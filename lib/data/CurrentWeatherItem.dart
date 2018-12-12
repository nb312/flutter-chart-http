///
/// Created by NieBin on 18-12-12
/// Github: https://github.com/nb312
/// Email: niebin312@gmail.com
///
import 'package:intl/intl.dart';
import 'dart:convert';

class CurrentWeatherItem {
  CurrentWeatherItem(
      {this.time,
      this.temp,
      this.pressure,
      this.humidity,
      this.temp_min,
      this.temp_max,
      this.weather});

  final int time;
  final double temp;
  final double pressure;
  final double humidity;
  final double temp_min;
  final double temp_max;
  final String weather;

  static Future<CurrentWeatherItem> pareItem(String body) async {
    JsonDecoder decoder = new JsonDecoder();
    var current = await decoder.convert(body);
    var main = current["main"];
    var w = current["weather"][0]["main"];
    var item = CurrentWeatherItem(
      time: current["dt"],
      temp: main["temp"],
      pressure: main["pressure"].toDouble(),
      humidity: main["humidity"].toDouble(),
      temp_min: main["temp_min"].toDouble(),
      temp_max: main["temp_max"].toDouble(),
      weather: w,
    );
    return item;
  }

  String dateString() {
    var t = DateTime.now();
    var format = DateFormat("HH:mm");
    return format.format(t);
  }
}

//{
//	"coord": {
//		"lon": 121.46,
//		"lat": 31.22
//	},
//	"weather": [{
//		"id": 802,
//		"main": "Clouds",
//		"description": "scattered clouds",
//		"icon": "03n"
//	}],
//	"base": "stations",
//	"main": {
//		"temp": 279.15,
//		"pressure": 1032,
//		"humidity": 71,
//		"temp_min": 279.15,
//		"temp_max": 279.15
//	},
//	"visibility": 10000,
//	"wind": {
//		"speed": 5,
//		"deg": 350
//	},
//	"clouds": {
//		"all": 40
//	},
//	"dt": 1544605200,
//	"sys": {
//		"type": 1,
//		"id": 9659,
//		"message": 0.0045,
//		"country": "CN",
//		"sunrise": 1544568197,
//		"sunset": 1544604744
//	},
//	"id": 1796236,
//	"name": "Shanghai",
//	"cod": 200
//}
