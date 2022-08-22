import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ta_uniska_bjm/gg/googlemaps/googlempsml.dart';
import 'package:ta_uniska_bjm/gg/hubworld/crystalmenu.dart';

class OpeningOfCommunity extends StatelessWidget {
  const OpeningOfCommunity({super.key});

  Future<bool> _next() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return WillPopScope(
      onWillPop: _next,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              LayoutBuilder(
                  builder: (context, consts) => TweenAnimationBuilder(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 800),
                        builder: (context, double value, child) => ShaderMask(
                            shaderCallback: (rect) => LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: const [
                                    Colors.white,
                                    Colors.transparent,
                                    Colors.transparent,
                                  ],
                                  stops: [
                                    lerpDouble(0, 1, value)!,
                                    lerpDouble(0, 1, value)! + 0.1,
                                    1
                                  ],
                                ).createShader(rect),
                            child: child),
                        child: const ThisContent(),
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
                          color: const Color.fromARGB(255, 194, 46, 46),
                          padding: const EdgeInsets.all(20),
                          height: 225,
                          width: 225,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: ClipPath(
                                  clipper: DiamondClipper(),
                                  child: user.photoURL != null
                                      ? Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      user.photoURL!))),
                                        )
                                      : const Center(),
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
          )),
    );
  }
}

class ThisContent extends StatefulWidget {
  const ThisContent({super.key});

  @override
  State<ThisContent> createState() => _ThisContentState();
}

class _ThisContentState extends State<ThisContent> {
  final _textCon = TextEditingController();
  bool _openingCer = false, _renOkay = false;

  @override
  void initState() {
    Timer(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _openingCer = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final user = FirebaseAuth.instance.currentUser!;
    return SizedBox.expand(
      child: Stack(children: [
        Container(
          color: const Color.fromARGB(190, 218, 211, 149),
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: _openingCer ? width / 1.25 : 0,
                height: _openingCer ? height / 4 : 0,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, offset: Offset(5, 6))
                  ],
                  borderRadius: BorderRadius.circular(25),
                ),
                onEnd: () {
                  Timer(const Duration(milliseconds: 800), () {
                    if (mounted) {
                      setState(() {
                        if (_openingCer) {
                          _renOkay = true;
                        } else {
                          _renOkay = false;
                        }
                      });
                    }
                  });
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: _renOkay ? const SmlMap() : const Center()),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: width / 1.25,
                  child: TextField(
                    controller: _textCon,
                    decoration: const InputDecoration(
                        hintText: 'Cari Komunitas',
                        suffixIcon: Icon(Icons.search)),
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: width / 1.25,
                height: height / 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white.withOpacity(0.4))),
              ),
              ElevatedButton(
                  onPressed: () {}, child: const Text('Daftarkan Komunitasmu!'))
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 100,
          child: Container(
            height: 50,
            width: 250,
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NameWidget(user: user),
                      if (user.email != null)
                        Text(user.email!,
                            style: const TextStyle(
                                fontSize: 10, color: Colors.white))
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}

class NameWidget extends StatelessWidget {
  const NameWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (user.displayName != null) {
        return Text(
          user.displayName!,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        );
      } else {
        String display = 'Error';
        if (user.email != null) {
          display = user.email!;
          int cut = 0;
          for (int i = 0; i < display.length; i++) {
            if (display[i] == '@') {
              cut = i;
              i = display.length;
            }
          }
          if (cut != 0) {
            display = display.substring(0, cut);
          }
        }
        return Text(
          display,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        );
      }
    });
  }
}
