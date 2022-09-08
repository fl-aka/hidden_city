import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hidden_city/community.dart/openingpage.dart';
import 'package:hidden_city/you/you.dart';

typedef Deletion = void Function(bool x);

class Crystal extends StatefulWidget {
  const Crystal({super.key, required this.close, this.forced = false});
  final Deletion close;
  final bool forced;

  @override
  State<Crystal> createState() => _CrystalState();
}

List<Color> set1 = [
  Colors.green,
  Colors.cyan,
  Colors.redAccent,
  Colors.deepOrangeAccent,
  Colors.indigo,
  Colors.red,
  Colors.orange,
  Colors.green,
];

List<Color> set2 = [
  Colors.indigo,
  Colors.red,
  Colors.orange,
  Colors.green,
  Colors.cyan,
  Colors.redAccent,
  Colors.deepOrangeAccent,
  Colors.indigo,
];

List<Color> set3 = [
  Colors.cyan,
  Colors.redAccent,
  Colors.deepOrangeAccent,
  Colors.indigo,
  Colors.red,
  Colors.orange,
  Colors.green,
  Colors.cyan,
];

class _CrystalState extends State<Crystal> {
  double _left = 0;
  bool _menuOn = false,
      _close = false,
      _wasOpen = false,
      _deepClose = false,
      _forcedClose = false,
      _openWhenForced = false;

  final BoxDecoration _boxdecor = const BoxDecoration(boxShadow: [
    BoxShadow(
        color: Color.fromARGB(115, 204, 220, 57),
        offset: Offset(5, 5),
        blurRadius: 10,
        spreadRadius: 1)
  ]);

  TextStyle _disStyle(double size) {
    return TextStyle(
        color: Colors.white, fontFamily: 'TechnoBoard', fontSize: size);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    if (_close) {
      Timer(const Duration(milliseconds: 320), () {
        setState(() {
          _close = false;
        });
      });
    }
    if (widget.forced && !_openWhenForced) {
      _closingCeremony();
      if (!_deepClose) {
        _forcedClose = true;
      }
    }

    if (!widget.forced && _forcedClose) {
      _openingCeremony();
      _forcedClose = false;
    }

    if (!widget.forced) {
      if (_openWhenForced) {
        _deepClose = false;
      }
      _openWhenForced = false;
    }
    return AnimatedPositioned(
        duration: const Duration(milliseconds: 550),
        bottom: 0,
        left: _left,
        child: SizedBox(
          width: 230,
          height: 285,
          child: Stack(
            children: [
              AnimatedPositioned(
                left: _menuOn ? 30 : 55,
                top: _menuOn ? 78 : 55,
                duration: const Duration(milliseconds: 500),
                child: GestureDetector(
                  onTap: () {
                    widget.close(true);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: SweepGradient(
                            colors: _menuOn
                                ? set2
                                : _close
                                    ? set3
                                    : set1)),
                  ),
                ),
              ),
              Positioned(
                right: 45,
                top: 40,
                child: Stack(
                  children: [
                    Positioned(
                      left: 20,
                      top: 20,
                      child: Transform.rotate(
                        angle: -pi / 4,
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: _boxdecor,
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: DiamondClipper(),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _menuOn = !_menuOn;
                            if (!_menuOn && !_close) {
                              _close = true;
                            }
                          });
                        },
                        child: Container(
                            width: 130,
                            height: 130,
                            color: Colors.blue,
                            child: Center(
                                child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 500),
                                    child: _menuOn
                                        ? Text(
                                            "Close",
                                            style: _disStyle(32),
                                            key: const ValueKey<int>(1),
                                          )
                                        : Text(
                                            "Menu",
                                            style: _disStyle(32),
                                            key: const ValueKey<int>(0),
                                          )))),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 25,
                top: 0,
                child: Stack(
                  children: [
                    Positioned(
                      left: 10,
                      top: 10,
                      child: Transform.rotate(
                        angle: -pi / 4,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: _boxdecor,
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: DiamondClipper(),
                      child: GestureDetector(
                        onTap: () {
                          if (_left == 0) {
                            _closingCeremony();
                            return;
                          }
                          if (_left == -185) {
                            _openingCeremony();
                            return;
                          }
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          color: Colors.blue,
                          child: Transform.rotate(
                              angle: pi,
                              child: const Icon(
                                Icons.exit_to_app,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                right: _menuOn ? 130 : 50,
                top: _close ? 80 : 0,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _menuOn
                      ? Stack(
                          children: [
                            Positioned(
                              left: 10,
                              top: 10,
                              child: Transform.rotate(
                                angle: -pi / 4,
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: _boxdecor,
                                ),
                              ),
                            ),
                            ClipPath(
                              clipper: DiamondClipper(),
                              child: GestureDetector(
                                onPanStart: (dtl) {
                                  double dx = dtl.globalPosition.dx / width;
                                  double dy = dtl.globalPosition.dy / height;
                                  FractionalOffset center =
                                      FractionalOffset(dx, dy);
                                  Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (context, animation, _) =>
                                          You(
                                            center: center,
                                          )));
                                },
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  color: Colors.blue,
                                  child: Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 40,
                                      child: Column(
                                        children: [
                                          const Icon(
                                            Icons.person,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            'You',
                                            style: _disStyle(16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                right: _menuOn
                    ? 125
                    : _close
                        ? 35
                        : 130,
                top: _menuOn
                    ? 125
                    : _close
                        ? 40
                        : 0,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _menuOn
                      ? Stack(
                          children: [
                            Positioned(
                              left: 10,
                              top: 10,
                              child: Transform.rotate(
                                angle: -pi / 4,
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: _boxdecor,
                                ),
                              ),
                            ),
                            ClipPath(
                              clipper: DiamondClipper(),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (context, animation, _) =>
                                          const OpeningOfCommunity()));
                                },
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  color: Colors.blue,
                                  child: Center(
                                    child: SizedBox(
                                      width: 60,
                                      height: 35,
                                      child: Column(
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.building,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            'Community',
                                            style: _disStyle(12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                right: _menuOn
                    ? 0
                    : _close
                        ? 80
                        : 105,
                top: _close ? 40 : 120,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _menuOn
                      ? Stack(
                          children: [
                            Positioned(
                              left: 10,
                              top: 10,
                              child: Transform.rotate(
                                angle: -pi / 4,
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: _boxdecor,
                                ),
                              ),
                            ),
                            ClipPath(
                              clipper: DiamondClipper(),
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  color: Colors.blue,
                                  child: Center(
                                    child: SizedBox(
                                      width: 60,
                                      height: 35,
                                      child: Column(
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.flag,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            'Promotor',
                                            style: _disStyle(12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ),
              ),
            ],
          ),
        ));
  }

  void _closingCeremony() {
    setState(() {
      _left = -185;
      if (!widget.forced) {
        _deepClose = true;
      }
      _openWhenForced = false;
      if (_menuOn) {
        _wasOpen = true;
      }
      _menuOn = false;
    });
  }

  void _openingCeremony() {
    setState(() {
      _left = 0;
      _deepClose = false;
      if (_wasOpen) {
        _menuOn = true;
        _wasOpen = false;
      }
      if (widget.forced) {
        _openWhenForced = true;
        _forcedClose = false;
        _deepClose = true;
      }
    });
  }
}

class DiamondClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height / 2);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
