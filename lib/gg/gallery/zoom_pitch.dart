import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

typedef Zoom = void Function(double x);

class PinchZoom extends StatefulWidget {
  const PinchZoom(
      {super.key,
      required this.child,
      required this.tooSmall,
      required this.tooBig});
  final Zoom tooSmall;
  final Zoom tooBig;
  final Widget child;

  @override
  State<PinchZoom> createState() => _PinchZoomState();
}

class _PinchZoomState extends State<PinchZoom> {
  double _posx = 0, _posy = 0, _hposx = 0, _hposy = 0, _less = 0;
  double klaus = 0, _now = 1;
  Offset _lastTouchPoint = const Offset(0, 0),
      _lastTouchPoint2 = const Offset(50, 0);
  bool _locpos = false, _first = true, _alreadyRun = false, _wait800ms = true;

  void _reset() {
    _less = 0;
    klaus = 0;
    _now = 1;
    _first = true;
    _alreadyRun = false;
    setState(() {});
  }

  @override
  void initState() {
    _reset();
    _callBackTimer();

    super.initState();
  }

  void _callBackTimer() {
    Timer(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _wait800ms = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: _wait800ms,
      child: GestureDetector(
        onPanStart: (details) {
          setState(() {
            _lastTouchPoint =
                Offset(details.localPosition.dx, details.localPosition.dy);
            _hposx = _posx - details.globalPosition.dx;
            _hposy = _posy - details.globalPosition.dy;
          });
        },
        onPanUpdate: (details) {
          if ((details.localPosition.dx - _lastTouchPoint.dx > 50 ||
                  details.localPosition.dx - _lastTouchPoint.dx < -50) ||
              (details.localPosition.dy - _lastTouchPoint.dy > 50 ||
                  details.localPosition.dy - _lastTouchPoint.dy < -50)) {
            _locpos = true;
            _lastTouchPoint2 =
                Offset(details.localPosition.dx, details.localPosition.dy);
            double alas, tinggi;
            alas = _lastTouchPoint.dx - _lastTouchPoint2.dx;
            if (alas < 0) {
              alas *= -1;
            }
            tinggi = _lastTouchPoint.dy - _lastTouchPoint2.dy;
            if (tinggi < 0) {
              tinggi *= -1;
            }
            if (_first) {
              _first = false;
              _less = sqrt(alas * alas + tinggi * tinggi) / 250;
            }
            klaus = sqrt(alas * alas + tinggi * tinggi) / 250;
            klaus = klaus - _less;
            if (klaus > 2 && !_alreadyRun) {
              _alreadyRun = true;
              _wait800ms = true;
              _callBackTimer();
              widget.tooBig(_now + klaus);
            }
            if (_now + klaus > 9 && !_alreadyRun) {
              _alreadyRun = true;
              _wait800ms = true;
              _callBackTimer();
              widget.tooBig(_now + klaus);
              _now = 1;
              klaus = 0;
            }
            if (_now + klaus < 0 && !_alreadyRun) {
              _alreadyRun = true;
              _wait800ms = true;
              _callBackTimer();
              widget.tooSmall(0);
              _now = 1;
              klaus = 0;
            }
          } else {
            _lastTouchPoint =
                Offset(details.localPosition.dx, details.localPosition.dy);

            if (!_locpos) {
              _posx = _hposx + details.globalPosition.dx;
              _posy = _hposy + details.globalPosition.dy;
            }
          }
          setState(() {});
        },
        onPanEnd: (details) {
          if (_locpos) {
            _now = _now + klaus;
            klaus = 0;
          }
          setState(() {
            _locpos = false;
            _first = true;
          });
        },
        child: Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                  top: _posy,
                  left: _posx,
                  child: Transform.scale(
                      scale: _now + klaus, child: widget.child)),
            ],
          ),
        ),
      ),
    );
  }
}
