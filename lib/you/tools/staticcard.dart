import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ta_uniska_bjm/gg/hubworld/crystalmenu.dart';

import 'linetittle.dart';

class StaticCard extends StatefulWidget {
  const StaticCard({super.key});

  @override
  State<StaticCard> createState() => _StaticCardState();
}

class _StaticCardState extends State<StaticCard> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('MoneyHistory');
    List<dynamic> s = [];
    double starter = 0;
    for (int i = 0; i < box.length; i++) {
      s.add(box.getAt(i));
    }
    double up = _setUperBound(s);
    List<LineChartBarData> durable = [];
    for (int i = 0; i < s.length; i++) {
      List<dynamic> examine = s[i];
      List<FlSpot> great = [];
      starter = examine.length >= 8 ? examine.length - 8 : 0;
      for (int j = starter.toInt(); j < examine.length; j++) {
        double y = (examine[j].saldo / up) * 5;
        great.add(FlSpot(j - starter, y));
      }
      durable.add(LineChartBarData(
          spots: great,
          isCurved: true,
          barWidth: 5,
          belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(colors: [
                set1[i % 7].withOpacity(0.3),
                set2[i % 7].withOpacity(0.3)
              ])),
          gradient: LinearGradient(colors: [set1[i % 7], set2[i % 7]])));
    }
    //List<String> date = [];
    return Padding(
      padding:
          const EdgeInsets.only(top: 40.0, right: 20.0, bottom: 8, left: 8),
      child: LineChart(LineChartData(
          minX: 0,
          minY: 0,
          maxX: 8,
          maxY: 5,
          lineTouchData: LineTouchData(touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              List<LineTooltipItem> x = [];
              touchedSpots.sort(((a, b) => a.barIndex.compareTo(b.barIndex)));
              for (int i = 0; i < touchedSpots.length; i++) {
                x.add(LineTooltipItem('${(touchedSpots[i].y * up / 5).round()}',
                    TextStyle(color: set1[i % 7])));
              }
              return x;
            },
          )),
          titlesData: LineTitles.getTitleData(up, starter),
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(color: const Color(0x000ff374), strokeWidth: 3);
            },
          ),
          borderData: FlBorderData(
              show: true,
              border: const Border(
                  bottom: BorderSide(color: Colors.white, width: 1),
                  left: BorderSide(color: Colors.white, width: 1))),
          lineBarsData: durable)),
    );
  }
}

double _setUperBound(List<dynamic> s) {
  double contain = 0;
  for (int i = 0; i < s.length; i++) {
    for (int j = 0; j < s[i].length; j++) {
      if (s[i][j].saldo > contain) {
        contain = s[i][j].saldo;
      }
    }
  }
  return contain;
}
