import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hidden_city/utils/backend/honeys/urlpath.dart';
import 'package:hidden_city/gg/gallery/gallery.dart';
import 'package:hidden_city/http/videopage_files/editdialog.dart';
import 'package:hidden_city/http/webview.dart';
import 'package:hidden_city/http/videopage_files/fullscreenmode.dart';
import 'package:hidden_city/utils/widgets/scroll_parent.dart';
import 'package:video_player/video_player.dart';

class VideoNet extends StatefulWidget {
  final String request;
  final int active;
  const VideoNet({Key? key, this.request = "http://", this.active = 0})
      : super(key: key);

  @override
  State<VideoNet> createState() => _VideoNetState();
}

class _VideoNetState extends State<VideoNet> {
  VideoPlayerController? _vidCon;
  final TextEditingController _texCon = TextEditingController();
  final TextEditingController _savCon = TextEditingController();
  final TextEditingController _seeCon = TextEditingController();
  final ScrollController _rollcon = ScrollController();
  bool _hide = false, _take = false, _saving = false;
  double _topPos = 0;
  int _active = 0;

  @override
  void initState() {
    _texCon.text = widget.request;
    _vidCon = VideoPlayerController.network(widget.request)
      ..initialize().then((_) {
        setState(() {});
      });
    _active = widget.active;
    if (!Hive.isBoxOpen('urlPaths')) {
      Hive.close();
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_vidCon != null) {
      _vidCon!.dispose();
    }
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    if (_take) {
      _topPos = 0;
    } else {
      _topPos = MediaQuery.of(context).size.height / 2.8;
    }
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: RichText(
            text: const TextSpan(children: [
              TextSpan(text: 'Gunakan Tombol '),
              WidgetSpan(
                  child: Icon(
                Icons.arrow_back,
                size: 14,
                color: Colors.white,
              )),
              TextSpan(text: ' di samping "Network Video" untuk keluar')
            ]),
          )),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back)),
            title: const Text("Network Video")),
        body: Stack(
          children: [
            ListView(children: [
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: _texCon.text));
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const GaleriPage()));
                },
                child: SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 16, right: 5, top: 5, bottom: 5),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.purple),
                        child: const Icon(
                          Icons.photo,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 5),
                      child: TextField(
                        controller: _texCon,
                        decoration: _deco1(),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (con) => VideoNet(
                                  request: _texCon.text,
                                  active: _active,
                                )));
                      },
                      icon: const Icon(Icons.send))
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                child: _vidCon!.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _vidCon!.value.aspectRatio,
                        child: GestureDetector(
                          onTap: () {
                            _hide = !_hide;
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              VideoPlayer(_vidCon!),
                              buildPlay(context, false, _vidCon!, _hide,
                                  func: () {
                                _vidCon!.value.isPlaying
                                    ? _vidCon!.pause()
                                    : _vidCon!.play();
                                _hide = !_hide;
                                setState(() {});
                              }, forw: () async {
                                Duration? newDur = (await _vidCon!.position)! +
                                    const Duration(seconds: 5);
                                _vidCon!.seekTo(newDur);
                                _hide = !_hide;
                                setState(() {});
                              }, rew: () async {
                                Duration? newDur = (await _vidCon!.position)! -
                                    const Duration(seconds: 5);
                                _vidCon!.seekTo(newDur);
                                _hide = !_hide;
                                setState(() {});
                              }),
                              if (_hide)
                                Positioned(
                                  bottom: 20,
                                  left: 70,
                                  right: 40,
                                  child: buildIndicator(_vidCon!),
                                ),
                            ],
                          ),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              const SizedBox(height: 50),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_active == 1) {
                            _active = 0;
                          } else {
                            _active = 1;
                          }
                        });
                      },
                      child: Container(
                        width: 180,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: (_active == 1)
                                ? Colors.lime
                                : Colors.lightGreen),
                        child: const ListTile(
                            leading: Icon(Icons.explore),
                            title: Text("Browser")),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_active == 2) {
                            _active = 0;
                          } else {
                            _active = 2;
                          }
                        });
                      },
                      child: Container(
                        width: 180,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: (_active == 2)
                                ? Colors.lime
                                : Colors.lightGreen),
                        child: const ListTile(
                            leading: Icon(Icons.hive), title: Text("Storage")),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              if (_active == 2)
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 5),
                            child: TextField(
                              controller: _savCon,
                              decoration: _deco1(hint: "Label Name"),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (_texCon.text != "" ||
                                  _texCon.text != "http://" &&
                                      _savCon.text != "") _saving = true;
                            });
                          },
                          child: const Text("SAVE"),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text("Saved Link"),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 5),
                            child: TextField(
                              controller: _seeCon,
                              decoration: _deco1(hint: "Search"),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FutureBuilder(
                        future: Hive.openBox("urlPaths"),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            var urlPaths = Hive.box("urlPaths");
                            if (_saving) {
                              urlPaths.add(UrlPath(_texCon.text, _savCon.text));
                              _saving = false;
                            }
                            return SizedBox(
                                height: 800,
                                child: ScrollParent(
                                  controller: _rollcon,
                                  child: ListView.builder(
                                    controller: _rollcon,
                                    itemCount: urlPaths.length,
                                    itemBuilder: (context, index) {
                                      UrlPath path = urlPaths.getAt(index);
                                      return Container(
                                        padding: const EdgeInsets.all(10),
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  offset: const Offset(3, 3),
                                                  blurRadius: 6)
                                            ]),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (con) =>
                                                                VideoNet(
                                                                  request:
                                                                      path.link,
                                                                  active:
                                                                      _active,
                                                                )));
                                              },
                                              child: SizedBox(
                                                width: 200,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(path.label,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black)),
                                                      Text(
                                                        path.link,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                    icon:
                                                        const Icon(Icons.edit),
                                                    color: Colors.amber,
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            var newLabel =
                                                                TextEditingController();
                                                            var newLink =
                                                                TextEditingController();
                                                            return EditBox(
                                                                index: index,
                                                                newLabel:
                                                                    newLabel,
                                                                newLink:
                                                                    newLink,
                                                                urlPaths:
                                                                    urlPaths);
                                                          });
                                                    }),
                                                IconButton(
                                                    icon: const Icon(
                                                        Icons.delete),
                                                    color: Colors.red,
                                                    onPressed: () {
                                                      urlPaths.deleteAt(index);
                                                      setState(() {});
                                                    })
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ));
                          }
                          return const CircularProgressIndicator();
                        })
                  ]),
                ),
            ]),
            if (_active == 1)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                left: 0,
                top: _topPos,
                child: Container(
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 5,
                          right: 5,
                          child: IconButton(
                            onPressed: () {
                              _active = 0;
                              setState(() {});
                            },
                            icon: const Icon(Icons.close),
                          )),
                      Positioned(
                          top: 5,
                          left: 5,
                          child: IconButton(
                            onPressed: () {
                              _take = !_take;
                              setState(() {});
                            },
                            icon: Icon(_take
                                ? Icons.arrow_drop_down
                                : Icons.arrow_drop_up),
                          )),
                      WebViewShowed(
                        url: widget.request,
                        uriel: (url) {
                          setState(() {
                            _texCon.text = url;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  InputDecoration _deco1({String hint = ""}) => InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.only(left: 8),
      disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(10)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)));
}

Widget buildIndicator(VideoPlayerController vidCon) => VideoProgressIndicator(
      vidCon,
      allowScrubbing: true,
      colors: const VideoProgressColors(playedColor: Colors.blue),
    );

typedef Play = void Function();
Widget buildPlay(BuildContext context, bool full, VideoPlayerController vidCon,
        bool hide,
        {required Play func, required Play forw, required Play rew}) =>
    !hide
        ? Container()
        : Container(
            alignment: Alignment.center,
            color: Colors.black26,
            child: Stack(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 20),
                      GestureDetector(
                          onTap: rew,
                          child: const Icon(Icons.fast_rewind_rounded,
                              color: Colors.white, size: 60)),
                      const Spacer(),
                      GestureDetector(
                          onTap: func,
                          child: Icon(
                              vidCon.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 80)),
                      const Spacer(),
                      GestureDetector(
                          onTap: forw,
                          child: const Icon(Icons.fast_forward_rounded,
                              color: Colors.white, size: 60)),
                      const SizedBox(width: 20)
                    ],
                  ),
                ),
                Positioned(
                  bottom: 3.5,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ValueListenableBuilder(
                        valueListenable: vidCon,
                        builder: (context, VideoPlayerValue value, child) {
                          String time =
                              value.position.toString().substring(0, 7);
                          return Text(
                            time,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          );
                        }),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                      padding: const EdgeInsets.only(right: 5, bottom: 5),
                      child: GestureDetector(
                          onTap: () {
                            if (!full) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullscreenWidget(
                                          controller: vidCon)));
                            } else {
                              SystemChrome.setPreferredOrientations([
                                DeviceOrientation.portraitUp,
                                DeviceOrientation.portraitDown
                              ]);
                              Navigator.pop(context);
                            }
                          },
                          child: const Icon(Icons.fullscreen,
                              color: Colors.white, size: 35))),
                )
              ],
            ),
          );
