import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ta_uniska_bjm/gg/draw/connect.dart/draw_connect.dart';
import 'package:ta_uniska_bjm/gg/network_kominfo/pages/baru/newaction.dart';
import 'package:ta_uniska_bjm/http/fetching.dart';
import 'package:ta_uniska_bjm/http/videopage_files/video.dart';
import 'dart:ui' as ui;

import 'package:ta_uniska_bjm/utils/widgets/anirotbu.dart';

typedef Tame = void Function();
typedef Pop = void Function(bool x);
typedef Chng = void Function(bool x, int i);
typedef Xtrms = void Function(double i);

class OtherSide extends StatefulWidget {
  const OtherSide({super.key, required this.lebar, required this.chngX});
  final double lebar;
  final Xtrms chngX;

  @override
  State<OtherSide> createState() => _OtherSideState();
}

class _OtherSideState extends State<OtherSide> {
  bool _connect = false, _faceNetwork = false;
  final FocusNode _inIp = FocusNode();
  final TextEditingController _ip = TextEditingController();
  String ipIs = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      color: Colors.amber.shade50,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (!_connect) {
                _faceNetwork = !_faceNetwork;
                setState(() {});
              }
            },
            child: AnimatedSwitcher(
              transitionBuilder: (Widget child, Animation<double> animation) {
                final rotate = Tween(begin: pi, end: 0.0).animate(animation);
                return AniRotBu(rotate: rotate, fronts: true, child: child);
              },
              duration: const Duration(milliseconds: 500),
              child: _faceNetwork
                  ? const SizedBox(
                      key: ValueKey<String>("a"),
                      child: Text(
                        "Network Kominfo",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : const SizedBox(
                      key: ValueKey<String>("b"),
                      child: Text(
                        "Connect Tebak Gambar Game",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              (_connect)
                  ? const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Icon(
                        Icons.verified,
                        color: Colors.green,
                      ),
                    )
                  : const CircularProgressIndicator(),
              SizedBox(
                width: (_connect) ? 15 : 20,
              ),
              SizedBox(
                height: 50,
                width: (widget.lebar - 260 > 0)
                    ? widget.lebar - 260
                    : widget.lebar,
                child: TextField(
                    focusNode: _inIp,
                    style: TextStyle(
                        color: (_connect) ? Colors.green : Colors.black),
                    enabled: (_connect) ? false : true,
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(left: 8, bottom: 30),
                        hintStyle:
                            const TextStyle(height: 3, color: Colors.black26),
                        hintText: "IP",
                        disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    controller: _ip),
              ),
              SizedBox(
                width: _connect ? 10 : 20,
              ),
              ElevatedButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                  if (_connect) {
                    return Colors.red;
                  } else {
                    return Colors.blue;
                  }
                })),
                onPressed: () async {
                  if (!_faceNetwork) {
                    if (!_connect) {
                      if (_ip.text != "") {
                        loading(context);
                        ActionLawsuit(
                                action: (x, y) {
                                  _connect = x;
                                  ipIs = y;
                                  setState(() {});
                                  Navigator.of(context).pop();
                                },
                                heroIsHere: (x) {})
                            .doConnect(_ip, context, _connect);
                      }
                    } else {
                      _connect = false;
                      setState(() {});
                    }
                  } else {
                    if (_ip.text == "video") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VideoNet()));
                    }
                    if (_ip.text == "") {
                      SystemChrome.setEnabledSystemUIMode(
                          SystemUiMode.edgeToEdge);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewAct()));
                    }
                  }
                },
                child: (_connect)
                    ? const Text("Disconnect")
                    : const Text("Connect"),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          if (_connect)
            Expanded(
                child: Container(
              padding: const EdgeInsets.only(left: 25.0, right: 25),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(25)),
              child: Column(children: [
                Row(
                  children: [
                    const Text(
                      "Room List",
                      style: TextStyle(fontSize: 18),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          var gar = TextEditingController();
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Type The Room Name'),
                              content: SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: gar,
                                  decoration: InputDecoration(
                                      hintStyle: const TextStyle(
                                          height: 3, color: Colors.black26),
                                      hintText: "The Name of Your Room",
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.green),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    var token = tokenGen();
                                    var answer = answerGen();
                                    loading(context);
                                    ActionLawsuit(
                                            heroIsHere: (x) {
                                              if (x == 'Sucess') {
                                                Navigator.of(context).pop();
                                                widget.chngX(60);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            DrawConnect(
                                                              ipIs: ipIs,
                                                              roomId: token,
                                                              roomName:
                                                                  gar.text,
                                                              token: token,
                                                              answer: answer,
                                                            ))));
                                              }
                                            },
                                            action: (x, y) {})
                                        .makeRoom(ipIs, token, gar.text, answer,
                                            context);

                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.add, color: Colors.blue))
                  ],
                ),
                roomGen()
              ]),
            ))
        ],
      ),
    );
  }

  Widget roomGen() {
    return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          return FutureBuilder<List?>(
              future: ActionLawsuit(action: (x, y) {}, heroIsHere: (x) {})
                  .getRoom(ipIs, context),
              builder: (context, ss) {
                if (ss.hasError) {
                  return Center(
                    child: Text(ss.toString()),
                  );
                }
                if (ss.hasData) {
                  List<dynamic>? kagi = ss.data;
                  if (kagi!.isEmpty) {
                    return Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: ui.Color.fromARGB(255, 105, 94, 94))
                          ],
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                ui.Color.fromARGB(255, 159, 218, 161),
                                ui.Color.fromARGB(255, 100, 189, 196),
                                ui.Color.fromARGB(255, 115, 168, 218)
                              ]),
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(25)),
                      child: const Center(
                        child: Text(
                          "No Room",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: kagi.length,
                        itemBuilder: (context, i) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color:
                                          ui.Color.fromARGB(255, 105, 94, 94))
                                ],
                                gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      ui.Color.fromARGB(255, 159, 218, 161),
                                      ui.Color.fromARGB(255, 100, 189, 196),
                                      ui.Color.fromARGB(255, 115, 168, 218)
                                    ]),
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  kagi[i]["room_code"],
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      var token = tokenGen();
                                      debugPrint(token);
                                      loading(context);
                                      ActionLawsuit(
                                              heroIsHere: (x) {
                                                if (x == 'Sucess') {
                                                  Navigator.of(context).pop();
                                                  widget.chngX(60);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: ((context) =>
                                                              DrawConnect(
                                                                ipIs: ipIs,
                                                                roomId: kagi[i]
                                                                    ["id"],
                                                                roomName: kagi[
                                                                        i][
                                                                    "room_code"],
                                                                token: token,
                                                                answer: kagi[i]
                                                                    ["answers"],
                                                              ))));
                                                }
                                              },
                                              action: (x, y) {})
                                          .joinRoom(ipIs, token, kagi[i]["id"],
                                              kagi[i]["players"], context);
                                    },
                                    child: const Text("Join"))
                              ],
                            ),
                          );
                        }),
                  );
                }
                return const CircularProgressIndicator();
              });
        });
  }
}

List<CameraDescription> cameras = [];
Future<List<CameraDescription>> getCam() async {
  return cameras = await availableCameras();
}

initializeCamera({required Tame tame}) async {
  await getCam();
  tame();
}

Widget costumSwitch(IconData ico, bool val, Pop K) {
  return GestureDetector(
    onTap: () {
      K(val);
    },
    child: SizedBox(
      height: 30,
      width: 40,
      child: Stack(
        children: [
          Positioned(
            top: 9,
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: 15,
                width: 38,
                decoration: BoxDecoration(
                    color: val ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(50))),
          ),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: 5,
              left: val ? 15 : 0,
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(50),
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: 23,
                    width: 23,
                    decoration: BoxDecoration(
                        color: val ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      ico,
                      color: val ? Colors.white : Colors.blue,
                      size: 10,
                    )),
              )),
        ],
      ),
    ),
  );
}
