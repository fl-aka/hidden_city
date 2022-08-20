import 'package:flutter/material.dart';
import 'touch_control.dart';

typedef Odds = void Function();

class Aimer extends StatefulWidget {
  final bool touchDraw;
  final Reset hide;
  final double xOf;
  final double yOf;

  final Odds odds;
  const Aimer({
    super.key,
    required this.touchDraw,
    required this.hide,
    required this.xOf,
    required this.yOf,
    required this.odds,
  });

  @override
  State<Aimer> createState() => _AimerState();
}

class _AimerState extends State<Aimer> {
  double xOf1 = 200, yOf1 = 80;
  double _helperPosX1 = 0, _helperPosY1 = 0;
  bool _expad = false,
      _move = true,
      _expRenUp = false,
      _expRen = false,
      _hide = false;

  @override
  Widget build(BuildContext context) {
    final double lebar = MediaQuery.of(context).size.width;
    final double tinggi = MediaQuery.of(context).size.height;

    if (widget.touchDraw) {
      _expRen = false;
      _expRenUp = false;
    }

    return Stack(children: [
      Positioned(
          top: widget.yOf,
          left: widget.xOf,
          child: GestureDetector(
            onTap: () {
              setState(() {
                aim = !aim;
                if (!aim) {
                  lines = false;
                }
              });
            },
            child: SizedBox(
              height: 45,
              width: 45,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: (widget.touchDraw)
                      ? 0
                      : (aim)
                          ? 25
                          : 45,
                  width: (widget.touchDraw)
                      ? 0
                      : (aim)
                          ? 25
                          : 45,
                  decoration: BoxDecoration(
                      color: aim
                          ? const Color.fromARGB(83, 158, 158, 158)
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(50)),
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                        color: aim
                            ? lines
                                ? follow
                                    ? const Color.fromARGB(43, 33, 149, 243)
                                    : const Color.fromARGB(120, 244, 67, 54)
                                : const Color.fromARGB(43, 255, 255, 255)
                            : Colors.blue,
                        borderRadius: BorderRadius.circular(50)),
                    padding: const EdgeInsets.all(5),
                    child: Center(
                        child: aim || widget.touchDraw
                            ? null
                            : const Icon(
                                Icons.draw,
                                color: Colors.white,
                                size: 18,
                              )),
                  ),
                ),
              ),
            ),
          )),
      Positioned(
        top: yOf1,
        left: xOf1,
        child: GestureDetector(
          onTap: () {
            _expad = !_expad;
            if (!_expad) {
              _expRen = false;
            }
            setState(() {});
          },
          onPanStart: (details) {
            _helperPosX1 = xOf1 - details.globalPosition.dx;
            _helperPosY1 = yOf1 - details.globalPosition.dy;
            setState(() {});
          },
          onPanUpdate: (details) {
            if (_move) {
              xOf1 = _helperPosX1 + details.globalPosition.dx;
              yOf1 = _helperPosY1 + details.globalPosition.dy;

              if (xOf1 > lebar - 125) {
                xOf1 = lebar - 125;
              }
              if (xOf1 < 0) {
                xOf1 = 0;
              }

              if (_expad) {
                if (yOf1 > tinggi - 200) {
                  yOf1 = tinggi - 200;
                }
              } else {
                if (!_hide) {
                  if (yOf1 > tinggi - 100) {
                    yOf1 = tinggi - 100;
                  }
                } else {
                  if (yOf1 > tinggi - 35) {
                    yOf1 = tinggi - 35;
                  }
                }
              }
              if (yOf1 < 20) {
                yOf1 = 20;
              }
              setState(() {});
            }
          },
          child: Opacity(
            opacity: _expad ? 1 : 0.5,
            child: AnimatedContainer(
              onEnd: () {
                if (!widget.touchDraw) {
                  _expRenUp = true;
                }
                if (_expad) {
                  _expRen = true;
                } else {
                  _expRen = false;
                }
                setState(() {});
              },
              duration: const Duration(milliseconds: 500),
              height: (widget.touchDraw)
                  ? 0
                  : (_expad)
                      ? 220
                      : 35,
              width: (widget.touchDraw)
                  ? 0
                  : (_expad)
                      ? 210
                      : 100,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(25)),
              padding: const EdgeInsets.all(5),
              child: Column(children: [
                if (_expRenUp)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.circle,
                          color: Colors.indigo,
                          size: 15,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.check_box_outline_blank,
                            color: Colors.indigo,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (_expRen)
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 120,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        aim = true;
                                        lines = false;
                                        follow = false;
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        color: const Color.fromARGB(0, 0, 0, 0),
                                        child: Row(
                                          children: [
                                            _circleInCircle(0),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Text("No Stroke",
                                                  style: TextStyle(
                                                      color: aim && !lines
                                                          ? const Color
                                                                  .fromARGB(
                                                              255, 13, 71, 15)
                                                          : Colors.white)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        aim = true;
                                        lines = true;
                                        follow = true;
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        color: const Color.fromARGB(0, 0, 0, 0),
                                        child: Row(
                                          children: [
                                            _circleInCircle(1),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Text(
                                                "Stroke",
                                                style: TextStyle(
                                                    color: follow && lines
                                                        ? const Color.fromARGB(
                                                            255, 13, 71, 15)
                                                        : Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        aim = true;
                                        lines = true;
                                        follow = false;
                                        setState(() {});
                                      },
                                      child: Container(
                                        color: const Color.fromARGB(0, 0, 0, 0),
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            _circleInCircle(2),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: SizedBox(
                                                width: 50,
                                                child: Text(
                                                  "Undo Redo Not Follow",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: !follow && lines
                                                          ? const Color
                                                                  .fromARGB(
                                                              255, 13, 71, 15)
                                                          : Colors.white),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onPanStart: (details) {
                                  _move = false;
                                },
                                onPanUpdate: (details) {
                                  if (details.delta.dy > 5) {
                                    if (strokeWidth > 0) {
                                      strokeWidth -= 0.1;
                                    }
                                  }
                                  if (details.delta.dy < -5) {
                                    if (strokeWidth < 10) {
                                      strokeWidth += 0.1;
                                    }
                                  }
                                  setState(() {});
                                },
                                onPanEnd: (details) {
                                  _move = true;
                                },
                                child: SizedBox(
                                  width: 80,
                                  child: Column(
                                    children: [
                                      const Text("Brush Size",
                                          style: TextStyle(
                                            color: Colors.white,
                                          )),
                                      SizedBox(
                                        height: 110,
                                        child: RotatedBox(
                                          quarterTurns: 3,
                                          child: SliderTheme(
                                            data: const SliderThemeData(
                                                trackHeight: 7,
                                                inactiveTickMarkColor:
                                                    Colors.white,
                                                inactiveTrackColor:
                                                    Colors.white,
                                                thumbColor: Colors.lime,
                                                thumbShape:
                                                    RoundSliderThumbShape(
                                                        disabledThumbRadius: 10,
                                                        enabledThumbRadius: 10),
                                                activeTrackColor:
                                                    Colors.lightGreenAccent,
                                                activeTickMarkColor:
                                                    Colors.greenAccent),
                                            child: Slider(
                                              min: 1,
                                              max: 10,
                                              value: strokeWidth,
                                              onChanged: (val) {
                                                strokeWidth = val;
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                          strokeWidth.toString().substring(
                                              0,
                                              strokeWidth.toString().length > 5
                                                  ? 5
                                                  : strokeWidth
                                                      .toString()
                                                      .length),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.white,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    xOf1 = 200;
                                    yOf1 = 80;
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    color: const Color.fromARGB(0, 0, 0, 0),
                                    child: const Text(
                                      "Reset Position",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _hide = !_hide;
                                    widget.hide(_hide);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    color: const Color.fromARGB(0, 0, 0, 0),
                                    child: Text(
                                      _hide ? "Unhide other" : "Hide Other",
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
              ]),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget _circleInCircle(int x) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(50)),
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
            color: x == 0
                ? Colors.white
                : x == 1
                    ? Colors.blue
                    : Colors.red,
            borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
