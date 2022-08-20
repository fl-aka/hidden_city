import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ta_uniska_bjm/utils/plainVar/shadows.dart';

class FloatingText extends StatefulWidget {
  final String subText;
  final String tittle;
  final String tittleAfter;
  final String evolved;
  final String unevolved;
  final double left;
  final double left2;
  final double top;
  final double size;
  const FloatingText({
    super.key,
    this.subText = '',
    this.tittle = '',
    this.evolved = '',
    this.unevolved = '',
    this.tittleAfter = '',
    this.left = 0,
    this.left2 = 0,
    this.top = 0,
    this.size = 26,
  });

  @override
  State<FloatingText> createState() => _FloatingTextState();
}

class _FloatingTextState extends State<FloatingText> {
  Duration _duration = const Duration(milliseconds: 200);
  bool _texF = false, _resolve = true;

  late Timer _timer;
  double _top = 0, _left = 0;
  double _top2 = 0, _left2 = 0;
  double _angles = 0, _cat = 0;

  late String _text;
  static late TextStyle _style1;
  static late TextStyle _style11;
  static late TextStyle _style2;

  @override
  void initState() {
    _top = widget.top;
    _left = widget.left;
    _top2 = _top + 50;
    _left2 = widget.left2;
    _style1 = TextStyle(
      fontSize: widget.size,
      color: Colors.black,
      shadows: shiro,
    );
    _style11 = TextStyle(
        fontSize: widget.size - 10, color: Colors.black, shadows: shiro);
    _style2 = TextStyle(
        fontFamily: 'Scramble', fontSize: widget.size + 10, shadows: shiro);
    _text = widget.unevolved;
    Timer(const Duration(milliseconds: 500), () {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        assert(mounted);
        setState(() {
          _top = widget.top + 18;
          _left = widget.left + 10;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_resolve) {
      _timer = Timer((_duration), () {
        setState(() {
          if (!_texF) {
            _text = widget.evolved;
            _duration = const Duration(milliseconds: 50);
          } else {
            _text = widget.unevolved;
            _duration = const Duration(seconds: 5);
          }
          _texF = !_texF;
          _resolve = true;
        });
      });
      _resolve = false;
    }

    return SizedBox.expand(
      child: Stack(
        children: [
          AnimatedPositioned(
            top: _top,
            left: _left,
            onEnd: () {
              double topOld = _top;
              double leftOld = _left;
              while (_top == topOld) {
                _top = widget.top + Random().nextInt(18);
              }
              while (_left == leftOld) {
                _left = widget.left + Random().nextInt(18);
              }

              _top2 = widget.top + 50 + Random().nextInt(18);
              _left2 = widget.left2 + Random().nextInt(18);

              switch (Random().nextInt(5)) {
                case 0:
                  _angles = 0.05;
                  break;
                case 1:
                  _angles = -0.05;
                  break;
                case 2:
                  _angles = 0.085;
                  break;
                case 3:
                  _angles = -0.085;
                  break;
                default:
                  _angles = 0.00;
                  break;
              }

              setState(() {});
            },
            duration: const Duration(seconds: 1),
            curve: Curves.easeIn,
            child: StreamBuilder(
                stream: Stream.periodic(const Duration(milliseconds: 150)),
                builder: (context, snapshot) {
                  if (_cat != _angles) {
                    if (_cat < _angles) {
                      _cat += 0.0025;
                    }
                    if (_cat > _angles) {
                      _cat -= 0.0025;
                    }
                  }
                  return Transform.rotate(
                    angle: _cat,
                    child: RichText(
                        text: TextSpan(style: _style1, children: [
                      TextSpan(text: widget.tittle),
                      TextSpan(text: _text, style: _texF ? _style2 : _style1),
                      TextSpan(text: widget.tittleAfter)
                    ])),
                  );
                }),
          ),
          AnimatedPositioned(
            top: _top2,
            left: _left2,
            duration: const Duration(seconds: 1),
            curve: Curves.easeIn,
            child: Transform.rotate(
              angle: -_cat,
              child: Text(
                widget.subText,
                style: _style11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
