import 'package:flutter/material.dart';
import 'package:hidden_city/utils/testing/textani/textani.dart';
import 'dart:math';
import 'package:hidden_city/utils/widgets/sprrringbuttonmdf.dart';

class Receive extends StatefulWidget {
  final String memo;
  const Receive({Key? key, required this.memo}) : super(key: key);

  @override
  State<Receive> createState() => _ReceiveState();
}

class _ReceiveState extends State<Receive> {
  int _eyes = 0;
  int _iHolder = 0;
  String _magic = "Magic", _clone = "";
  final List<int> _tri = [], _max = [];
  bool _complete = false;

  @override
  Widget build(BuildContext context) {
    _clone = widget.memo;
    didThis();
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Pesan Rahasia!", style: TextStyle(fontFamily: "Time")),
        backgroundColor: Colors.red.shade200,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                      stream:
                          Stream.periodic(const Duration(milliseconds: 500)),
                      builder: (context, snapshot) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black54,
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              const Text(
                                "Tolong Tekan Dan Tahan Tombol",
                                style: TextStyle(color: Colors.white),
                              ),
                              Row(
                                children: [
                                  Transform.scale(
                                      scale: 0.8,
                                      child: Button(true, "Press Me UwU",
                                          doThis: didThis)),
                                  Text(
                                    " Selama Setidaknya ${(_eyes - _iHolder).toString()} ",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ],
          ),
          Center(
            child: Builder(builder: (context) {
              void comp() {
                if (_clone == _magic) {
                  _complete = true;
                  _iHolder = _eyes;
                }
              }

              return Container(
                padding: const EdgeInsets.all(50),
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder(
                        stream:
                            Stream.periodic(const Duration(milliseconds: 50)),
                        builder: (context, snapshot) {
                          if (!_complete) {
                            for (int i = 0; i < _magic.length; i++) {
                              if (_magic[i] != _clone[i]) {
                                int r = 32 + Random().nextInt(94);
                                if (r == 33) r += 1 + Random().nextInt(93);

                                if (_tri[i] > _max[i]) {
                                  r = _clone.codeUnitAt(i);
                                }

                                _magic = replaceCharAt(
                                    _magic, i, getRandomString(1, r));

                                _tri[i] += 1;
                              }
                            }
                            _iHolder += 1;
                          }
                          comp();

                          return Column(
                            children: [
                              Text(
                                _magic,
                                style: const TextStyle(
                                    fontFamily: "Time", fontSize: 50),
                              ),
                            ],
                          );
                        }),
                    Button(true, "Press Me UwU", doThis: didThis)
                  ],
                )),
              );
            }),
          ),
        ],
      ),
    );
  }

  void didThis() {
    if (!_complete) {
      _magic = "";
      for (int i = 0; i < _clone.length; i++) {
        _magic = "$_magic*";
      }
      _tri.clear();
      for (int i = 0; i < _clone.length; i++) {
        _tri.add(0);
      }
      _max.clear();
      for (int i = 0; i < _clone.length; i++) {
        _max.add(30 + Random().nextInt(150));
      }

      for (int i = 0; i < _clone.length; i++) {
        if (_eyes < _max[i]) {
          _eyes = _max[i];
        }
      }
    }
  }
}
