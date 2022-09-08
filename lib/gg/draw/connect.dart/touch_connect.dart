import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hidden_city/http/fetching.dart';

typedef Reset = void Function(bool x);

class TouchConnect extends StatefulWidget {
  final Color selCol;
  final Reset reset;
  final Reset undo;
  final Reset redo;
  final Reset hide;
  final bool reded;
  final bool undoed;
  final bool reseted;
  final String ipIs;
  final String token;
  final String roomId;

  const TouchConnect(
      {Key? key,
      required this.reset,
      required this.reseted,
      required this.undo,
      required this.redo,
      required this.reded,
      required this.undoed,
      required this.selCol,
      required this.hide,
      required this.ipIs,
      required this.token,
      required this.roomId})
      : super(key: key);

  @override
  TouchConnectState createState() => TouchConnectState();
}

class TouchConnectState extends State<TouchConnect> {
  final GlobalKey _key = GlobalKey();
  double xOf = 0, yOf = 25;
  double xOf1 = 50, yOf1 = 25;
  int _pointWas = 0;
  double _helperPosX = 0, _helperPosY = 0;
  double _helperPosX1 = 0, _helperPosY1 = 0;
  final bool _touchDraw = false;
  bool _aim = false,
      _move = false,
      _lines = false,
      _follow = true,
      _hand2 = false,
      _expad = false,
      _expRenUp = false,
      _expRen = false,
      _boolWin = false,
      _hide = false;
  List<TouchPoints?> points = [];
  List<TouchPoints?> savepoints = [];
  List<TouchPoints?> counterpoints = [];
  double opacity = 1.0;
  StrokeCap strokeType = StrokeCap.round;
  double strokeWidth = 3.0;
  Color selectedColor = Colors.black;
  late Offset _lastTouchPoint;
  String role = "please wait";
  String pointo = "";
  DateTime _w = DateTime.now();
  Timer? _timer;

  TextEditingController con = TextEditingController();

  Offset ifLines(Offset kli) {
    if (_lines) {
      kli = Offset(xOf + 23, yOf + 23);
    }
    return kli;
  }

  void runFollow() {
    if (_lines && _follow) {
      if (points.isNotEmpty) {
        xOf = points[points.length - 2]!.points!.dx - 22.9;
        yOf = points[points.length - 2]!.points!.dy - 22.9;
        return;
      }
      if (savepoints.isNotEmpty) {
        xOf = savepoints[0]!.points!.dx - 22.9;
        yOf = savepoints[0]!.points!.dy - 22.9;
        return;
      }
    }
  }

  void reset() {
    if (widget.reseted) {
      points.clear();
      savepoints.clear();
      widget.reset(false);
      _lines = false;
      xOf = 0;
      yOf = 25;
      sendLiner();
    }
  }

  void undo() {
    if (widget.undoed) {
      if (points.isNotEmpty) {
        int breaks = 0;
        int nullpoint = 0;
        for (int i = points.length - 1; i > 0; i--) {
          if (points[i] == null) {
            nullpoint++;
          }
          if (nullpoint > 1) {
            if (points[i + 1] != null) {
              breaks = i + 1;
              i = 0;
            }
          }
        }
        if (savepoints.isNotEmpty) {
          for (int i = 0; i < savepoints.length; i++) {
            points.add(savepoints[i]);
          }
        }
        savepoints = points.sublist(breaks);
        points = points.sublist(0, breaks);
        runFollow();
      }
      sendLiner();
      widget.undo(false);
    }
  }

  void redo() {
    if (widget.reded) {
      if (savepoints.isNotEmpty) {
        int breaks = 0;
        counterpoints.clear();
        for (int i = 0; i < savepoints.length; i++) {
          counterpoints.add(savepoints[i]);
          if (savepoints[i] == null) {
            breaks = i;
            i = savepoints.length;
          }
        }
        savepoints = savepoints.sublist(breaks + 1, savepoints.length);
        for (int i = 0; i < counterpoints.length; i++) {
          points.add(counterpoints[i]);
        }
        runFollow();
      }

      sendLiner();
      widget.redo(false);
    }
  }

  void onChanged(dynamic details) {
    Offset kli = details.globalPosition;
    kli = ifLines(kli);
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    Offset coor = referenceBox.globalToLocal(kli);
    points.add(TouchPoints(
        brush: false,
        points: coor,
        paint: Paint()
          ..strokeCap = strokeType
          ..isAntiAlias = true
          ..color = selectedColor.withOpacity(opacity)
          ..strokeWidth = strokeWidth));
  }

  void _handlePanStart(DragStartDetails details) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    if (DateTime.now().isBefore(_w.add(const Duration(milliseconds: 200)))) {
      _w = DateTime.now();
      if (!_touchDraw) {
        if (!_touchDraw && _aim) {
          _lines = !_lines;
          setState(() {});
        }
      }
      setState(() {});
    }
    if (!_aim && !_touchDraw) {
      xOf = details.globalPosition.dx - 20;
      yOf = details.globalPosition.dy - 40;
    }

    if (role == 'drawer') {
      _lastTouchPoint =
          Offset(details.globalPosition.dx, details.globalPosition.dy);
      if (_touchDraw && !_lines) {
        savepoints.clear();
        onChanged(details);
      } else {
        _helperPosX = xOf - details.globalPosition.dx;
        _helperPosY = yOf - details.globalPosition.dy;
        if (_lines) {
          savepoints.clear();
          onChanged(details);
        }
      }
      setState(() {});
    }
  }

  void _handlePanEnd(DragEndDetails details) {
    _timer?.cancel();
    if (role == 'drawer') {
      if (_hand2) {
        _hand2 = false;
      }
      if (_touchDraw || _lines) {
        points.add(null);
      }
      sendLiner();

      if (!_move) {
        _w = DateTime.now();
      }
      _move = false;
      setState(() {});
    }
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    _move = true;
    _timer?.cancel();
    if (role == 'drawer') {
      if ((details.globalPosition.dx - _lastTouchPoint.dx > 50 ||
              details.globalPosition.dx - _lastTouchPoint.dx < -50) ||
          (details.globalPosition.dy - _lastTouchPoint.dy > 50 ||
              details.globalPosition.dy - _lastTouchPoint.dy < -50)) {
        _hand2 = true;
      } else {
        _hand2 = false;
        _lastTouchPoint =
            Offset(details.globalPosition.dx, details.globalPosition.dy);
      }
      if (_touchDraw && !_lines) {
        if (!_hand2) {
          onChanged(details);
        }
      } else {
        if (!_hand2) {
          xOf = _helperPosX + details.globalPosition.dx;
          yOf = _helperPosY + details.globalPosition.dy;
        }
        if (_lines) {
          if (!_hand2) {
            onChanged(details);
          }
        }
      }
      setState(() {});
    }
  }

  void sendLiner() {
    ActionLawsuit(action: (x, y) {}, heroIsHere: (x) {})
        .sendLine(widget.ipIs, pointsToJson(), widget.roomId, context);
  }

  Future<ui.Image> getImage(String path) async {
    var completer = Completer<ImageInfo>();
    var img = NetworkImage(path);
    img
        .resolve(const ImageConfiguration(size: Size(50, 50)))
        .addListener(ImageStreamListener((info, _) {
      completer.complete(info);
    }));
    ImageInfo imageInfo = await completer.future;
    return imageInfo.image;
  }

  @override
  Widget build(BuildContext context) {
    final double lebar = MediaQuery.of(context).size.width;
    final double tinggi = MediaQuery.of(context).size.height;
    selectedColor = widget.selCol;
    reset();
    undo();
    redo();
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanCancel: () => _timer?.cancel(),
        onPanDown: (_) {
          _timer = Timer(const Duration(seconds: 3), () {
            if (_lines) {
              _follow = !_follow;
            } else {
              _aim = !_aim;
            }
          });
        },
        onPanStart: _handlePanStart,
        onPanEnd: _handlePanEnd,
        onPanUpdate: _handlePanUpdate,
        child: Stack(
          children: [
            RepaintBoundary(
              key: _key,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: FutureBuilder<ui.Image?>(builder: (context, ss) {
                  return CustomPaint(
                    size: const Size(0, 0),
                    painter:
                        TouchControlPainter(pointsList: points, image: ss.data),
                  );
                }),
              ),
            ),
            if (role == "drawer")
              Positioned(
                top: 30,
                right: 0,
                child: StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 2)),
                    builder: (context, snapshot) {
                      ActionLawsuit(
                              action: (x, y) {},
                              heroIsHere: (x) {
                                if (role != x) {
                                  role = x;
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    setState(() {});
                                  });
                                }
                              })
                          .keepRoom(widget.ipIs, widget.token, widget.roomId,
                              _boolWin, context);

                      return SizedBox(
                        width: 140,
                        child: Column(
                          children: [
                            Text(
                              "You're a $role",
                              style: const TextStyle(fontSize: 21),
                            ),
                            FutureBuilder<List?>(
                                future: ActionLawsuit(
                                        action: (x, y) {}, heroIsHere: (x) {})
                                    .getAnswer(
                                        widget.ipIs, widget.roomId, context),
                                builder: (context, ss) {
                                  String late;
                                  if (ss.hasData) {
                                    late = ss.data![0]['answers'];
                                  } else {
                                    late = "Please Wait";
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Builder(builder: (context) {
                                      return Text(
                                        "Please Draw : $late",
                                        style: const TextStyle(fontSize: 21),
                                      );
                                    }),
                                  );
                                })
                          ],
                        ),
                      );
                    }),
              ),
            if (role == "guesser")
              Positioned(
                bottom: 50,
                left: 20,
                child: StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 2)),
                    builder: (context, snapshot) {
                      ActionLawsuit(
                              action: (x, y) {},
                              heroIsHere: (x) {
                                if (role != x) {
                                  role = x;
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    setState(() {});
                                  });
                                }
                              })
                          .keepRoom(widget.ipIs, widget.token, widget.roomId,
                              _boolWin, context);
                      if (role == 'guesser') {
                        if (!_aim) {
                          ActionLawsuit(
                              action: (x, y) {},
                              heroIsHere: (x) {
                                if (pointo != x) {
                                  pointo = x;
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    setState(() {});
                                  });
                                  try {
                                    _pointWas = points.length;
                                    points.clear();
                                    jsonToPoints(jsonDecode(x));
                                  } catch (e) {
                                    showDialog(
                                        context: context,
                                        builder: (builder) => AlertDialog(
                                              content: Text(e.toString()),
                                              title: const Text(
                                                  "Json To Points Error"),
                                            ));
                                  }
                                }
                              }).getPoints(widget.ipIs, widget.roomId, context);
                        }
                      }

                      return SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            Text(
                              "You're a $role",
                              style: const TextStyle(fontSize: 28),
                            ),
                            FutureBuilder<List?>(
                                future: ActionLawsuit(
                                        action: (x, y) {}, heroIsHere: (x) {})
                                    .getAnswer(
                                        widget.ipIs, widget.roomId, context),
                                builder: (context, ss) {
                                  String late;
                                  if (ss.hasData) {
                                    late = ss.data![0]['answers'];
                                  } else {
                                    late = "Please Wait";
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Builder(builder: (context) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                              width: 300,
                                              child: TextField(
                                                controller: con,
                                                decoration: InputDecoration(
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .green),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10))),
                                              )),
                                          ElevatedButton(
                                              onPressed: () {
                                                if (late.isNotEmpty &&
                                                    late != "Please Wait") {
                                                  if (late == con.text) {
                                                    _boolWin = true;
                                                  }
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                            content: Text((late ==
                                                                    con.text)
                                                                ? "You're Correct"
                                                                : "False"),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          "OK"))
                                                            ],
                                                          ));
                                                }
                                              },
                                              child: const Text("OK"))
                                        ],
                                      );
                                    }),
                                  );
                                })
                          ],
                        ),
                      );
                    }),
              ),
            Positioned(
                top: yOf,
                left: xOf,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (role == 'drawer') {
                        _aim = !_aim;
                        if (!_aim) {
                          _lines = false;
                        }
                      }
                    });
                  },
                  child: SizedBox(
                    height: 45,
                    width: 45,
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: (_touchDraw)
                            ? 0
                            : (_aim)
                                ? 25
                                : 45,
                        width: (_touchDraw)
                            ? 0
                            : (_aim)
                                ? 25
                                : 45,
                        decoration: BoxDecoration(
                            color: _aim
                                ? const Color.fromARGB(83, 158, 158, 158)
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(50)),
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          decoration: BoxDecoration(
                              color: _aim
                                  ? _lines
                                      ? _follow
                                          ? const Color.fromARGB(
                                              43, 33, 149, 243)
                                          : const Color.fromARGB(
                                              120, 244, 67, 54)
                                      : const Color.fromARGB(43, 255, 255, 255)
                                  : Colors.blue,
                              borderRadius: BorderRadius.circular(50)),
                          padding: const EdgeInsets.all(5),
                          child: Center(
                              child: _aim || _touchDraw
                                  ? null
                                  : const Icon(
                                      Icons.brush,
                                      color: Colors.white,
                                      size: 18,
                                    )),
                        ),
                      ),
                    ),
                  ),
                )),
            if (role == "drawer")
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
                  },
                  child: Opacity(
                    opacity: _hide
                        ? _expad
                            ? 1
                            : 0.5
                        : 1,
                    child: AnimatedContainer(
                      onEnd: () {
                        if (!_touchDraw) {
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
                      height: (_touchDraw)
                          ? 0
                          : (_expad)
                              ? 220
                              : 35,
                      width: (_touchDraw) ? 0 : 125,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(25)),
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
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _aim = true;
                                          _lines = false;
                                          _follow = false;
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          color:
                                              const Color.fromARGB(0, 0, 0, 0),
                                          child: Row(
                                            children: [
                                              _circleInCircle(0),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0),
                                                child: Text("No Stroke",
                                                    style: TextStyle(
                                                        color: _aim && !_lines
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
                                          _aim = true;
                                          _lines = true;
                                          _follow = true;
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          color:
                                              const Color.fromARGB(0, 0, 0, 0),
                                          child: Row(
                                            children: [
                                              _circleInCircle(1),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0),
                                                child: Text(
                                                  "Stroke",
                                                  style: TextStyle(
                                                      color: _follow && _lines
                                                          ? const Color
                                                                  .fromARGB(
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
                                          _aim = true;
                                          _lines = true;
                                          _follow = false;
                                          setState(() {});
                                        },
                                        child: Container(
                                          color:
                                              const Color.fromARGB(0, 0, 0, 0),
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
                                                        fontSize: 12,
                                                        color: !_follow &&
                                                                _lines
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
                                      const Divider(
                                        color: Colors.white,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                yOf = 25;
                                                yOf1 = 25;
                                                xOf = 0;
                                                xOf1 = 50;
                                                setState(() {});
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                color: const Color.fromARGB(
                                                    0, 0, 0, 0),
                                                child: const Text(
                                                  "Reset Position",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
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
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                color: const Color.fromARGB(
                                                    0, 0, 0, 0),
                                                child: Text(
                                                  _hide
                                                      ? "Unhide other"
                                                      : "Hide Other",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                      ]),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void jsonToPoints(List<dynamic> source) async {
    _aim = true;
    setState(() {});
    for (int i = 0; i < source.length; i++) {
      if (source[i]['coorx'] != "null") {
        double x = double.parse(source[i]['coorx']);
        double y = double.parse(source[i]['coory']);
        points.add(TouchPoints(
            brush: false,
            points: Offset(x, y),
            paint: Paint()
              ..strokeCap = strokeType
              ..isAntiAlias = true
              ..color = selectedColor.withOpacity(opacity)
              ..strokeWidth = strokeWidth));
        xOf = x - 23;
        yOf = y - 23;
        if (_pointWas < i) {
          await Future.delayed(const Duration(milliseconds: 5));
        }
        setState(() {});
      } else {
        points.add(null);
      }
    }
    _aim = false;
    xOf = 0;
    yOf = 25;
    setState(() {});
  }

  String pointsToJson() {
    String finale = "[";
    for (int i = 0; i < points.length; i++) {
      if (points[i] != null) {
        finale += '{"coorx" : "${points[i]!.points!.dx.toString()}",';
        finale += '"coory" : "${points[i]!.points!.dy.toString()}"},';
      } else {
        finale += '{"coorx" : "null",';
        finale += '"coory" : "null"},';
      }
    }
    if (finale.length > 1) finale = finale.substring(0, finale.length - 1);
    finale += ']';
    return finale;
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

class TouchPoints {
  Paint? paint;
  Offset? points;
  int? noBrush;
  bool brush;

  TouchPoints({this.points, this.paint, this.noBrush, required this.brush});
}

class TouchControlPainter extends CustomPainter {
  List<TouchPoints?>? pointsList = [];
  int pointsLast = 0;
  List<Offset> offsetPoints = [];
  ui.Image? image;
  late Canvas recoder;
  TouchControlPainter({this.pointsList, this.image});

  @override
  void paint(Canvas canvas, Size size) {
    if (pointsList!.length != pointsLast) {
      pointsLast = pointsList!.length;
    }
    for (int i = 0; i < pointsList!.length - 1; i++) {
      if (pointsList?[i] != null && pointsList?[i + 1] != null) {
        //Drawing line when two consecutive points are available
        if (pointsList![i]!.brush && image != null) {
          canvas.drawImage(
              image!, pointsList![i]!.points!, pointsList![i]!.paint!);
        } else {
          canvas.drawLine(pointsList![i]!.points!, pointsList![i + 1]!.points!,
              pointsList![i]!.paint!);
        }
      }
      if (pointsList![i] != null && pointsList![i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList![i]!.points!);
        offsetPoints.add(Offset(pointsList![i]!.points!.dx + 0.1,
            pointsList![i]!.points!.dy + 0.1));
        canvas.drawPoints(
            ui.PointMode.points, offsetPoints, pointsList![i]!.paint!);
      }
    }
  }

  @override
  bool shouldRepaint(TouchControlPainter oldDelegate) {
    if (pointsLast != pointsList!.length || pointsList!.isEmpty) {
      return true;
    }
    return false;
  }
}
