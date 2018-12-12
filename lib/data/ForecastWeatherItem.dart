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
      this.tempMin,
      this.tempMax,
      this.seaLevel,
      this.grndLevel});

  final int time;
  final double temp;
  final double pressure;
  final double humidity;
  final double tempMin;
  final double tempMax;
  final double seaLevel;
  final double grndLevel;

  static Future<ForecastWeatherItem> _pareItem(itemJson) async {
    var main = itemJson["main"];
    var item = ForecastWeatherItem(
      time: itemJson["dt"],
      temp: main["temp"],
      pressure: main["pressure"].toDouble(),
      humidity: main["humidity"].toDouble(),
      tempMin: main["temp_min"].toDouble(),
      tempMax: main["temp_max"].toDouble(),
      seaLevel: main["sea_level"].toDouble(),
      grndLevel: main["grnd_level"].toDouble(),
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
