///
/// Created by NieBin on 18-12-11
/// Github: https://github.com/nb312
/// Email: niebin312@gmail.com
///
import 'package:flutter/material.dart';
import 'dart:convert';

///"id": 6834870,
///    "name": "Haitou",
///    "country": "CN",
class CityItem {
  CityItem({this.id, this.name, this.country});

  static const ID = "id";
  static const NAME = "name";
  static const COUNTRY = "country";
  final int id;
  final String name;
  final String country;
  static CityItem pareJson(json) {
//    JsonDecoder decoder = new JsonDecoder();
//    var itemJ = decoder.convert(json);
    var item = CityItem(id: json[ID], name: json[NAME], country: json[COUNTRY]);
    return item;
  }
}
