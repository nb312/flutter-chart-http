///
/// Created by NieBin on 18-12-12
/// Github: https://github.com/nb312
/// Email: niebin312@gmail.com
///
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';
import 'LinePoint.dart';

class MLineChart extends StatelessWidget {
  MLineChart(this.points);

  final List<LinePoint> points;

  List<Series<LinePoint, num>> datumList() {
    return [
      Series<LinePoint, num>(
          id: "line",
          data: points,
          domainFn: (LinePoint point, _) => point.x,
          measureFn: (LinePoint p, _) => p.y,
          displayName: "line")
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: LineChart(datumList()),
    );
  }
}

