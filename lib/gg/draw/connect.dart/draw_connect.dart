import 'package:flutter/material.dart';
import 'package:hidden_city/gg/draw/connect.dart/touch_connect.dart';
import 'package:hidden_city/utils/widgets/anirotbu.dart';

class DrawConnect extends StatefulWidget {
  final String ipIs;
  final String roomId;
  final String roomName;
  final String token;
  final String answer;
  const DrawConnect(
      {Key? key,
      required this.ipIs,
      required this.roomId,
      required this.token,
      required this.answer,
      required this.roomName})
      : super(key: key);

  @override
  State<DrawConnect> createState() => _DrawConnectState();
}

class _DrawConnectState extends State<DrawConnect> {
  final GlobalKey _key = GlobalKey();
  bool _reset = false, _undo = false, _redo = false, _hide = false;
  double heightI = 0, widthI = 0;
  final Color _currentColor = const Color.fromARGB(255, 0, 0, 0);
  final Color _bgCol = Colors.white;
  final int _podM = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    double tinggi = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          RepaintBoundary(
              key: _key,
              child: Stack(children: [
                Container(
                  height: tinggi,
                  width: lebar,
                  color: _bgCol,
                ),
                //CostumPaint
                Container(
                  width: lebar,
                  height: tinggi,
                  color: const Color.fromARGB(0, 255, 255, 255),
                  child: Center(
                      child: TouchConnect(
                    roomId: widget.roomId,
                    token: widget.token,
                    ipIs: widget.ipIs,
                    selCol: _currentColor,
                    hide: (x) {
                      _hide = !_hide;
                      setState(() {});
                    },
                    redo: (x) {
                      _redo = x;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {});
                      });
                    },
                    reded: _redo,
                    undo: (x) {
                      _undo = x;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {});
                      });
                    },
                    undoed: _undo,
                    reseted: _reset,
                    reset: (x) {
                      _reset = x;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {});
                      });
                    },
                  )),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 1000),
                  bottom: posR("btm", _podM, tinggi, lebar, _hide) - 230,
                  right: posR("rgt", _podM, tinggi, lebar, _hide),
                  child: SizedBox(
                    height: 360,
                    child: Column(
                      children: [
                        Container(
                          color: const Color.fromARGB(0, 255, 255, 255),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(50),
                                  child: GestureDetector(
                                    child: Container(
                                        height: 55,
                                        width: 55,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: const Icon(Icons.redo,
                                            color: Colors.white)),
                                    onTap: () {
                                      _redo = true;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  child: Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                        height: 55,
                                        width: 55,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: const Icon(Icons.undo,
                                            color: Colors.white)),
                                  ),
                                  onTap: () {
                                    _undo = true;
                                    setState(() {});
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(50),
                                  child: GestureDetector(
                                    child: Container(
                                        height: 55,
                                        width: 55,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: const Icon(
                                            Icons.cleaning_services,
                                            color: Colors.white)),
                                    onTap: () {
                                      _reset = true;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}
