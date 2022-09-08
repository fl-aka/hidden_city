import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hidden_city/gg/hubworld/crystalmenu.dart';
import 'package:hidden_city/gg/login/bigpedal.dart';

typedef Fate = void Function(int x);
typedef Deletion = void Function(bool x);

class Wheel extends StatefulWidget {
  const Wheel(
      {super.key,
      required this.destiny,
      required this.close,
      required this.side});
  final Fate destiny;
  final Deletion close;
  final int side;

  @override
  State<Wheel> createState() => _WheelState();
}

class _WheelState extends State<Wheel> {
  double lebar = 0, tinggi = 0;
  double _counter = 0, _angles = 0, _left = -100, _top = 100;
  int _side = 0;
  bool _add = false, _minus = false;
  late Timer _myTime;
  Duration aniDur = const Duration(milliseconds: 800);

  List<Icon> stateIco = [];

  void _sideCheck() {
    if (_side == 8) _side = 0;
  }

  void _onTapped() {
    if (tinggi == 200 || tinggi == 350) {
      setState(() {
        if (tinggi == 200) {
          tinggi = 350;
          lebar = 350;
          _top = 200;
          _left = -50;
        } else {
          tinggi = 200;
          lebar = 200;
          _top = 100;
          _left = -100;
        }
      });
    }
  }

  double getAngle() {
    return (_side == 1 || _side == 5)
        ? _angles - pi / 2
        : (_side == 2 || _side == 6)
            ? _angles - pi
            : (_side == 3 || _side == 7)
                ? _angles + pi / 2
                : (_side == 4)
                    ? pi
                    : 0;
  }

  void _incrementCounter() {
    if (_angles == _counter) {
      _side++;
      _sideCheck();
      setState(() {
        _counter = _counter + pi / 4;
        _add = true;
        _minus = false;
      });
      widget.destiny(_side);
    }
  }

  void _lessCounter() {
    if (_angles == _counter) {
      _sideCheck();
      if (_side == 0) {
        _side = 7;
      } else {
        _side--;
      }

      setState(() {
        _counter = _counter - pi / 4;
        _add = false;
        _minus = true;
      });
      widget.destiny(_side);
    }
  }

  void runAni() async {
    if (tinggi == 0) {
      _myTime = Timer(const Duration(milliseconds: 100), () {
        tinggi = 220;
        lebar = 220;
        setState(() {});
      });
    }
  }

  @override
  void initState() {
    _side = widget.side;
    _counter = _side * pi / 4;
    _angles = _counter;

    runAni();
    super.initState();
  }

  @override
  void dispose() {
    _myTime.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      left: _left,
      top: _top,
      child: StreamBuilder(
          stream: Stream.periodic(const Duration(milliseconds: 50)),
          builder: (context, snapshot) {
            if (_add) {
              if (_angles < _counter) {
                _angles += 0.09;
              } else {
                _angles = _counter;
              }
            }
            if (_minus) {
              if (_angles > _counter) {
                _angles -= 0.09;
              } else {
                _angles = _counter;
              }
            }
            if (_side == 0 && _angles == _counter) {
              _angles = 0;
              _counter = 0;
            }
            return Transform.rotate(
              angle: _angles,
              child: Stack(
                children: [
                  AnimatedContainer(
                    curve: const SpringCurve(),
                    duration: aniDur,
                    decoration: BoxDecoration(boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(115, 204, 220, 57),
                          spreadRadius: 1.0,
                          blurRadius: 10.0,
                          offset: Offset(4, 3))
                    ], borderRadius: BorderRadius.circular(250)),
                    height: tinggi,
                    width: lebar,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(250),
                    child: AnimatedContainer(
                      curve: const SpringCurve(),
                      duration: aniDur,
                      decoration: BoxDecoration(
                          gradient: SweepGradient(
                            colors: set1,
                          ),
                          borderRadius: BorderRadius.circular(250)),
                      height: tinggi,
                      width: lebar,
                      child: Column(children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: _onTapped,
                                  onPanUpdate: (details) {
                                    if (_angles == _counter) {
                                      if (details.delta.dx < -2) {
                                        _lessCounter();
                                      }
                                      if (details.delta.dy > 2) {
                                        _lessCounter();
                                      }
                                      if (details.delta.dx > 2) {
                                        _incrementCounter();
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    color: const Color.fromARGB(0, 255, 193, 7),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            right: tinggi / 25,
                                            bottom: lebar / 25,
                                            child: Transform.rotate(
                                              angle: getAngle(),
                                              child: Icon(
                                                //Action 2
                                                FontAwesomeIcons.chess,
                                                color: Colors.white,
                                                size: tinggi <= 220 ? 20 : 40,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: _onTapped,
                                  onPanUpdate: (details) {
                                    if (_angles == _counter) {
                                      if (details.delta.dx < -2) {
                                        _lessCounter();
                                      }
                                      if (details.delta.dx > 2) {
                                        _incrementCounter();
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    color: const Color.fromARGB(0, 244, 67, 54),
                                    child: Center(
                                      child: Transform.rotate(
                                        angle: getAngle(),
                                        child: Icon(
                                          //action 2
                                          Icons.square,
                                          color: Colors.white,
                                          size: tinggi <= 220 ? 25 : 45,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: _onTapped,
                                  onPanUpdate: (details) {
                                    if (_angles == _counter) {
                                      if (details.delta.dy < -2) {
                                        _lessCounter();
                                      }
                                      if (details.delta.dx < -2) {
                                        _lessCounter();
                                      }
                                      if (details.delta.dy > 2) {
                                        _incrementCounter();
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    color: const Color.fromARGB(0, 255, 153, 0),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            left: tinggi / 25,
                                            bottom: lebar / 25,
                                            child: Transform.rotate(
                                              angle: getAngle(),
                                              child: Icon(
                                                //action 1
                                                Icons.photo,
                                                color: Colors.white,
                                                size: tinggi <= 220 ? 20 : 40,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: _onTapped,
                                  onPanUpdate: (details) {
                                    if (_angles == _counter) {
                                      if (details.delta.dy < -2) {
                                        _incrementCounter();
                                      }
                                      if (details.delta.dy > 2) {
                                        _lessCounter();
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    color: const Color.fromARGB(0, 63, 81, 181),
                                    child: Center(
                                      child: Transform.rotate(
                                        angle: getAngle(),
                                        child: Icon(
                                          //action 4
                                          Icons.key,
                                          color: Colors.white,
                                          size: tinggi <= 220 ? 25 : 45,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    widget.close(false);
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(80),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                          child: Icon(
                                        FontAwesomeIcons.squareXmark,
                                        color: Colors.blue,
                                        size: tinggi <= 220 ? 25 : 45,
                                      ))),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: _onTapped,
                                  onPanUpdate: (details) {
                                    if (_angles == _counter) {
                                      if (details.delta.dy < -2) {
                                        _lessCounter();
                                      }
                                      if (details.delta.dy > 2) {
                                        _incrementCounter();
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    color: const Color.fromARGB(0, 76, 175, 79),
                                    child: Center(
                                      child: Transform.rotate(
                                        angle: getAngle(),
                                        child: Icon(
                                          Icons.brush,
                                          color: Colors.white,
                                          size: tinggi <= 220 ? 25 : 45,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _onTapped(),
                                  onPanUpdate: (details) {
                                    if (_angles == _counter) {
                                      if (details.delta.dy < -2) {
                                        _incrementCounter();
                                      }
                                      if (details.delta.dy > 2) {
                                        _lessCounter();
                                      }
                                      if (details.delta.dx > 2) {
                                        _lessCounter();
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    color:
                                        const Color.fromARGB(0, 255, 109, 64),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            right: tinggi / 25,
                                            top: lebar / 25,
                                            child: Transform.rotate(
                                              angle: getAngle(),
                                              child: Icon(
                                                //action 5
                                                Icons.military_tech,
                                                color: Colors.white,
                                                size: tinggi <= 220 ? 20 : 40,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: _onTapped,
                                  onPanUpdate: (details) {
                                    if (_angles == _counter) {
                                      if (details.delta.dx < -2) {
                                        _incrementCounter();
                                      }
                                      if (details.delta.dx > 2) {
                                        _lessCounter();
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    color: const Color.fromARGB(0, 255, 82, 82),
                                    child: Center(
                                      child: Transform.rotate(
                                        angle: getAngle(),
                                        child: Icon(
                                          //action 6
                                          Icons.text_fields,
                                          color: Colors.white,
                                          size: tinggi <= 220 ? 25 : 45,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: _onTapped,
                                  onPanUpdate: (details) {
                                    if (_angles == _counter) {
                                      if (details.delta.dy < -2) {
                                        _lessCounter();
                                      }
                                      if (details.delta.dy > 2) {
                                        _incrementCounter();
                                      }
                                      if (details.delta.dx < -2) {
                                        _incrementCounter();
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    color: const Color.fromARGB(0, 0, 187, 212),
                                    child: Stack(children: [
                                      Positioned(
                                          left: tinggi / 25,
                                          top: lebar / 25,
                                          child: Transform.rotate(
                                            angle: getAngle(),
                                            child: Icon(
                                              //action 7
                                              Icons.question_answer,
                                              color: Colors.white,
                                              size: tinggi <= 220 ? 20 : 40,
                                            ),
                                          ))
                                    ]),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
