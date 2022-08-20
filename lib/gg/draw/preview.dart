import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ta_uniska_bjm/utils/backend/honeys/link.dart';
import 'package:ta_uniska_bjm/utils/widgets/wild_boxes.dart';

class PreviewImg extends StatefulWidget {
  const PreviewImg({super.key, required this.img});
  final Uint8List img;

  @override
  State<PreviewImg> createState() => _PreviewImgState();
}

class _PreviewImgState extends State<PreviewImg> with TickerProviderStateMixin {
  final BorderRadius _rad = BorderRadius.circular(25);
  late AnimationController _aniCon;
  late Animation<double> _animation;
  bool _isFront = true;
  double _horDrag = 0;
  String _boxName = "Link";

  @override
  void initState() {
    _aniCon = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    if (Hive.isBoxOpen('Memimage')) {
      var memimage = Hive.box('Memimage');
      if (memimage.isNotEmpty) {
        memimage.putAt(0, widget.img);
      } else {
        memimage.add(widget.img);
      }
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scfMsg = ScaffoldMessenger.of(context);
    double height = MediaQuery.of(context).size.width;
    double width = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            WildBoxes(height: width, width: height),
            SizedBox(
              child: Column(
                children: [
                  const Expanded(child: Center()),
                  SizedBox(
                    height: 200,
                    child: Center(
                        child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FutureBuilder(
                              future: Hive.openBox(_boxName),
                              builder: (context, snapshot) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    var linkBox = Hive.box(_boxName);
                                    String tittle = await getTextFromDl(
                                            context,
                                            "Masukan Text Untuk Target Copy :",
                                            "Just Enter a Text") ??
                                        'I Love You';
                                    linkBox
                                        .add(Link(tittle, bitImg: widget.img));
                                  },
                                  child: const Text('Save To Link Gallery'),
                                );
                              }),
                          const SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              _boxName = await getTextFromDl(context,
                                      "Masukan Nama Box", "Nama Box") ??
                                  'Link';
                              setState(() {});
                            },
                            child: const Icon(Icons.airplay),
                          )
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            final Map result =
                                await ImageGallerySaver.saveImage(widget.img,
                                    quality: 100);
                            if (result["isSuccess"]) {
                              scfMsg.showSnackBar(const SnackBar(
                                  content: Text("Picture Saved!")));
                            } else {
                              scfMsg.showSnackBar(const SnackBar(
                                  content: Text("Failed To Saved!")));
                            }
                          },
                          child:
                              const Text('Save To Your Phone Gallery as JPG')),
                      ElevatedButton(
                          onPressed: () async {
                            var appDocDir = await getTemporaryDirectory();
                            String savePath =
                                '${appDocDir.path}Art-${DateTime.now()}.png';
                            final file = await File(savePath).create();
                            file.writeAsBytes(widget.img);
                            final Map result =
                                await ImageGallerySaver.saveFile(savePath);

                            if (result["isSuccess"]) {
                              scfMsg.showSnackBar(const SnackBar(
                                  content: Text("Picture Saved!")));
                            } else {
                              scfMsg.showSnackBar(const SnackBar(
                                  content: Text("Failed To Saved!")));
                            }
                          },
                          child:
                              const Text('Save To Your Phone Gallery as PNG'))
                    ])),
                  )
                ],
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onHorizontalDragStart: (details) {
                        _aniCon.reset();
                        setState(() {
                          if (_isFront) {
                            _horDrag = 0;
                          } else {
                            _horDrag = 180;
                          }
                        });
                      },
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          _horDrag -= details.delta.dx;
                          _horDrag %= 360;
                          if (_horDrag < 0) _horDrag *= -1;
                          _setImageSide();
                        });
                      },
                      onHorizontalDragEnd: (d) {
                        double end = 0;
                        if (_horDrag >= 90 && _horDrag <= 180 ||
                            _horDrag >= 180 && _horDrag <= 270) {
                          end = 180;
                        }
                        if (_horDrag >= 270) {
                          end = 360;
                        }
                        _animation = Tween<double>(begin: _horDrag, end: end)
                            .animate(_aniCon)
                          ..addListener(() {
                            setState(() {
                              _horDrag = _animation.value;
                              _setImageSide();
                            });
                          });
                        _aniCon.forward();
                      },
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(_horDrag / 180 * pi),
                        child: _isFront
                            ? _autoContainer(MemoryImage(widget.img), _isFront)
                            : Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()..rotateY(pi),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ClipRRect(
                                    borderRadius: _rad,
                                    child: Stack(
                                      children: [
                                        BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 7.0, sigmaY: 7.0),
                                          child: const SizedBox(
                                            width: 300,
                                            height: 300,
                                            child: Text(""),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: _rad,
                                              border: Border.all(
                                                  color: Colors.white
                                                      .withOpacity(0.2)),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Colors.grey
                                                        .withOpacity(0.4),
                                                    Colors.grey
                                                        .withOpacity(0.2),
                                                  ],
                                                  stops: const [
                                                    0.0,
                                                    1.0
                                                  ])),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                    child: Center(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setImageSide() {
    if (_horDrag <= 90 || _horDrag >= 270) {
      _isFront = true;
    } else {
      _isFront = false;
    }
  }

  Widget _autoContainer(ImageProvider<Object> img, bool isFront) {
    return Container(
      key: ValueKey<bool>(isFront),
      margin: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(fit: BoxFit.cover, image: img)),
    );
  }
}

Future<String?> getTextFromDl(BuildContext context, String text1, String hint) {
  final pass = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              height: 180,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text1,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: pass,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                      ),
                    ),
                    SizedBox(
                      width: 320,
                      child: ElevatedButton(
                        style: ButtonStyle(backgroundColor:
                            MaterialStateProperty.resolveWith(
                                (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.red;
                          }
                          return Colors.lightBlue;
                        })),
                        onPressed: () async {
                          Navigator.pop(context, pass.text);
                        },
                        child: const Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
}
