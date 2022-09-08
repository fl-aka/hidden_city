import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hidden_city/gg/draw/drawing/aimer.dart';
import 'package:hidden_city/gg/draw/drawing/future_link_list.dart';
import 'package:hidden_city/gg/draw/drawing/rotating.dart';
import 'package:hidden_city/gg/draw/drawing/theoldpic.dart';
import 'package:hidden_city/utils/testing/cube/cube.dart';
import 'package:tflite/tflite.dart';

import 'package:hidden_city/gg/draw/preview.dart';
import 'package:hidden_city/gg/gallery/zoom_pitch.dart';
import 'package:hidden_city/utils/widgets/anirotbu.dart';
import 'package:hidden_city/utils/widgets/colorpicker.dart';

import 'cameracame.dart';
import 'touch_control.dart';

class Home extends StatefulWidget {
  final Pop pop;
  final Chng chng;
  const Home({Key? key, required this.pop, required this.chng})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey _key = GlobalKey();
  bool _loading = false;
  List<dynamic>? _outputs = [];

  double xOf = 150, yOf = 80;
  late Offset _lastTouchPoint;
  bool _touchDraw = true,
      _hide = false,
      _touchRen = true,
      _reset = false,
      _clean = false,
      _undo = false,
      _redo = false,
      _bg = false,
      _showH = false,
      _scale = false,
      _changeX = false,
      _changeY = false,
      _connectMenu = false,
      _fillStyle = false,
      _posMenupt2 = false,
      _lock = false;
  int _slt = 0, _chs = 0, _podM = 0;
  double _x = 60,
      _xPos = 0,
      _yPos = 0,
      _helperPosX = 0,
      _helperPosY = 0,
      _opiunium = 0.3,
      _ang = 0,
      _opinanium = 0.5,
      _opime = 1,
      heightI = 0,
      _d = 0,
      _heightFive = 0,
      _widthFive = 0,
      _heightLow = 0,
      _widthLow = 0,
      widthI = 0;
  late CameraController _conCam;
  late Future<void> _initConFuture;
  final int _selectedCam = 0;
  final List<File> _capturedImage = [];
  Color _pickerColor = const Color.fromARGB(255, 12, 11, 11);
  Color _currentColor = const ui.Color.fromARGB(255, 12, 11, 11);
  Color _bgCol = Colors.transparent;
  Uint8List? last;

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/ai/firstver.tflite",
      labels: "assets/ai/labels.txt",
    );
  }

  Future<void> _classifyImage(Uint8List image) async {
    _outputs = null;
    var appDocDir = await getTemporaryDirectory();
    String savePath = '${appDocDir.path}temp.png';
    final file = await File(savePath).create();
    await file.writeAsBytes(image);
    var output = await Tflite.runModelOnImage(
      path: file.path,
      numResults: 3,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  void changeColor(Color color) {
    if (_touchRen) {
      setState(() => _currentColor = color);
    } else {
      setState(() => _bgCol = color);
    }
  }

  Future pickImage(BuildContext context) async {
    try {
      final imageP = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxHeight: 1080, maxWidth: 720);
      if (imageP == null) return;

      final imageTempo = File(imageP.path);
      setState(() {
        _capturedImage.add(imageTempo);
      });
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to Pick Image : $e")));
    }
  }

  Future<void> _getLast() async {
    RenderRepaintBoundary boundary =
        _key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 2);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      last = byteData.buffer.asUint8List();
    }
  }

  void _takeScreenshot(
      {required scfNav, required scfMsg, bool longP = false}) async {
    RenderRepaintBoundary boundary =
        _key.currentContext!.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage(pixelRatio: 2);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      Uint8List pngBytes = byteData.buffer.asUint8List();

      if (longP) {
        // Saving the screenshot to the gallery
        var appDocDir = await getTemporaryDirectory();
        String savePath = '${appDocDir.path}Art-${DateTime.now()}.png';
        final file = await File(savePath).create();
        file.writeAsBytes(pngBytes);
        final Map result = await ImageGallerySaver.saveFile(savePath);

        if (result["isSuccess"]) {
          scfMsg.showSnackBar(const SnackBar(content: Text("Picture Saved!")));
        } else {
          scfMsg
              .showSnackBar(const SnackBar(content: Text("Failed To Saved!")));
        }
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        scfNav.push(MaterialPageRoute(
            builder: (context) => PreviewImg(
                  img: pngBytes,
                )));
      }
    }
    setState(() {});
  }

  Future<List<int>> _getImageHeight(File x) async {
    var y = await decodeImageFromList(x.readAsBytesSync());
    List<int> z = [];
    z.add(y.height);
    z.add(y.width);

    return z;
  }

  @override
  void initState() {
    initializeCamera(
      tame: () {
        _conCam =
            CameraController(cameras[_selectedCam], ResolutionPreset.high);
        _initConFuture = _conCam.initialize();
      },
    );
    _chs = _slt;
    _touchDraw = true;
    _loading = true;
    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _conCam.dispose();
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    double tinggi = MediaQuery.of(context).size.height;

    var scfMsg = ScaffoldMessenger.of(context);
    var scfNav = Navigator.of(context);

    return WillPopScope(
      onWillPop: _onbackPressed,
      child: Stack(
        children: [
          RepaintBoundary(
              key: _key,
              child: Stack(children: [
                Container(
                  height: tinggi,
                  width: lebar,
                  color: _bgCol,
                ),
                //BG IMG
                if (_opime > 0)
                  Opacity(
                    opacity: _opime,
                    child: PinchZoom(
                      tooBig: (x) {},
                      tooSmall: (x) {},
                      child: OldPic(
                          clean: _clean,
                          memory: last,
                          x: () {
                            _clean = false;
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {});
                            });
                          }),
                    ),
                  ),
                if (_capturedImage.length > _slt && _bg)
                  Positioned(
                      top: _yPos,
                      left: _xPos,
                      child: Container(
                        height: heightI,
                        width: widthI,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: _capturedImage.length > _slt && _bg
                              ? DecorationImage(
                                  image: FileImage(_capturedImage[_slt]),
                                  fit: BoxFit.fill,
                                  opacity: _opiunium)
                              : null,
                        ),
                      )),
                //CostumPaint
                IgnorePointer(
                  ignoring: !_touchRen,
                  child: Container(
                    width: lebar,
                    height: tinggi,
                    color: Colors.transparent,
                    child: Center(
                        child: TouchControl(
                      touchDraw: _touchDraw,
                      selCol: _currentColor,
                      oldPic: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _getLast();
                          setState(() {});
                        });
                      },
                      redo: (x) {
                        _redo = x;
                        _lock = false;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _getLast();
                          setState(() {});
                        });
                      },
                      reded: _redo,
                      undo: (x) {
                        _undo = x;
                        _lock = false;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _getLast();
                          setState(() {});
                        });
                      },
                      undoed: _undo,
                      reseted: _reset,
                      reset: (x) {
                        _lock = false;
                        _reset = x;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {});
                        });
                      },
                      xY: (x, y) {
                        //_getLast();
                        xOf = x;
                        yOf = y;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {});
                        });
                      },
                      xOf: xOf,
                      yOf: yOf,
                      fillStyle: _fillStyle,
                    )),
                  ),
                ),
                if (_capturedImage.length > _slt && _bg && !_touchRen)
                  Positioned(
                      top: _yPos - 25,
                      left: _xPos - 25,
                      child: GestureDetector(
                          onPanStart: (details) {
                            _lastTouchPoint = Offset(details.globalPosition.dx,
                                details.globalPosition.dy);
                            _helperPosX = _xPos - details.globalPosition.dx;
                            _helperPosY = _yPos - details.globalPosition.dy;
                            setState(() {});
                          },
                          onPanUpdate: (details) {
                            if ((details.globalPosition.dx -
                                            _lastTouchPoint.dx >
                                        50 ||
                                    details.globalPosition.dx -
                                            _lastTouchPoint.dx <
                                        -50) ||
                                (details.globalPosition.dy -
                                            _lastTouchPoint.dy >
                                        50 ||
                                    details.globalPosition.dy -
                                            _lastTouchPoint.dy <
                                        -50)) {
                              _xPos = _helperPosX + details.globalPosition.dx;
                              _yPos = _helperPosY + details.globalPosition.dy;
                            }
                            setState(() {});
                          },
                          child: Container(
                            height: heightI + 50,
                            width: widthI + 50,
                            color: const Color.fromARGB(0, 58, 38, 38),
                          )))
              ])),
          if (_hide &&
              _podM == 1 &&
              _bgCol == const Color(0xffffffff) &&
              _pickerColor == const Color(0xffff0000))
            Positioned(
                bottom: 50,
                left: 0,
                child: GestureDetector(
                  onTap: () {
                    widget.chng(true, 0);
                  },
                  child: Container(
                    height: 20,
                    width: 50,
                    color: const Color.fromARGB(0, 0, 0, 0),
                  ),
                )),
          if (_hide &&
              _bgCol == const Color(0xffff0000) &&
              _pickerColor == const Color(0xffffffff) &&
              _lock)
            Positioned(
                top: 50,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    _lock = true;
                  },
                  child: Container(
                    height: 20,
                    width: 50,
                    color: const Color.fromARGB(0, 0, 0, 0),
                  ),
                )),
          Aimer(
            touchDraw: _touchDraw,
            hide: (x) {
              _hide = x;
              if (_hide) {
                _x = -100;
              }
              if (!_hide) {
                _x = 60;
              }
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {});
              });
            },
            xOf: xOf,
            yOf: yOf,
            odds: () {
              yOf = 25;
              xOf = 0;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {});
              });
            },
          ),
          //Pos Menu
          AnimatedPositioned(
            bottom: posR("btm", _podM, tinggi, lebar, _hide),
            right: posR("rgt", _podM, tinggi, lebar, _hide),
            duration: const Duration(milliseconds: 500),
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  if (details.delta.dx > 5) {
                    if (_podM == 2) {
                      _podM = 0;
                      return;
                    }
                    if (_podM == 3) {
                      _podM = 1;
                      return;
                    }
                  }
                  if (details.delta.dx < -5) {
                    if (_podM == 0) {
                      _podM = 2;
                      return;
                    }
                    if (_podM == 1) {
                      _podM = 3;
                      return;
                    }
                  }
                  if (details.delta.dy > 5) {
                    if (_podM == 1) {
                      _podM = 0;
                      return;
                    }
                    if (_podM == 3) {
                      _podM = 2;
                      return;
                    }
                  }
                  if (details.delta.dy < -5) {
                    if (_podM == 0) {
                      _podM = 1;
                      return;
                    }
                    if (_podM == 2) {
                      _podM = 3;
                      return;
                    }
                  }
                });
              },
              child: SizedBox(
                height: 360,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(50),
                        child: GestureDetector(
                          child: Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Icon(Icons.question_mark,
                                  color: Colors.white)),
                          onTap: () {
                            if (!_loading && last != null) {
                              _classifyImage(last!).then((value) {
                                if (_outputs != null) {
                                  _showMyDialog(_outputs!);
                                  if (_outputs![0]['label'] == '1 Square' &&
                                      _outputs![0]['confidence'] > 0.6) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const RubicExe())));
                                    return;
                                  }
                                }
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    RotatingCircle(onTap: () {
                      setState(() {
                        _posMenupt2 = !_posMenupt2;
                      });
                    }),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 800),
                      transitionBuilder: (child, animation) {
                        final tween = Tween<Offset>(
                                begin: const Offset(0, -1),
                                end: const Offset(0, 0))
                            .animate(animation);
                        return ClipRect(
                          child: SlideTransition(
                            position: tween,
                            child: child,
                          ),
                        );
                      },
                      child: _posMenupt2
                          ? SizedBox(
                              key: const ValueKey(0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
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
                                            child: Icon(Icons.draw,
                                                color: _touchDraw
                                                    ? Colors.white
                                                    : Colors.red)),
                                        onTap: () {
                                          setState(() {
                                            _touchDraw = !_touchDraw;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
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
                                            child: Icon(
                                                _fillStyle
                                                    ? Icons.square
                                                    : Icons.square_outlined,
                                                color: Colors.white)),
                                        onTap: () {
                                          setState(() {
                                            _fillStyle = !_fillStyle;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
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
                                            child: const Icon(Icons.podcasts,
                                                color: Colors.white)),
                                        onTap: () {},
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                          : SizedBox(
                              key: const ValueKey(1),
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
                                            child: const Icon(
                                                Icons
                                                    .cleaning_services_outlined,
                                                color: Colors.white)),
                                      ),
                                      onTap: () {
                                        _reset = true;
                                        _clean = true;
                                        xOf = 150;
                                        yOf = 80;
                                        last = null;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ],
                              )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //HP IN HP
          AnimatedPositioned(
              top: (_capturedImage.length > _slt && _bg)
                  ? tinggi - _x - 50
                  : tinggi - _x,
              left: 20,
              duration: const Duration(milliseconds: 500),
              child: Column(
                children: [
                  if (_capturedImage.length > _slt && _bg)
                    Opacity(
                      opacity: _opinanium,
                      child: GestureDetector(
                        onTap: () {
                          if (!_changeX && !_changeY && !_scale) {
                            _changeX = false;
                            _changeY = false;
                            _scale = true;

                            setState(() {});
                            return;
                          }
                          if (!_changeX && !_changeY && _scale) {
                            _changeX = true;
                            _changeY = false;
                            _scale = false;

                            setState(() {});
                            return;
                          }
                          if (_changeX && !_changeY && !_scale) {
                            _changeX = false;
                            _changeY = true;
                            _scale = false;

                            setState(() {});
                            return;
                          }
                          if (!_changeX && _changeY && !_scale) {
                            _changeX = false;
                            _changeY = false;
                            _scale = false;
                            setState(() {});
                            return;
                          }
                        },
                        child: Row(
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                final rotate = Tween(begin: pi, end: 0.0)
                                    .animate(animation);
                                return AniRotBu(
                                    rotate: rotate, fronts: true, child: child);
                              },
                              child: _changeX
                                  ? const Icon(FontAwesomeIcons.arrowsUpDown,
                                      key: ValueKey<String>("b"),
                                      color: Colors.blue,
                                      size: 30)
                                  : _changeY
                                      ? const Icon(
                                          FontAwesomeIcons.arrowsLeftRight,
                                          key: ValueKey<String>("c"),
                                          color: Colors.blue,
                                          size: 30)
                                      : _scale
                                          ? const Icon(
                                              FontAwesomeIcons
                                                  .arrowUpRightFromSquare,
                                              key: ValueKey<String>("d"),
                                              color: Colors.blue,
                                              size: 30)
                                          : const Icon(Icons.remove_red_eye,
                                              key: ValueKey<String>("a"),
                                              color: Colors.blue,
                                              size: 30),
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                final rotate = Tween(begin: pi, end: 0.0)
                                    .animate(animation);
                                return AniRotBu(
                                    rotate: rotate, fronts: true, child: child);
                              },
                              child: _changeX
                                  ? Slider(
                                      key: const ValueKey<String>("a"),
                                      onChangeStart: (value) {
                                        _opinanium = 1;
                                        setState(() {});
                                      },
                                      onChangeEnd: (_) {
                                        _opinanium = 0.3;
                                        _newHeight();
                                        setState(() {});
                                      },
                                      min: _heightLow,
                                      max: _heightFive,
                                      value: heightI,
                                      onChanged: (val) {
                                        heightI = val;
                                        _d = heightI / widthI;
                                        setState(() {});
                                      })
                                  : _changeY
                                      ? Slider(
                                          key: const ValueKey<String>("b"),
                                          onChangeStart: (value) {
                                            _opinanium = 1;
                                            setState(() {});
                                          },
                                          onChangeEnd: (_) {
                                            _opinanium = 0.3;
                                            _newHeight();
                                            setState(() {});
                                          },
                                          min: _widthLow,
                                          max: _widthFive,
                                          value: widthI,
                                          onChanged: (val) {
                                            widthI = val;
                                            _d = heightI / widthI;
                                            setState(() {});
                                          })
                                      : _scale
                                          ? Slider(
                                              key: const ValueKey<String>("c"),
                                              onChangeStart: (value) {
                                                _opinanium = 1;
                                                setState(() {});
                                              },
                                              onChangeEnd: (_) {
                                                _opinanium = 0.3;
                                                _newHeight();
                                                setState(() {});
                                              },
                                              min: _heightLow,
                                              max: _heightFive,
                                              value: heightI,
                                              onChanged: (val) {
                                                widthI = val / _d;
                                                heightI = val;
                                                if (widthI < 0) {
                                                  widthI = 0;
                                                }

                                                setState(() {});
                                              })
                                          : Slider(
                                              onChangeStart: (value) {
                                                _opinanium = 1;
                                                setState(() {});
                                              },
                                              onChangeEnd: (_) {
                                                _opinanium = 0.3;
                                                setState(() {});
                                              },
                                              min: 0,
                                              max: 1,
                                              value: _opiunium,
                                              onChanged: (val) {
                                                _opiunium = val;
                                                setState(() {});
                                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Container(
                    height: tinggi,
                    width: (lebar > 40) ? lebar - 40 : lebar,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(2, -3), color: Colors.black26),
                          BoxShadow(
                              offset: Offset(-2, -3), color: Colors.black26),
                          BoxShadow(
                              offset: Offset(2, 3), color: Colors.black26),
                          BoxShadow(
                              offset: Offset(-2, 3), color: Colors.black26)
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 28, right: 28),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 60,
                                child: Column(
                                  children: [
                                    costumSwitch(Icons.photo, _bg, (x) async {
                                      _getLast();
                                      _bg = !_bg;
                                      if (_capturedImage.isNotEmpty) {
                                        try {
                                          if (heightI == 0 && widthI == 0) {
                                            _xPos = 0;
                                            _yPos = 0;
                                            List<int> a = await _getImageHeight(
                                                _capturedImage[_slt]);
                                            heightI =
                                                double.parse(a[0].toString());
                                            widthI =
                                                double.parse(a[1].toString());
                                            _d = heightI / widthI;

                                            if (widthI > lebar) {
                                              double minus = widthI - lebar;
                                              if (minus < widthI) {
                                                widthI = widthI - minus;
                                                heightI = widthI * _d;
                                              }
                                            }
                                            if (heightI > tinggi) {
                                              double minus = heightI - tinggi;
                                              if (minus < heightI) {
                                                heightI = heightI - minus;
                                                widthI = heightI / _d;
                                              }
                                            }

                                            _newHeight();
                                          }
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text("Failed : $e")));
                                        }
                                      }

                                      setState(() {});
                                    }),
                                    costumSwitch(
                                        FontAwesomeIcons.arrowsUpDownLeftRight,
                                        !_touchRen, (x) {
                                      _touchRen = !_touchRen;
                                      setState(() {});
                                    }),
                                  ],
                                ),
                              ),
                              Stack(
                                children: [
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      colorChooser(context,
                                          _touchRen ? _currentColor : _bgCol,
                                          col: (x) {
                                        if (_touchRen) {
                                          setState(() => _pickerColor = _bgCol);
                                        } else {
                                          setState(() =>
                                              _pickerColor = _currentColor);
                                        }
                                      }, changeColor: changeColor),
                                      SizedBox(
                                        child: Column(children: [
                                          GestureDetector(
                                            onTap: () {
                                              chooseCol(context, _bgCol, (x) {
                                                setState(() => _bgCol = x);
                                              }, (x) {
                                                setState(() =>
                                                    _pickerColor = _bgCol);
                                              }, a: last, getLast: _getLast());
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              color: Colors.transparent,
                                              child: Row(
                                                children: [
                                                  const Text('BG : ',
                                                      style: TextStyle(
                                                          fontSize: 10)),
                                                  Container(
                                                    height: 8,
                                                    width: 8,
                                                    decoration: BoxDecoration(
                                                        color: _bgCol,
                                                        border: Border.all(
                                                            width: 0.2)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              chooseCol(context, _currentColor,
                                                  (x) {
                                                setState(
                                                    () => _currentColor = x);
                                              }, (x) {
                                                setState(() => _pickerColor =
                                                    _currentColor);
                                              }, a: last, getLast: _getLast());
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              color: Colors.transparent,
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    'Line : ',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  Container(
                                                    height: 8,
                                                    width: 8,
                                                    decoration: BoxDecoration(
                                                        color: _currentColor,
                                                        border: Border.all(
                                                            width: 0.2)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: GestureDetector(
                                  onTap: () => _takeScreenshot(
                                      scfMsg: scfMsg, scfNav: scfNav),
                                  onLongPress: () => _takeScreenshot(
                                      longP: true,
                                      scfMsg: scfMsg,
                                      scfNav: scfNav),
                                  child: const Icon(
                                    Icons.save,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_x == 60) {
                                    double krg = 60;
                                    if (tinggi < 641) {
                                      krg = 70;
                                    }
                                    _x = tinggi - krg;
                                    widget.pop(false);
                                  } else {
                                    _x = 60;
                                    widget.pop(true);
                                  }
                                  setState(() {});
                                },
                                child: StreamBuilder(
                                    builder: ((context, snapshot) {
                                      if (_x != 60 && _ang < pi) {
                                        _ang += 0.3;
                                      }
                                      if (_ang > pi && _x != 60) {
                                        _ang = pi;
                                      }
                                      if (_x == 60 && _ang >= pi) {
                                        _ang += 0.3;
                                      }
                                      if (_ang > 2 * pi) {
                                        _ang = 0;
                                      }
                                      return Transform.rotate(
                                        angle: _ang,
                                        child: const Icon(
                                          Icons.keyboard_double_arrow_up,
                                          size: 45,
                                          color: Colors.blue,
                                        ),
                                      );
                                    }),
                                    stream: Stream.periodic(
                                        const Duration(milliseconds: 50))),
                              ),
                            ],
                          ),
                        ),
                        if (_x != 60)
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SizedBox(
                                height: tinggi - 230,
                                child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 500),
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
                                      final rotate = Tween(begin: pi, end: 0.0)
                                          .animate(animation);
                                      return AniRotBu(
                                          rotate: rotate,
                                          fronts: true,
                                          child: child);
                                    },
                                    child: (!_connectMenu)
                                        ? FutureBuilder<void>(
                                            future: _initConFuture,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                // If the Future is complete, display the preview.
                                                return CameraPreview(_conCam);
                                              } else {
                                                // Otherwise, display a loading indicator.
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }
                                            },
                                          )
                                        : OtherSide(
                                            lebar: lebar,
                                            chngX: (val) {
                                              _x = val;
                                              setState(() {});
                                            },
                                          ))),
                          ),
                        if (_x != 60)
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        _showH = true;
                                        widget.pop(false);
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.blue, width: 0.5),
                                          image: _capturedImage.isNotEmpty
                                              ? DecorationImage(
                                                  image: FileImage(
                                                      _capturedImage.last),
                                                  fit: BoxFit.cover)
                                              : null,
                                        ),
                                        child: _capturedImage.isNotEmpty
                                            ? null
                                            : const Center(
                                                child: Text(
                                                "None",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              )),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    height: 80,
                                    width: 80,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black26),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Color.fromARGB(255, 86, 72, 212)),
                                      child: GestureDetector(
                                        onTap: () async {
                                          await _initConFuture; //To make sure camera is initialized
                                          var xFile =
                                              await _conCam.takePicture();
                                          if (kIsWeb) {
                                          } else if (Platform.isAndroid) {
                                            setState(() {
                                              _capturedImage
                                                  .add(File(xFile.path));
                                            });
                                          }
                                          if (_capturedImage.length == _slt &&
                                              _bg) {
                                            try {
                                              _xPos = 0;
                                              _yPos = 0;
                                              List<int> a =
                                                  await _getImageHeight(
                                                      _capturedImage[_slt]);
                                              heightI =
                                                  double.parse(a[0].toString());
                                              widthI =
                                                  double.parse(a[1].toString());
                                              _d = heightI / widthI;
                                              _newHeight();
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content:
                                                          Text("Failed : $e")));
                                            }
                                          }
                                          setState(() {});
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Wrap(children: [
                                    IconButton(
                                        onPressed: () {
                                          _connectMenu = !_connectMenu;
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                          FontAwesomeIcons.internetExplorer,
                                          color: Colors.blue,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          pickImage(context);
                                        },
                                        icon: const Icon(
                                          Icons.folder,
                                          color: Colors.blue,
                                        )),
                                  ])
                                ]),
                          )
                      ],
                    ),
                  ),
                ],
              )),
          if (_showH)
            Positioned(top: 75, left: 35, child: _rollDialog(tinggi, lebar))
        ],
      ),
    );
  }

  void _newHeight() {
    _heightFive = heightI + 200;
    _heightLow = heightI - 200;
    if (_heightLow < 0) {
      _heightLow = 0;
    }
    _widthFive = widthI + 200;
    _widthLow = widthI - 200;
    if (_widthLow < 0) {
      _widthLow = 0;
    }
  }

  Widget _rollDialog(double tinggi, double lebar) {
    double devided = (tinggi > 200) ? tinggi - 150 : tinggi;
    return Material(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: devided,
        width: lebar - 100,
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: devided - 110,
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                children: [
                  for (int i = 0; i < _capturedImage.length; i++)
                    GestureDetector(
                        onTap: () {
                          _chs = i;
                          setState(() {});
                        },
                        child: Container(
                            color: i == _chs ? Colors.blue : Colors.white,
                            padding: const EdgeInsets.all(5),
                            child: Image.file(_capturedImage[i],
                                fit: BoxFit.cover)))
                ],
              ),
            ),
            SizedBox(
                height: 35,
                child: ListFromLink(
                  changeOld: ((x) {
                    last = x;
                    setState(() {});
                  }),
                  current: last,
                )),
            SizedBox(
              height: 25,
              child: Slider(
                  value: _opime,
                  min: 0,
                  max: 1,
                  onChanged: (val) {
                    _opime = val;
                    setState(() {});
                  }),
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        _capturedImage.clear();
                        _chs = _slt;
                        _showH = false;
                        widget.pop(true);
                        setState(() {});
                      },
                      child: const Text(
                        "Clear",
                        style: TextStyle(fontSize: 18),
                      )),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        _chs = _slt;
                        _showH = false;
                        widget.pop(true);
                        setState(() {});
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 18),
                      )),
                  TextButton(
                      onPressed: () async {
                        _slt = _chs;
                        _showH = false;

                        setState(() {});
                        widget.pop(true);
                      },
                      child: const Text(
                        "Ok",
                        style: TextStyle(fontSize: 18),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMyDialog(List<dynamic> theOutputs) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 310,
                child: Column(children: [
                  for (int i = 0; i < theOutputs.length; i++)
                    Text(
                        "${theOutputs[i]['label']} - ${theOutputs[i]['confidence'].toStringAsFixed(2)}")
                ]),
              ));
        });
  }

  Future<bool> _onbackPressed() async {
    if (_showH) {
      _showH = false;
      if (_x == 60) {
        widget.pop(true);
      }
      setState(() {});
      return false;
    } else if (_x != 60) {
      _x = 60;
      setState(() {});
      widget.pop(true);
      return false;
    } else {
      return true;
    }
  }
}
