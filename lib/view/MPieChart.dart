///
/// Created by NieBin on 18-12-12
/// Github: https://github.com/nb312
/// Email: niebin312@gmail.com
///
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';
import 'char_point.dart';

class MPieChart extends StatelessWidget {
  MPieChart(this.points);

  final List<PiePoint> points;

  List<Series<PiePoint, num>> datumList() {
    return [
      Series<PiePoint, num>(
          id: "pie",
          data: points,
          domainFn: (PiePoint point, _) => point.key,
          measureFn: (PiePoint p, _) => p.value,
          displayName: "pie")
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: PieChart(datumList()),
    );
  }
}
