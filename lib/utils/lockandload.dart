import 'package:flutter/material.dart';
import 'dart:math';

class LockAndLoad extends StatefulWidget {
  const LockAndLoad({Key? key}) : super(key: key);

  @override
  State<LockAndLoad> createState() => _LockAndLoadState();
}

// kls Ani : ->b 35(2) \|/a <>
class _LockAndLoadState extends State<LockAndLoad> {
  double xPosition = 0;
  double yPosition = 0;

  double txPosition = 0;
  double tyPosition = 0;
  String no = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 49, 23, 38),
        Color.fromARGB(255, 14, 31, 63)
      ])),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned(
            top: 220,
            left: MediaQuery.of(context).size.width / 2 - 115,
            child: Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150),
                color: Colors.blueGrey,
              ),
            ),
          ),
          Transform.rotate(
              angle: 0.25,
              child: const MyScener(
                scrollmode: true,
                scrollx: true,
                scrolly: true,
                scrollz: true,
              )),
          Positioned(
            top: tyPosition,
            left: txPosition,
            child: GestureDetector(
              onPanEnd: (_) {
                xPosition = txPosition;
                yPosition = tyPosition;
              },
              onPanUpdate: (tapInfo) {
                setState(() {
                  txPosition += tapInfo.delta.dx;
                  tyPosition += tapInfo.delta.dy;
                });
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.orange,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            top: tyPosition + 25,
            left: txPosition + 25,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.red,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            top: yPosition + 50,
            left: xPosition + 50,
            child: DragTarget<int>(
              onAccept: (data) {
                no = data.toString();
              },
              builder: ((context, candidateData, rejectedData) => Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: Center(child: Text(no.toString())),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

class CardData {
  Color? color;
  double? x, y, z, angle;
  final int idx;
  double alpha = 0;

  CardData(this.idx) {
    color = Colors.primaries[idx % Colors.primaries.length];
    x = 0;
    y = 0;
    z = 0;
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
  int numItems = 40;
  double radio = 600.0;
  double? radioStep;
  int centerIdx = 1;

  int isDragged = 0;
  List<bool> dragged = [];

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    cardData = List.generate(numItems, (index) => CardData(index)).toList();
    radioStep = (pi * 2) / numItems;

    for (int i = 0; i < numItems; i++) {
      dragged.add(false);
    }

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

  Widget i = Container(
    margin: const EdgeInsets.all(12),
    width: 50,
    height: 80,
    alignment: Alignment.center,
    foregroundDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.black.withOpacity(0),
    ),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0),
            spreadRadius: 1,
            blurRadius: 12,
            offset: const Offset(0, 2))
      ],
    ),
  );

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
      c = Positioned(
        top: 300,
        left: MediaQuery.of(context).size.width / 2 - 28,
        child: Draggable<int>(
          data: vo.idx,
          onDragStarted: (() {
            dragged[vo.idx] = true;
            isDragged = vo.idx;
          }),
          onDragEnd: (__) {
            dragged[isDragged] = false;
          },
          feedback: Transform(
            alignment: Alignment.center,
            origin: const Offset(0.0, -0.0),
            transform: mt2,
            child: (dragged[vo.idx]) ? i : c,
          ),
          child: Transform(
            alignment: Alignment.center,
            origin: const Offset(0.0, -0.0),
            transform: mt2,
            child: (dragged[vo.idx]) ? i : c,
          ),
        ),
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
          _srollpower -= 0.005;
        }
        if (_.delta.dx < -5) {
          _srollpower += 0.005;
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black.withOpacity(0),
        alignment: Alignment.center,
        child: Stack(
          children: list,
        ),
      ),
    );
  }

  Widget addCard(CardData vo) {
    var alpha = ((1 - vo.z! / radio) / 2) * .6;
    Widget c;

    switch (vo.idx) {
      default:
        c = Container(
          margin: const EdgeInsets.all(12),
          width: 50,
          height: 80,
          alignment: Alignment.center,
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: (alpha > 0.579)
                ? Colors.black.withOpacity(0)
                : Colors.black.withOpacity(alpha),
          ),
          decoration: BoxDecoration(
            color: (alpha > 0.579)
                ? Colors.black.withOpacity(0)
                : (alpha > 0.2)
                    ? Colors.black
                    : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: (alpha > 0.579)
                      ? Colors.black.withOpacity(0)
                      : Colors.black.withOpacity(.2 + alpha * .2),
                  spreadRadius: 1,
                  blurRadius: 12,
                  offset: const Offset(0, 2))
            ],
          ),
        );
    }
    return c;
  }
}
