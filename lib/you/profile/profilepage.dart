import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ta_uniska_bjm/gg/hubworld/crystalmenu.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            LayoutBuilder(
                builder: (context, consts) => TweenAnimationBuilder(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 800),
                      builder: (context, double value, child) => ShaderMask(
                          shaderCallback: (rect) => LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: const [
                                  Colors.white,
                                  Colors.transparent,
                                  Colors.transparent,
                                ],
                                stops: [lerpDouble(0, 1, value)!, 0, 1],
                              ).createShader(rect),
                          child: child),
                      child: ProfileContent(
                        height: height,
                        width: width,
                      ),
                    )),
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 125,
              top: MediaQuery.of(context).size.height / 2 - 125,
              child: Hero(
                tag: "PP",
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: ClipPath(
                    clipper: DiamondClipper(),
                    child: Container(
                        color: const Color.fromARGB(255, 194, 46, 46),
                        padding: const EdgeInsets.all(20),
                        height: 250,
                        width: 250,
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
        ));
  }
}

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key, required this.height, required this.width});
  final double height;
  final double width;

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  double _logPosT = -100, _logPosF = -100, _big = 100;
  double _proPosT = -100, _proPosF = -100;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _logPosT = widget.height / 2 - 180;
          _logPosF = widget.width / 2 - 180;
          _proPosT = widget.height / 2 + 30;
          _proPosF = widget.width / 2 - 180;
          _big = 150;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: Stack(children: [
      GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: const BoxDecoration(color: Colors.black),
        ),
      ),
      AnimatedPositioned(
        duration: const Duration(milliseconds: 500),
        top: _logPosT,
        left: _logPosF,
        child: ClipPath(
          clipper: DiamondClipper(),
          child: GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              height: _big,
              width: _big,
              color: Colors.red,
              child: Center(
                  child: Text(
                'Log Out',
                style: TextStyle(
                    fontFamily: 'TechnoBoard',
                    color: Colors.white,
                    fontSize: lerpDouble(12, 30, _big / 150)!),
              )),
            ),
          ),
        ),
      ),
      AnimatedPositioned(
        duration: const Duration(milliseconds: 500),
        top: _proPosT,
        left: _proPosF,
        child: ClipPath(
          clipper: DiamondClipper(),
          child: GestureDetector(
            onTap: () {},
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              height: _big,
              width: _big,
              color: Colors.red,
              child: Center(
                  child: Text(
                'Profile',
                style: TextStyle(
                    fontFamily: 'TechnoBoard',
                    color: Colors.white,
                    fontSize: lerpDouble(12, 30, _big / 150)!),
              )),
            ),
          ),
        ),
      )
    ]));
  }
}
