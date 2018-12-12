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
      this.sea_level,
      this.grnd_level});

  final int time;
  final double temp;
  final double pressure;
  final double humidity;
  final double temp_min;
  final double temp_max;
  final double sea_level;
  final double grnd_level;

  static Future<CurrentWeatherItem> pareItem(String body) async {
    JsonDecoder decoder = new JsonDecoder();
    var current = await decoder.convert(body);
    var main = current["main"];
    var item = CurrentWeatherItem(
      time: current["dt"],
      temp: main["temp"],
      pressure: main["pressure"].toDouble(),
      humidity: main["humidity"].toDouble(),
      temp_min: main["temp_min"].toDouble(),
      temp_max: main["temp_max"].toDouble(),
      sea_level: main["sea_level"].toDouble(),
      grnd_level: main["grnd_level"].toDouble(),
    );
    return item;
  }

  String dateString() {
    var t = DateTime.fromMicrosecondsSinceEpoch(time * 1000);
    var format = DateFormat("M-d HH:mm");
    return format.format(t);
  }
}

//{
//	"coord": {
//		"lon": 85.18,
//		"lat": 45.63
//	},
//	"weather": [{
//		"id": 803,
//		"main": "Clouds",
//		"description": "broken clouds",
//		"icon": "04d"
//	}],
//	"base": "stations",
//	"main": {
//		"temp": 253.352,
//		"pressure": 1005.62,
//		"humidity": 88,
//		"temp_min": 253.352,
//		"temp_max": 253.352,
//		"sea_level": 1054.52,
//		"grnd_level": 1005.62
//	},
//	"wind": {
//		"speed": 1.61,
//		"deg": 46.0002
//	},
//	"clouds": {
//		"all": 76
//	},
//	"dt": 1544592589,
//	"sys": {
//		"message": 0.0044,
//		"country": "CN",
//		"sunrise": 1544579426,
//		"sunset": 1544610922
//	},
//	"id": 1529626,
//	"name": "Baijiantan",
//	"cod": 200
//}
