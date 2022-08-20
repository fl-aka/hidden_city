import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ta_uniska_bjm/gg/hubworld/crystalmenu.dart';
import 'package:ta_uniska_bjm/utils/widgets/floatingtext.dart';

class Inventory extends StatefulWidget {
  final FractionalOffset center;
  const Inventory({super.key, required this.center});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            LayoutBuilder(
                builder: (context, consts) => TweenAnimationBuilder(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 1500),
                      builder: (context, double value, child) => ShaderMask(
                          shaderCallback: (rect) => RadialGradient(
                                  radius: value * 5,
                                  colors: const [
                                    Colors.white,
                                    Colors.white,
                                    Colors.transparent,
                                    Colors.transparent,
                                  ],
                                  stops: const [0.0, 0.55, 0.6, 1.0],
                                  center: widget.center)
                              .createShader(rect),
                          child: child),
                      child: const InventoryContent(),
                    )),
            Positioned(
              right: -50,
              bottom: -50,
              child: Hero(
                tag: "PP",
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: ClipPath(
                    clipper: DiamondClipper(),
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        color: const Color.fromARGB(255, 194, 46, 46),
                        height: 250,
                        width: 250,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: ClipPath(
                                clipper: DiamondClipper(),
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(user.photoURL!))),
                                ),
                              ),
                            ),
                            ClipPath(
                              clipper: DiamondClipper(),
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                      Colors.white.withOpacity(0.8),
                                      Colors.grey.withOpacity(0.4),
                                      Colors.white.withOpacity(0.2)
                                    ])),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class InventoryContent extends StatefulWidget {
  const InventoryContent({super.key});

  @override
  State<InventoryContent> createState() => _InventoryContentState();
}

class _InventoryContentState extends State<InventoryContent> {
  final BorderRadius _rad = BorderRadius.circular(25);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
              Color.fromARGB(80, 243, 33, 33),
              Color.fromARGB(110, 255, 94, 0)
            ])),
          ),
        ),
        const FloatingText(
          key: ValueKey(0),
          unevolved: "Materialistic",
          evolved: "~hateful~",
          subText: "You'll Just Never Get Enough!",
          tittle: 'In This ',
          tittleAfter: ' World',
        ),
        Positioned(
            top: 75,
            left: 0,
            child: SizedBox(
              width: width,
              height: width / 1.8,
              child: const TuningWizard(),
            )),
        Positioned(
          top: width / 2 + 100,
          left: 15,
          child: ClipRRect(
            borderRadius: _rad,
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                  child: SizedBox(
                    width: width - 30,
                    child: const Text(""),
                  ),
                ),
                Container(
                  width: width - 30,
                  height: height / 1.85,
                  decoration: BoxDecoration(
                      borderRadius: _rad,
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.grey.withOpacity(0.4),
                            Colors.grey.withOpacity(0.2),
                          ],
                          stops: const [
                            0.0,
                            1.0
                          ])),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TuningWizard extends StatefulWidget {
  const TuningWizard({super.key});

  @override
  State<TuningWizard> createState() => _TuningWizardState();
}

class _TuningWizardState extends State<TuningWizard>
    with TickerProviderStateMixin {
  final BorderRadius _rad = BorderRadius.circular(25);
  late AnimationController _aniCon;
  late Animation<double> _animation;
  bool _isFront = true, _already = false;
  double _horDrag = 0;
  int set = 0;

  @override
  void initState() {
    _aniCon = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _aniCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) {
        _aniCon.reset();
        setState(() {
          _horDrag = 0;
        });
      },
      onHorizontalDragUpdate: (details) {
        setState(() {
          _already = false;
          _horDrag -= details.delta.dx;
          _horDrag %= 360;
          if (_horDrag < 0) _horDrag *= -1;
          _setImageSide();
        });
      },
      onHorizontalDragEnd: (d) {
        double end = 0;
        if (_horDrag >= 90 && _horDrag <= 180 ||
            _horDrag >= 180 && _horDrag <= 270) {
          end = 180;
        }
        if (_horDrag >= 270) {
          end = 360;
        }
        _animation = Tween<double>(begin: _horDrag, end: end).animate(_aniCon)
          ..addListener(() {
            setState(() {
              _horDrag = _animation.value;
              if (end == 180) {
                _horDrag = -(180 - _animation.value);
              }
              if (!_isFront && !_already) {
                if (set < 6) {
                  set++;
                } else {
                  set = 0;
                }
                _already = true;
              }
              _isFront = true;
            });
          });
        _aniCon.forward();
      },
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(_horDrag / 180 * pi),
        child: _isFront
            ? Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: _rad, color: set1[set]),
                child: _inside())
            : Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateY(pi),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(borderRadius: _rad, color: set1[set + 1]),
                  child: _inside(),
                ),
              ),
      ),
    );
  }

  Widget _inside() {
    const TextStyle namaKartu = TextStyle(
      fontSize: 30,
      color: Colors.white,
    );
    const TextStyle dataSaldo = TextStyle(
      fontSize: 15,
      color: Colors.white,
    );

    return Stack(
      children: [
        Positioned(
            top: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(
                  width: 230,
                  height: 80,
                  child: Text(
                    "Nama Kartu",
                    style: namaKartu,
                  ),
                ),
                Text(
                  "Jumlah Saldo : Rp 0.0",
                  style: dataSaldo,
                ),
                Text(
                  "Sisa Kredit : Rp 0.0",
                  style: dataSaldo,
                ),
                Text(
                  "Jumlah Kredit : Rp 0.0",
                  style: dataSaldo,
                )
              ],
            )),
        Positioned(
            top: 20,
            right: 20,
            child: Container(
              height: 80,
              width: 80,
              color: Colors.black,
            ))
      ],
    );
  }

  void _setImageSide() {
    if (_horDrag <= 90 || _horDrag >= 270) {
      _isFront = true;
    } else {
      _isFront = false;
    }
  }
}
