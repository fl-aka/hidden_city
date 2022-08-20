import 'dart:math';
import 'package:flutter/material.dart';

class CardData {
  Color? color;
  double? x, y, z, angle;
  final int idx;
  double alpha = 0;

  Color get lightColor {
    var val = HSVColor.fromColor(color!);
    return val.withSaturation(.5).withValue(.8).toColor();
  }

  CardData(this.idx) {
    color = Colors.primaries[idx % Colors.primaries.length];
    x = 0;
    y = 0;
    z = 0;
  }
}

class RotationScene extends StatefulWidget {
  final bool scrollmode;
  final double see;
  final bool scrollx;
  final bool scrolly;
  final bool scrollz;
  const RotationScene(
      {Key? key,
      this.see = 1,
      this.scrollmode = true,
      this.scrollx = false,
      this.scrolly = true,
      this.scrollz = false})
      : super(key: key);

  @override
  State<RotationScene> createState() => _RotationSceneState();
}

class _RotationSceneState extends State<RotationScene> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          color: const Color.fromRGBO(97, 63, 117, 1),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Foto-foto',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
          ),
        ),
        Container(
          height: 500,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(229, 195, 209, widget.see),
              Color.fromRGBO(222, 196, 211, widget.see)
            ],
            stops: const [0, 1],
          )),
          child: Center(
              child: MyScener(
            scrollmode: widget.scrollmode,
            scrollx: widget.scrollx,
            scrolly: widget.scrolly,
            scrollz: widget.scrollz,
          )),
        ),
      ],
    );
  }
}

class MyScener extends StatefulWidget {
  final bool scrollmode;
  final bool scrollx;
  final bool scrolly;
  final bool scrollz;
  const MyScener(
      {Key? key,
      required this.scrollmode,
      required this.scrollx,
      required this.scrolly,
      required this.scrollz})
      : super(key: key);

  @override
  State<MyScener> createState() => _MyScenerState();
}

class _MyScenerState extends State<MyScener>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  List<CardData> cardData = [];
  int numItems = 6;
  double radio = 250.0;
  double? radioStep;
  int centerIdx = 1;

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    cardData = List.generate(numItems, (index) => CardData(index)).toList();
    radioStep = (pi * 2) / numItems;

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 25));

    _animationController?.addListener(() => setState(() {}));
    _animationController?.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        _animationController?.value = 0;
        _animationController?.animateTo(1);
        ++centerIdx;
      }
    });
    _animationController?.forward();
    super.initState();
  }

  double _srollpower = 0;

  @override
  Widget build(BuildContext context) {
    var ratio = _animationController?.value;
    double animValue = centerIdx + ratio!;
    if (widget.scrollmode) {
      animValue += _srollpower;
    }

    // process positions.
    for (var i = 0; i < cardData.length; ++i) {
      var c = cardData[i];
      double ang = c.idx * radioStep! + animValue;
      c.angle = ang + pi / 2;
      c.x = cos(ang) * radio;
//      c.y = sin(ang) * 10;
      c.z = sin(ang) * radio;
    }

    // sort in Z axis.
    cardData.sort((a, b) => a.z!.compareTo(b.z!));

    var list = cardData.map((vo) {
      var c = addCard(vo);
      var mt2 = Matrix4.identity();
      mt2.setEntry(3, 2, 0.001);
      mt2.translate(vo.x, vo.y!, -vo.z!);
      if (widget.scrollx) mt2.rotateX(vo.angle! + pi);
      if (widget.scrolly) mt2.rotateY(vo.angle! + pi);
      if (widget.scrollz) mt2.rotateZ(vo.angle! + pi);
      c = Transform(
        alignment: Alignment.center,
        origin: const Offset(0.0, -0.0),
        transform: mt2,
        child: c,
      );

//      depth of field... doesnt work on web.
//      var blur = .4 + ((1 - vo.z / radio) / 2) * 2;
//      c = BackdropFilter(
//        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
//        child: c,
//      );

      return c;
    }).toList();

    return GestureDetector(
      onPanUpdate: (_) {
        if (_.delta.dx > 5) {
          _srollpower -= 0.05;
        }
        if (_.delta.dx < -5) {
          _srollpower += 0.05;
        }
      },
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: list,
        ),
      ),
    );
  }

  Widget addCard(CardData vo) {
    var alpha = ((1 - vo.z! / radio) / 2) * .6;
    Widget c;
    c = Container(
      margin: const EdgeInsets.all(12),
      width: 240,
      height: 180,
      alignment: Alignment.center,
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black.withOpacity(alpha),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.1, .9],
          colors: [vo.lightColor, vo.color!],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.2 + alpha * .2),
              spreadRadius: 1,
              blurRadius: 12,
              offset: const Offset(0, 2))
        ],
      ),
      child: Text('ITEM ${vo.idx}'),
    );
    return c;
  }
}
