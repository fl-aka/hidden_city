import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hidden_city/community.dart/openingpage.dart';
import 'package:hidden_city/gg/hubworld/crystalmenu.dart';
import 'package:hidden_city/you/profile/profilepage.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key, required this.forced});
  final bool forced;

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  double _top = 0;
  bool _deepClose = false, _forcedClose = false, _openWhenForced = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    double width = MediaQuery.of(context).size.width;

    if (widget.forced && !_openWhenForced) {
      _closingCeremony();
      if (!_deepClose) {
        _forcedClose = true;
      }
    }

    if (!widget.forced && _forcedClose) {
      _openingCeremony();
      _forcedClose = false;
    }

    if (!widget.forced) {
      if (_openWhenForced) {
        _deepClose = false;
      }
      _openWhenForced = false;
    }

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      top: _top,
      left: width / 10,
      child: SizedBox(
        height: 100,
        width: 300,
        child: Stack(
          children: [
            Positioned(
              left: 25,
              top: 15,
              child: Transform.rotate(
                angle: pi / 4,
                child: Container(
                  decoration: BoxDecoration(boxShadow: [shaSha()]),
                  height: 75,
                  width: 75,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    boxShadow: [shaSha()],
                    borderRadius: radisRad(),
                    color: Colors.blue),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 100,
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
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: () {
                            _closingCeremony();
                          },
                          child: const Icon(
                            Icons.arrow_drop_up,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  if (_top == -80) {
                    _openingCeremony();
                  } else {
                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (context, animation, _) =>
                            const ProfilePage()));
                  }
                },
                child: Hero(
                  tag: "PP",
                  child: ClipPath(
                    clipper: DiamondClipper(),
                    child: Container(
                        color: const Color.fromARGB(255, 194, 46, 46),
                        padding: const EdgeInsets.all(5),
                        height: 100,
                        width: 100,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
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
        ),
      ),
    );
  }

  void _closingCeremony() {
    setState(() {
      if (_top == 0) {
        _top = -80;
        if (!widget.forced) {
          _deepClose = true;
        }
        _openWhenForced = false;
        return;
      }
    });
  }

  void _openingCeremony() {
    setState(() {
      _deepClose = false;
      if (_top == -80) {
        _top = 0;
        if (widget.forced) {
          _openWhenForced = true;
          _forcedClose = false;
          _deepClose = true;
        }
        return;
      }
    });
  }

  BoxShadow shaSha() => const BoxShadow(
      color: Color.fromARGB(115, 204, 220, 57),
      offset: Offset(5, 5),
      spreadRadius: 1.0,
      blurRadius: 10.0);

  BorderRadius radisRad() => const BorderRadius.only(
      bottomLeft: Radius.elliptical(15, 10),
      bottomRight: Radius.elliptical(10, 15));
}
