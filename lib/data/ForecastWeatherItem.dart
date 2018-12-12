///
/// Created by NieBin on 18-12-12
/// Github: https://github.com/nb312
/// Email: niebin312@gmail.com
///
import 'package:intl/intl.dart';
import 'dart:convert';

class ForecastWeatherItem {
  ForecastWeatherItem(
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

  static Future<ForecastWeatherItem> _pareItem(itemJson) async {
    var main = itemJson["main"];
    var item = ForecastWeatherItem(
      time: itemJson["dt"],
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

  static Future<List<ForecastWeatherItem>> pareItems(String body) async {
    JsonDecoder decoder = new JsonDecoder();
    var bodyJson = await decoder.convert(body);
    var listJson = bodyJson["list"];
    var list = List<ForecastWeatherItem>();
    for (var itemJ in listJson) {
      var item = await _pareItem(itemJ);
      list.add(item);
    }
    return list;
  }

  String dateString() {
    var t = DateTime.fromMicrosecondsSinceEpoch(time * 1000);
    var format = DateFormat("M-d HH:mm");
    return format.format(t);
  }
}

//{
//	"cod": "200",
//	"message": 0.0062,
//	"cnt": 37,
//	"list": [{
//		"dt": 1544605200,
//		"main": {
//			"temp": 258.45,
//			"temp_min": 258.45,
//			"temp_max": 258.451,
//			"pressure": 718.39,
//			"sea_level": 1049.96,
//			"grnd_level": 718.39,
//			"humidity": 82,
//			"temp_kf": 0
//		},
//		"weather": [{
//			"id": 800,
//			"main": "Clear",
//			"description": "clear sky",
//			"icon": "01d"
//		}],
//		"clouds": {
//			"all": 0
//		},
//		"wind": {
//			"speed": 1.06,
//			"deg": 240.503
//		},
//		"sys": {
//			"pod": "d"
//		},
//		"dt_txt": "2018-12-12 09:00:00"
//	}],
//	"city": {
//		"id": 1280757,
//		"name": "Laojunmiao",
//		"coord": {
//			"lat": 39.8333,
//			"lon": 97.7333
//		},
//		"country": "CN"
//	}
//}
