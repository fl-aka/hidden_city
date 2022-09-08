import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:hidden_city/utils/plainVar/shadows.dart';

class TextAni extends StatefulWidget {
  const TextAni({super.key});
  @override
  State<TextAni> createState() => _TextAniState();
}

class _TextAniState extends State<TextAni> {
  @override
  Widget build(BuildContext context) {
    CollectionReference textFire = FirebaseFirestore.instance.collection('msg');
    return Scaffold(
        backgroundColor: Colors.black45,
        appBar: AppBar(
          title: const Text("Pesan Rahasia",
              style: TextStyle(fontFamily: "Scramble")),
          backgroundColor: Colors.black,
        ),
        body: Content(texFire: textFire));
  }
}

Widget sprringButton(
    {required void Function()? doThis, required void Function()? stopiT}) {
  List<double> forces = [];
  forces.clear();
  for (int i = 0; i < 31; i++) {
    forces.add(i.toDouble());
  }
  double finale = 3;
  String owo = "PRESS ME OwO";
  return StreamBuilder(
      stream: Stream.periodic(const Duration(milliseconds: 100)),
      builder: (context, snapshot) {
        void ending() {
          for (int i = 0; i < 31; i++) {
            forces[i] = i.toDouble();
          }
          finale = forces[30] / 10;
          owo = "PRESS ME Again! >w<";
          stopiT!();
        }

        return GestureDetector(
          onTapCancel: () => ending(),
          onTapUp: (tapUpDetails) => ending(),
          onTapDown: (tappDetails) {
            forces[30] = forces[30] - 1;
            finale = forces[30] / 10;
            for (int i = 29; i > 0; i--) {
              if (forces[i + 1] == i) {
                finale = forces[i] / 10;
                forces[i] = forces[i] - 1;
              }
            }
            if (forces[1] == 0) {
              finale = forces[0];
              doThis!();
            }
          },
          child: Card(
            elevation: finale,
            color: Colors.black,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(owo,
                    style: const TextStyle(
                      fontFamily: "Scramble",
                      fontSize: 20,
                      color: Colors.white,
                    ))),
          ),
        );
      });
}

class Content extends StatefulWidget {
  const Content({super.key, required this.texFire});
  final CollectionReference texFire;

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final TextEditingController con = TextEditingController();
  int _eyes = 0;
  int _iHolder = 0;
  String _magic = "Magic",
      _clone = "",
      _hint = "Masukan pesan rahasia kamu di sini....";
  final List<int> _tri = [], _max = [];
  bool _trick = false, _stop = false;

  void didThis() {
    _stop = false;
    if (!_trick && con.text != " " && con.text != "") {
      _hint = "Hold The Button Please";
      _trick = true;
      _clone = con.text;
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

      con.text = "";
    } else {
      if (_hint != "Hold The Button Please") _hint = "Tulis Pesan Dulu...";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    stream: Stream.periodic(const Duration(milliseconds: 100)),
                    builder: (context, snapshot) {
                      return (_trick)
                          ? Container(
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
                                          child: sprringButton(
                                            stopiT: () {
                                              setState(() {
                                                _stop = true;
                                              });
                                            },
                                            doThis: didThis,
                                          )),
                                      Text(
                                        " Selama Setidaknya ${(_eyes - _iHolder).toString()} ",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          : (_hint == "Tulis Pesan Dulu...")
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black54,
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  child: const Text(
                                    "Tulis Pesan Dulu Kaka...",
                                    style: TextStyle(color: Colors.white),
                                  ))
                              : Container();
                    }),
              ],
            ),
          ],
        ),
        Center(
          child: Builder(builder: (context) {
            void comp() {
              if (_clone == _magic) {
                _hint = "Completed";
                _clone = "";
                _trick = false;
                _iHolder = 0;
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
                          Stream.periodic(const Duration(milliseconds: 100)),
                      builder: (context, snapshot) {
                        if (_trick && !_stop) {
                          for (int i = 0; i < _magic.length; i++) {
                            if (_magic[i] != _clone[i]) {
                              int r = 32 + Random().nextInt(94);
                              if (r == 33) {
                                r += 1 + Random().nextInt(93);
                              }
                              if (_tri[i] > _max[i]) {
                                r = _clone.codeUnitAt(i);
                              }
                              _magic = replaceCharAt(
                                  _magic, i, getRandomString(1, r));
                              _tri[i] += 1;
                            }
                          }
                          _iHolder += 1;
                          comp();
                        }
                        return Column(
                          children: [
                            Text(
                              _magic,
                              style: TextStyle(
                                  fontFamily: "Scramble",
                                  fontSize: 100,
                                  shadows: shiro),
                            ),
                            TextField(
                              enabled: !_trick,
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      fontFamily: "Scramble",
                                      color: Colors.white),
                                  labelText: _hint),
                              maxLength: 200,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              onChanged: (val) {},
                              controller: con,
                            ),
                          ],
                        );
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      sprringButton(
                        doThis: didThis,
                        stopiT: () {
                          setState(() {
                            _stop = true;
                          });
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: IconButton(
                            tooltip: "Kirim Pesan Rahasia",
                            onPressed: () async {
                              if (!_trick &&
                                  con.text != " " &&
                                  con.text != "") {
                                String docName = DateTime.now().toString();
                                String fiveLet = "";
                                for (int i = 0; i < 5; i++) {
                                  int r = 65 + Random().nextInt(25);
                                  fiveLet += getRandomString(1, r);
                                }
                                docName += fiveLet;
                                docName = removingSpace(docName);
                                await widget.texFire
                                    .doc(docName)
                                    .set({'text': con.text});
                                showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(20),
                                            height: 200,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      border: Border.all()),
                                                  child: Text(
                                                      "https://ta-fti.web.app/#/msg/$docName"),
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Clipboard.setData(
                                                          ClipboardData(
                                                              text:
                                                                  "https://ta-fti.web.app/#/msg/$docName"));
                                                    },
                                                    child: const Text("Copy"))
                                              ],
                                            ),
                                          ),
                                        ));
                              }
                            },
                            icon: const Icon(Icons.send)),
                      )
                    ],
                  ),
                ],
              )),
            );
          }),
        ),
      ],
    );
  }
}

String replaceCharAt(String oldString, int index, String newChar) =>
    oldString.substring(0, index) + newChar + oldString.substring(index + 1);

String removingSpace(String oldString) {
  for (var i = 0; i < oldString.length; i++) {
    if (oldString[i] == "-" ||
        oldString[i] == " " ||
        oldString[i] == "." ||
        oldString[i] == ":") {
      oldString = oldString.substring(0, i) + oldString.substring(i + 1);
    }
  }
  return oldString;
}

String getRandomString(int length, int r) => String.fromCharCode(r);
