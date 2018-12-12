///
/// Created by NieBin on 18-12-12
/// Github: https://github.com/nb312
/// Email: niebin312@gmail.com
///
import 'package:flutter/material.dart';
import 'base_event.dart';
import '../CityItem.dart';

class CityEvent extends BaseEvent {
  CityEvent({
    this.cityItem,
    int type = SELECT_CITY_DRAWER,
  }) : super(type: type);
  static const SELECT_CITY_DRAWER = 0x01;
  final CityItem cityItem;
}
