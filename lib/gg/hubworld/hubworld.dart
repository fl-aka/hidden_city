import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ta_uniska_bjm/gg/chessnt/chessnt.dart';
import 'package:ta_uniska_bjm/gg/gallery/gallery.dart';
import 'package:ta_uniska_bjm/gg/hubworld/crystalmenu.dart';
import 'package:ta_uniska_bjm/gg/hubworld/profile.dart';

import 'package:ta_uniska_bjm/gg/random/login.dart';
import 'package:ta_uniska_bjm/gg/hubworld/wheel_of_fate.dart';
import 'package:ta_uniska_bjm/utils/testing/textani/textani.dart';
import 'package:ta_uniska_bjm/utils/testing/textbot/textmain.dart';
import 'package:ta_uniska_bjm/utils/lockandload.dart';

import '../draw/drawing/draw_control.dart';

class HubWorld extends StatefulWidget {
  final int where;
  const HubWorld({Key? key, this.where = 0}) : super(key: key);

  @override
  State<HubWorld> createState() => _HubWorldState();
}

class _HubWorldState extends State<HubWorld> {
  int _here = 0, _hereOld = 0, _there = 0;
  bool _pop = true;
  bool _chng = false, _showWh = false, _coolDown = false, _forceClear = true;

  @override
  void initState() {
    super.initState();
    _here = widget.where;
  }

  @override
  Widget build(BuildContext context) {
    if (_chng) {
      if (_there == 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginPage()));
        });
      }
    }

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    if (_coolDown) {
      Timer(const Duration(milliseconds: 500), () {
        _coolDown = false;
      });
    }

    return WillPopScope(
      onWillPop: _onbackPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              AnimatedSwitcher(
                transitionBuilder: (child, animation) {
                  double x = _here > _hereOld ? -1 : 1;
                  if (_here == 7 && _hereOld == 0 ||
                      _here == 0 && _hereOld == 7) {
                    x = x * -1;
                  }
                  final tween = Tween<Offset>(
                          begin: Offset(0, x), end: const Offset(0, 0))
                      .animate(animation);
                  return SlideTransition(
                    position: tween,
                    child: child,
                  );
                },
                layoutBuilder: (currentChild, previousChildren) {
                  return currentChild!;
                },
                duration: const Duration(milliseconds: 500),
                child: Builder(
                    key: ValueKey<int>(_here),
                    builder: (context) {
                      if (_here == 0) {
                        return Home(
                          chng: (x, i) {
                            _chng = x;
                            _there = i;
                            setState(() {});
                          },
                          pop: (x) {
                            _pop = x;
                            _forceClear = x;
                            setState(() {});
                          },
                        );
                      }
                      if (_here == 1) {
                        return const GaleriPage();
                      }
                      if (_here == 2) {}
                      if (_here == 3) {
                        return const Chessnt();
                      }
                      if (_here == 4) {
                        return const LockAndLoad();
                      }
                      if (_here == 5) {}
                      if (_here == 6) {
                        return const TextAni();
                      }
                      if (_here == 7) {
                        return const TextBot();
                      }

                      return Container();
                    }),
              ),
              if (_showWh)
                Wheel(
                  side: _here,
                  destiny: (dr) => setState(() {
                    _hereOld = _here;
                    _here = dr;
                  }),
                  close: (x) => setState(() {
                    _showWh = x;
                  }),
                ),
              Crystal(
                forced: !_forceClear,
                close: (x) => setState(
                  () {
                    if (!_coolDown) {
                      _showWh = !_showWh;
                      _coolDown = true;
                    }
                  },
                ),
              ),
              MyProfile(
                forced: !_forceClear,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onbackPressed() async {
    if (_pop) {
      return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("Keluar Dari Aplikasi?"),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("Iya")),
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("Tidak")),
                    ],
                  )) ??
          false;
    }
    return true;
  }
}
