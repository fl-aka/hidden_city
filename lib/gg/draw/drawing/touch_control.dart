import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

typedef Reset = void Function(bool x);
typedef XandY = void Function(double x, double y);
typedef Remember = void Function();

double strokeWidth = 3.0;
bool aim = false, lines = false, follow = true;

class TouchControl extends StatefulWidget {
  final bool touchDraw;
  final Color selCol;

  final Reset reset;
  final Reset undo;
  final Reset redo;
  final bool reded;
  final bool undoed;
  final bool reseted;
  final bool fillStyle;

  final double xOf;
  final double yOf;
  final Remember oldPic;
  final XandY xY;

  const TouchControl(
      {Key? key,
      required this.touchDraw,
      required this.reset,
      required this.reseted,
      required this.undo,
      required this.redo,
      required this.reded,
      required this.undoed,
      required this.selCol,
      required this.oldPic,
      required this.xY,
      required this.xOf,
      required this.yOf,
      required this.fillStyle})
      : super(key: key);

  @override
  TouchControlState createState() => TouchControlState();
}

class TouchControlState extends State<TouchControl> {
  final GlobalKey _key = GlobalKey();
  double _helperPosX = 0, _helperPosY = 0;
  bool _touchDraw = false, _me = false, _moved = false, _hand2 = false;
  List<TouchPoints?> points = [];
  List<List<TouchPoints?>> coins = [];
  List<TouchPoints?> savepoints = [];
  List<TouchPoints?> counterpoints = [];
  final List<Image> _fatamorgana = [];
  StrokeCap strokeType = StrokeCap.round;
  PaintingStyle styleType = PaintingStyle.stroke;
  Color selectedColor = Colors.black;
  late Offset _lastTouchPoint;
  Timer? _timer;
  DateTime _w = DateTime.now();
  bool _fill = false, _begin = true, _wasOn = false;

  Offset ifLines(Offset kli) {
    if (lines) {
      kli = Offset(widget.xOf + 23, widget.yOf + 23);
    }
    return kli;
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
          ..style = styleType
          ..strokeCap = strokeType
          ..isAntiAlias = true
          ..color = selectedColor
          ..strokeWidth = strokeWidth,
        fill: _fill));
  }

  void reset() {
    if (widget.reseted) {
      _fatamorgana.clear();
      coins.clear();
      points.clear();
      savepoints.clear();
      widget.reset(false);
      lines = false;
      widget.xY(150, 80);
    }
  }

  void runFollow() {
    if (lines && follow) {
      if (points.isNotEmpty) {
        double txOf = points[points.length - 2]!.points!.dx - 22.9;
        double tyOf = points[points.length - 2]!.points!.dy - 22.9;
        widget.xY(txOf, tyOf);
        return;
      }
      if (savepoints.isNotEmpty) {
        double txOf = savepoints[0]!.points!.dx - 22.9;
        double tyOf = savepoints[0]!.points!.dy - 22.9;
        widget.xY(txOf, tyOf);
        return;
      }
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
      if (points.isEmpty && coins.isNotEmpty) {
        points = [...coins.last];
        coins.removeLast();
        _fatamorgana.removeLast();
      }
      widget.undo(false);
    }
  }

  void isStyle() {
    if (widget.fillStyle) {
      styleType = PaintingStyle.fill;
      _fill = true;
      _wasOn = true;
    } else {
      styleType = PaintingStyle.stroke;
      if (_wasOn) {
        points.clear();
        _takeMe();
        _wasOn = false;
      }
      _fill = false;
      _begin = true;
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
      widget.redo(false);
    }
  }

  void _handlePanStart(DragStartDetails details) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    if (DateTime.now().isBefore(_w.add(const Duration(milliseconds: 200)))) {
      _w = DateTime.now();
      if (!_touchDraw && aim) {
        lines = !lines;
        setState(() {});
      }
    }

    _canthandle();
    if (!aim && !_touchDraw) {
      double txOf = details.globalPosition.dx - 20;
      double tyOf = details.globalPosition.dy - 40;
      widget.xY(txOf, tyOf);
    }
    _lastTouchPoint =
        Offset(details.globalPosition.dx, details.globalPosition.dy);
    if (_touchDraw && !lines) {
      savepoints.clear();
      onChanged(details);
    } else {
      _helperPosX = widget.xOf - details.globalPosition.dx;
      _helperPosY = widget.yOf - details.globalPosition.dy;
      if (lines) {
        savepoints.clear();
        onChanged(details);
      }
    }
    setState(() {});
  }

  void _handlePanEnd(DragEndDetails details) {
    _timer?.cancel();
    _canthandle();
    if (_hand2) {
      _hand2 = false;
    }
    if (_touchDraw || lines) {
      points.add(null);
    }

    if (!_moved) {
      _w = DateTime.now();
    }

    _moved = false;

    widget.oldPic();
    setState(() {});
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    _moved = true;
    _canthandle();
    _timer?.cancel();
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

    if (_touchDraw && !lines) {
      if (!_hand2) {
        onChanged(details);
      }
    } else {
      if (!_hand2) {
        double txOf = _helperPosX + details.globalPosition.dx;
        double tyOf = _helperPosY + details.globalPosition.dy;
        widget.xY(txOf, tyOf);
      }

      if (lines) {
        if (!_hand2) {
          onChanged(details);
        }
      }
    }

    setState(() {});
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

  void _canthandle() async {
    if (points.length > 900 && !_me) {
      _me = true;
      coins.add([...points]);
      await _takeMe().whenComplete(() {
        points = points.sublist(coins.last.length);
        _me = false;
      });
    }
  }

  Future<void> _takeMe() async {
    RenderRepaintBoundary boundary =
        _key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 2);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      Uint8List pngBytes = byteData.buffer.asUint8List();
      _fatamorgana.add(Image.memory(pngBytes));
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    _touchDraw = widget.touchDraw;
    if (_touchDraw) {
      lines = false;
    }

    selectedColor = widget.selCol;
    reset();
    undo();
    redo();
    isStyle();
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanCancel: () => _timer?.cancel(),
        onPanDown: (_) {
          _timer = Timer(const Duration(seconds: 3), () {
            if (!_touchDraw) {
              if (lines) {
                follow = !follow;
              } else {
                aim = !aim;
              }
            }
            setState(() {});
          });
        },
        onPanStart: _handlePanStart,
        onPanEnd: _handlePanEnd,
        onPanUpdate: _handlePanUpdate,
        child: Stack(
          children: [
            if (_fatamorgana.isNotEmpty)
              for (int i = 0; i < _fatamorgana.length; i++) _fatamorgana[i],
            RepaintBoundary(
              key: _key,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: FutureBuilder<ui.Image?>(builder: (context, ss) {
                  return CustomPaint(
                    size: const Size(0, 0),
                    painter: TouchControlPainter(_begin,
                        pointsList: points,
                        image: ss.data,
                        nowCol: selectedColor),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TouchPoints {
  Paint? paint;
  Offset? points;
  int? noBrush;
  bool brush;
  bool fill;

  TouchPoints(
      {this.points,
      this.paint,
      this.noBrush,
      required this.brush,
      required this.fill});
}

class TouchControlPainter extends CustomPainter {
  List<TouchPoints?>? pointsList;
  List<Offset> offsetPoints = [];
  Color nowCol;
  ui.Image? image;
  late Canvas recoder;
  bool begin;
  TouchControlPainter(this.begin,
      {this.pointsList, this.image, required this.nowCol});

  bool pass = false;
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    for (int i = 0; i < pointsList!.length - 1; i++) {
      if (pointsList![i] != null) {
        if (pointsList![i]!.fill) {
          pass = true;
          if (begin) {
            path.moveTo(pointsList![i]!.points!.dx, pointsList![i]!.points!.dy);
            begin = false;
          } else {
            path.lineTo(pointsList![i]!.points!.dx, pointsList![i]!.points!.dy);
          }
        } else {
          pass = false;
          begin = true;
        }
      }

      if (!pass) {
        if (pointsList?[i] != null && pointsList?[i + 1] != null) {
          if (pointsList![i]!.brush && image != null) {
            canvas.drawImage(
                image!, pointsList![i]!.points!, pointsList![i]!.paint!);
          } else {
            canvas.drawLine(pointsList![i]!.points!,
                pointsList![i + 1]!.points!, pointsList![i]!.paint!);
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
    canvas.drawPath(
        path,
        Paint()
          ..color = nowCol
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(TouchControlPainter oldDelegate) {
    return true;
  }
}
