import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class BgPainter extends CustomPainter {
  BgPainter({required Animation<double> animation})
      : layer1 = Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.fill,
        layer2 = Paint()
          ..color = Colors.lime
          ..style = PaintingStyle.fill,
        layer3 = Paint()
          ..color = Colors.amber
          ..style = PaintingStyle.fill,
        aniLay1 = CurvedAnimation(
            parent: animation,
            curve: const SpringCurve(),
            reverseCurve: Curves.easeInCirc),
        aniLay2 = CurvedAnimation(
            parent: animation,
            curve: const Interval(0, 0.7,
                curve: Interval(0, 0.8, curve: SpringCurve())),
            reverseCurve: Curves.linear),
        aniLay3 = CurvedAnimation(
            parent: animation,
            curve: const Interval(0, 0.8,
                curve: Interval(0, 0.9, curve: SpringCurve())),
            reverseCurve: Curves.linear),
        super(repaint: animation);

  final Paint layer1;
  final Paint layer2;
  final Paint layer3;

  final Animation<double> aniLay1;
  final Animation<double> aniLay2;
  final Animation<double> aniLay3;

  void paintLayer1(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    _addPointToPath(path, [
      Offset(0, lerpDouble(0, size.height / 3, aniLay1.value)!),
      Offset(lerpDouble(size.width / 1.8, size.width / 2, aniLay1.value)!,
          lerpDouble(size.height / 5, size.height / 3, aniLay1.value)!),
      Offset(size.width / 2.5, lerpDouble(0, size.height - 50, aniLay1.value)!),
      Offset(size.width - 10, size.height / 4),
      Offset(size.width,
          lerpDouble(size.height / 3, size.height + 50, aniLay1.value)!),
    ]);

    canvas.drawPath(path, layer1);
  }

  void paintLayer2(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    _addPointToPath(path, [
      Offset(0, lerpDouble(0, size.height, aniLay2.value)!),
      Offset(0, lerpDouble(size.height / 4.5, size.height, aniLay2.value)!),
      Offset(lerpDouble(size.width / 2.8, size.width / 4, aniLay2.value)!,
          lerpDouble(size.height / 5, size.height / 2, aniLay2.value)!),
      Offset(lerpDouble(size.width / 1.5, size.width / 2, aniLay2.value)!,
          lerpDouble(size.height / 3.5, size.height, aniLay2.value)!),
      Offset(size.width,
          lerpDouble(size.height / 2, size.height / 4, aniLay2.value)!),
    ]);
    canvas.drawPath(path, layer2);
  }

  void paintLaye3(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height / 7);
    path.lineTo(size.width, 0);
    path.lineTo(lerpDouble(size.width / 2.8, 0, aniLay3.value)!, 0);
    _addPointToPath(path, [
      Offset(lerpDouble(size.width / 2.8, 0, aniLay3.value)!, 0),
      Offset(lerpDouble(size.width / 2.8, size.width / 3, aniLay3.value)!,
          lerpDouble(0, size.height + 100, aniLay3.value)!),
      Offset(lerpDouble(size.width - 100, size.width / 2, aniLay3.value)!,
          size.height / 17),
      Offset(lerpDouble(size.width - 20, size.width - 80, aniLay3.value)!,
          lerpDouble(size.height / 15, size.height + 250, aniLay3.value)!),
      Offset(size.width, size.height / 7),
    ]);

    canvas.drawPath(path, layer3);
  }

  void _addPointToPath(Path path, List<Offset> points) {
    if (points.length < 3) {
      throw UnsupportedError('Path Less Than 3');
    }

    for (int i = 0; i < points.length - 2; i++) {
      final xc = (points[i].dx + points[i + 1].dx) / 2;
      final yc = (points[i].dy + points[i + 1].dy) / 2;
      path.quadraticBezierTo(points[i].dx, points[i].dy, xc, yc);
    }
    path.quadraticBezierTo(
        points[points.length - 2].dx,
        points[points.length - 2].dy,
        points[points.length - 1].dx,
        points[points.length - 1].dy);
  }

  @override
  void paint(Canvas canvas, Size size) {
    paintLayer2(canvas, size);
    paintLaye3(canvas, size);
    paintLayer1(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class SpringCurve extends Curve {
  const SpringCurve({this.a = 0.15, this.w = 19.4});
  final double a;
  final double w;

  @override
  double transformInternal(double t) =>
      (-(pow(e, -t / a) * cos(t * w)) + 1).toDouble();
}
