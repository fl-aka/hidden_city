import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ta_uniska_bjm/gg/hubworld/crystalmenu.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:ta_uniska_bjm/you/inventory.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class You extends StatefulWidget {
  const You({super.key, required this.center});
  final FractionalOffset center;

  @override
  State<You> createState() => _YouState();
}

class _YouState extends State<You> {
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
                      child: const YouContent(),
                    )),
            Positioned(
              left: -50,
              top: -50,
              child: Hero(
                tag: "PP",
                child: GestureDetector(
                  onTap: () {
                    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
                    Navigator.of(context).pop();
                  },
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

class YouContent extends StatefulWidget {
  const YouContent({
    Key? key,
  }) : super(key: key);

  @override
  State<YouContent> createState() => _YouContentState();
}

class _YouContentState extends State<YouContent> {
  bool _toBe = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    BorderRadius rad = BorderRadius.circular(25);
    return SizedBox.expand(
      child: Stack(children: [
        GestureDetector(
          onTap: () {
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
            Navigator.of(context).pop();
          },
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue.withOpacity(0.4), Colors.white])),
          ),
        ),
        AnimatedPositioned(
          top: _toBe ? 0 : -100,
          left: 0,
          duration: const Duration(milliseconds: 500),
          child: Transform.rotate(
            angle: pi,
            child: WaveWidget(
                config: CustomConfig(
                    gradientBegin: Alignment.topLeft,
                    gradientEnd: Alignment.bottomRight,
                    gradients: [
                      [Colors.lime, Colors.amber],
                      [Colors.blue, Colors.lime],
                    ],
                    heightPercentages: [
                      0.1,
                      0.4,
                    ],
                    durations: [
                      10000,
                      8000,
                    ]),
                size: Size(width, 350)),
          ),
        ),
        if (_toBe)
          Center(
            child: ClipRRect(
              borderRadius: rad,
              child: SizedBox(
                width: 300,
                height: 300,
                child: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                      child: const SizedBox(
                        width: 300,
                        height: 300,
                        child: Text(""),
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: rad,
                          border:
                              Border.all(color: Colors.white.withOpacity(0.2)),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onPanStart: (dtl) {
                                    SystemChrome.setEnabledSystemUIMode(
                                        SystemUiMode.immersive);
                                    double dx = dtl.globalPosition.dx / width;
                                    double dy = dtl.globalPosition.dy / height;
                                    _toBe = false;
                                    FractionalOffset center =
                                        FractionalOffset(dx, dy);
                                    Navigator.of(context)
                                        .push(PageRouteBuilder(
                                            opaque: false,
                                            pageBuilder:
                                                (context, animation, _) =>
                                                    Inventory(
                                                      center: center,
                                                    )))
                                        .then((value) {
                                      _toBe = true;
                                      setState(() {});
                                    });
                                    setState(() {});
                                  },
                                  child: _menuList(
                                    'Inventory',
                                    const Icon(
                                      Icons.backpack_outlined,
                                      color: Colors.white,
                                    ),
                                    size: width / 4,
                                  ),
                                ),
                                _menuList(
                                    'Schedule',
                                    const Icon(
                                      Icons.calendar_month_rounded,
                                      color: Colors.white,
                                    ),
                                    size: width / 4),
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _menuList(
                                'Goal',
                                const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                size: width / 4,
                              ),
                              _menuList(
                                'Connections',
                                const Icon(
                                  FontAwesomeIcons.userGroup,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                size: width / 4,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ]),
    );
  }

  SizedBox _menuList(String text, Icon ico, {required size}) => SizedBox(
      width: size,
      height: size,
      child: Card(
          color: Colors.blue,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ico,
                ),
                Text(
                  text,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          )));
}
