///
/// Created by NieBin on 18-12-12
/// Github: https://github.com/nb312
/// Email: niebin312@gmail.com
///
import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';

export 'CityEvent.dart';

class EventUtil {
  static final busEvent = EventBus();
}

class BaseEvent {
  BaseEvent({this.type});

  final int type;
}
