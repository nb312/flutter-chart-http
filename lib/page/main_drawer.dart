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

class MainDrawer extends StatefulWidget {
  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<MainDrawer> {
  Image _imageCover(name, {double size}) {
    return Image.asset(
      "$ASSET_IMAGE_PATH$name",
      fit: BoxFit.fitHeight,
      width: size,
      height: size,
    );
  }

  Widget _topBackground() {
    return Container(
      constraints: BoxConstraints.expand(height: 300.0),
      child: Stack(
        children: <Widget>[
          _imageCover("white_cloud.jpg", size: 300.0),
          Positioned(
            child: FlareActor(
              "assets/animation/sunny_rotate.flr",
              animation: "sunny_rotate",
              fit: BoxFit.contain,
              alignment: Alignment.topRight,
            ),
          ),
          Positioned(
              bottom: 10.0,
              child: Text(
                "Heloo",
                style: TextStyle(color: Colors.white),
              ))
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
            print("city.name: ${item.name},id: ${item.id}");
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
    return ConstrainedBox(
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
    );
  }
}

//CustomScrollView(
//slivers: <Widget>[
//SliverAppBar(
//pinned: true,
//expandedHeight: 150.0,
//flexibleSpace: _topBackground(),
//),
//SliverList(
//delegate: SliverChildBuilderDelegate((context, index) {
//if (_listIsEmpty()) {
//return Center(
//child: Text(
//CONTENT_IS_EMPTY,
//style: TextStyle(
//color: Colors.white, fontSize: TEXT_SIZE_NORMAL),
//),
//);
//} else {
//var item = ResourceUtil.items[index];
//return _cityWidget(item);
//}
//}, childCount: _listIsEmpty() ? 1 : ResourceUtil.items.length))
//],
//));
