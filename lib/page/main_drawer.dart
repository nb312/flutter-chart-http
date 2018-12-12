///
/// Created by NieBin on 18-12-11
/// Github: https://github.com/nb312
/// Email: niebin312@gmail.com
///
import 'package:flutter/material.dart';
import 'package:flutter_weather/const/string_const.dart';
import 'package:flutter_weather/view/to_app_bar.dart';
import 'package:flutter_weather/const/size_const.dart';
import 'package:flutter_weather/data/CityItem.dart';
import 'package:flutter_weather/util/ResourceUtil.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_weather/http/HttpUtil.dart';
import 'package:flutter_weather/data/CurrentWeatherItem.dart';
import 'package:flutter_weather/const/color_const.dart';
import 'package:flutter_weather/data/event/base_event.dart';

class MainDrawer extends StatefulWidget {
  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<MainDrawer> {
  Widget _topBackground() {
    return Container(
      constraints: BoxConstraints.expand(height: 300.0),
      child: Stack(
        children: <Widget>[
          ResourceUtil.imageCover("white_cloud.jpg", size: 300.0),
          Positioned(
            child: FlareActor(
              "assets/animation/sunny_rotate.flr",
              animation: "sunny_rotate",
              fit: BoxFit.contain,
              alignment: Alignment.topRight,
            ),
          ),
          Positioned(
            bottom: 4.0,
            height: 40.0,
            left: 0.1,
            right: 0.1,
            child: Container(
//              constraints: BoxConstraints.expand(),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.yellowAccent[400],
                  Colors.white,
                ]),
              ),
              child: Text(
                "Please select a city!",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w700,
                  fontSize: TEXT_SIZE_LARGE,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _textWhite(name, {size = TEXT_SIZE_NORMAL, isBold = false}) {
    return Text(
      name,
      style: TextStyle(
          color: Colors.white, fontWeight: isBold ? FontWeight.w700 : null),
    );
  }

  Widget _cityWidget(CityItem item) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.grey[800], Colors.grey[300]],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
        ),
        margin: EdgeInsets.only(bottom: 1.0),
        child: ListTile(
          onTap: () {
            var event = CityEvent(cityItem: item);
            EventUtil.busEvent.fire(event);
            print("city.name: ${item.name},id: ${item.id}");
            Navigator.pop(context);
          },
          leading: CircleAvatar(
            child: _textWhite(item.name[0].toUpperCase(),
                size: TEXT_SIZE_LARGE, isBold: true),
            backgroundColor: Colors.grey[900],
          ),
          title: _textWhite(item.name),
          subtitle: _textWhite(item.country, size: TEXT_SIZE_SMALL),
        ));
  }

  void _sureNotEmpty(context) async {
    if (_listIsEmpty()) {
      ResourceUtil.readCityJson(context).then((list) {
        setState(() {
          ResourceUtil.items = list;
        });
      });
    }
  }

  bool _listIsEmpty() {
    return ResourceUtil.items == null || ResourceUtil.items.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    _sureNotEmpty(context);
    return Material(
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(width: 300.0),
        child: Container(
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (index == 0) {
                return _topBackground();
              } else {
                var item = ResourceUtil.items[index - 1];
                return _cityWidget(item);
              }
            },
            itemCount: _listIsEmpty() ? 1 : ResourceUtil.items.length + 1,
          ),
        ),
      ),
    );
  }
}
