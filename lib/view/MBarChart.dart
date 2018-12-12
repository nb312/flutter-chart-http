///
/// Created by NieBin on 18-12-12
/// Github: https://github.com/nb312
/// Email: niebin312@gmail.com
///
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';
import 'char_point.dart';

class MBarChart extends StatelessWidget {
  MBarChart(this.points);

  final List<BarPoint> points;

  List<Series<BarPoint, String>> datumList() {
    return [
      Series<BarPoint, String>(
          id: "bar",
          data: points,
          domainFn: (BarPoint point, _) => point.name,
          measureFn: (BarPoint p, _) => p.y,
          displayName: "bar")
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: BarChart(datumList()),
    );
  }
}
