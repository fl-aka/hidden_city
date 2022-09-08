import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hidden_city/gg/hubworld/crystalmenu.dart';

class WildBoxes extends StatefulWidget {
  const WildBoxes({super.key, required this.height, required this.width});
  final double height;
  final double width;

  @override
  State<WildBoxes> createState() => _WildBoxesState();
}

class _WildBoxesState extends State<WildBoxes> {
  final List<Duration> _timeLord = [];
  final List<Duration> _timeKing = [];
  final List<double> _uplink = [];
  final List<double> _leftlink = [];
  final List<double> _sizeLink = [];
  final List<int> _colLink = [];
  final List<double> _ballLink = [];

  int limit = 10;

  @override
  void initState() {
    limit += Random().nextInt(26);
    _setEveryThing();

    Timer(const Duration(milliseconds: 300), () {
      _clearEveryThing();
      _setEveryThing();
      setState(() {});
    });
    super.initState();
  }

  void _setEveryThing() {
    for (int i = 0; i < limit; i++) {
      _timeLord.add(Duration(milliseconds: 400 + Random().nextInt(800)));
      _timeKing.add(Duration(milliseconds: 400 + Random().nextInt(800)));
      _colLink.add(Random().nextInt(8));
      _sizeLink.add(Random().nextInt(250) + Random().nextDouble());
      _leftlink
          .add(Random().nextInt(widget.width.toInt()) + Random().nextDouble());
      _uplink
          .add(Random().nextInt(widget.height.toInt()) + Random().nextDouble());
      _ballLink.add(Random().nextInt(250) + Random().nextDouble());
    }
  }

  void _clearEveryThing() {
    _timeKing.clear();
    _timeLord.clear();
    _colLink.clear();
    _sizeLink.clear();
    _leftlink.clear();
    _uplink.clear();
    _ballLink.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Stack(children: [
        for (int i = 0; i < limit; i++)
          AnimatedPositioned(
              top: _uplink[i],
              left: _leftlink[i],
              duration: _timeLord[i],
              onEnd: () {
                setState(() {
                  _leftlink[i] = Random().nextInt(widget.width.toInt()) +
                      Random().nextDouble();
                  _uplink[i] = Random().nextInt(widget.height.toInt()) +
                      Random().nextDouble();
                  _timeLord[i] =
                      Duration(milliseconds: 400 + Random().nextInt(800));
                });
              },
              child: AnimatedContainer(
                  onEnd: () {
                    _colLink[i] = Random().nextInt(8);
                    _sizeLink[i] =
                        Random().nextInt(250) + Random().nextDouble();
                    _timeKing[i] =
                        Duration(milliseconds: 400 + Random().nextInt(800));
                    _ballLink[i] = Random().nextInt(50) + Random().nextDouble();
                    setState(() {});
                  },
                  width: _sizeLink[i],
                  height: _sizeLink[i],
                  decoration: Random().nextInt(3) != 0
                      ? BoxDecoration(
                          color: set1[_colLink[i]],
                          borderRadius: BorderRadius.circular(_ballLink[i]))
                      : BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(_ballLink[i]),
                          border:
                              Border.all(width: 2, color: set1[_colLink[i]])),
                  duration: _timeKing[i]))
      ]),
    );
  }
}
