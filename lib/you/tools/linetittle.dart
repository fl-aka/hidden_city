import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineTitles {
  static getTitleData(double max, double starter) => FlTitlesData(
      show: true,
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      leftTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 40,
        getTitlesWidget: (value, meta) {
          if (value == 1) {
            String returner = '';
            if (max >= 1000 && max < 1000000) {
              returner = "${(max * 2 / 10) / 1000}K";
            } else if (max >= 1000000 && max < 1000000000) {
              returner = "${(max * 2 / 10) / 1000000}M";
            } else {
              returner = "${(max * 2 / 10) / 1000000000}B";
            }
            return Text(
              returner,
              style: _textStyle(),
            );
          }
          if (value == 3) {
            String returner = '';
            if (max >= 1000 && max < 1000000) {
              returner = "${max / 2 / 1000}K";
            } else if (max >= 1000000 && max < 1000000000) {
              returner = "${max / 2 / 1000000}M";
            } else {
              returner = "${max / 2 / 1000000000}B";
            }
            return Text(
              returner,
              style: _textStyle(),
            );
          }
          if (value == 5) {
            String returner = '';
            if (max >= 1000 && max < 1000000) {
              returner = "${max / 1000}K";
            } else if (max >= 1000000 && max < 1000000000) {
              returner = "${max / 1000000}M";
            } else {
              returner = "${max / 1000000000}B";
            }
            return Text(
              returner,
              style: _textStyle(),
            );
          }
          return const Center();
        },
      )),
      bottomTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 22,
        getTitlesWidget: (value, meta) {
          double x = value + starter;
          return Text(
            x.toString(),
            style: _textStyle(),
          );
        },
      )));

  static TextStyle _textStyle() {
    return const TextStyle(
        color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16);
  }
}
