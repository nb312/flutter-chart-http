///
/// Created by NieBin on 18-12-11
/// Github: https://github.com/nb312
/// Email: niebin312@gmail.com
///
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_weather/data/CityItem.dart';
import 'package:flutter_weather/const/string_const.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _CITIES_JSON = "assets/json/citys.json";
final databaseReference = FirebaseDatabase.instance.reference();
final googleSignIn = new GoogleSignIn();

class ResourceUtil {
  static List<CityItem> items;

  static Future<List<CityItem>> readCityJson(context) async {
    var jsonString =
        await DefaultAssetBundle.of(context).loadString(_CITIES_JSON);
    JsonDecoder decoder = new JsonDecoder();
    var cities = await decoder.convert(jsonString);
    var list = List<CityItem>();
    for (var json in cities) {
      var item = CityItem.pareJson(json);
      list.add(item);
    }
    return list;
  }
  static Image imageCover(name, {double size}) {
    return Image.asset(
      "$ASSET_IMAGE_PATH$name",
      fit: BoxFit.cover,
      width: size,
      height: size,
    );
  }

  static createData() async {
    databaseReference.child("1").set({
      'title': "Hello world",
      'desc': "This is very good example to use",
    });
    databaseReference.child("2").set({
      'title': "Second Lisenter",
      'desc': "This is very good example to use",
    });
  }

  static void analytics() async {
    FirebaseAnalytics().logEvent(
      name: "Hello",
      parameters: {'name': "niebin"},
    );
  }

  static Future<Null> signIN() async {
    GoogleSignInAccount user = googleSignIn.currentUser;
    if (user == null) user = await googleSignIn.signInSilently();
    if (user == null) {
      user = await googleSignIn.signIn();
      print("signIN:name:${user.displayName}");
      analytics();
      createData();
    }
  }
}
