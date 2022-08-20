import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:ta_uniska_bjm/gg/gallery/secondpage.dart';
import 'package:ta_uniska_bjm/utils/testing/swipedeck/swipe_deck.dart';

import '../../utils/backend/honeys/link.dart';

typedef Func = void Function(String val);
typedef Tall = void Function(int val);

class MainContent extends StatefulWidget {
  const MainContent(
      {super.key, required this.a, required this.b, required this.c});
  final Func b;
  final Tall c;
  final Box<dynamic> a;

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  List<Widget> imagePros = [];
  List<Link> linkie = [];
  bool _stage1 = false, _stage2 = false;
  String c = "";

  @override
  Widget build(BuildContext context) {
    if (linkie.isEmpty) {
      for (int i = 0; i < widget.a.length; i++) {
        linkie.add(widget.a.getAt(i));
      }
    }
    int rand = 0;

    if (imagePros.isEmpty) {
      for (int i = 0; i < linkie.length; i++) {
        imagePros.add(_imagePro(linkie, index: i));
      }
      if (imagePros.isNotEmpty) {
        rand = Random().nextInt(imagePros.length);
      }
    }

    return Stack(
      children: [
        Positioned(
            right: 5,
            top: 5,
            child: IconButton(
              icon: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black38),
                  child: const Icon(
                    Icons.question_mark,
                    color: Colors.white,
                  )),
              onPressed: () {
                _tutor(context);
              },
            )),
        Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Expanded(
            child: SwipeDeck(startIndex: rand, widgets: imagePros),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttonMaterial(context, "Tambah", () {
                setState(() {
                  if (_stage1) {
                    _stage2 = true;
                  }
                  _stage1 = false;
                });
                tambahDialog(context);
              }),
            ],
          ),
          const SizedBox(
            height: 38,
          )
        ]),
        if (_stage1)
          SizedBox.expand(
            child: ClipPath(
              clipper: HelpClipper(false),
              child: Container(
                color: Colors.black38,
                child: Center(
                    child: Text(
                  "Tekan Tombol 'Tambah' \n Untuk Memuat Foto Ke Galeri",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 12.46,
                      color: Colors.white),
                )),
              ),
            ),
          )
      ],
    );
  }

  void _tutor(BuildContext context) {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Tutorial Link Gallery",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Di bawah ini adalah gambar dari Internet : ",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 65,
                      child: Center(
                        child: Image.network(
                            'https://cdn160.picsart.com/upscale-228431809005212.png'),
                      ),
                    ),
                  ),
                  const Text(
                    "Gambar di atas dapat diakses melalui link : https://cdn160.picsart.com/upscale-228431809005212.png \n \n Tekan 'OK' Untuk mencopy linknya!",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  buttonMaterial(context, 'OK', () {
                    Navigator.of(context).pop();

                    setState(() {
                      _stage1 = true;
                    });
                    Clipboard.setData(const ClipboardData(
                        text:
                            'https://cdn160.picsart.com/upscale-228431809005212.png'));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(milliseconds: 500),
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                            "https://cdn160.picsart.com/upscale-228431809005212.png is Copied")));
                  })
                ],
              ),
            ),
          );
        });
  }

  Material buttonMaterial(context, String button, void Function() x) {
    List<Color> warnas = [];
    Color cSplash, cText;
    warnas.addAll([Colors.red, Colors.orange, Colors.amber, Colors.yellow]);
    cSplash = Colors.red;
    cText = Colors.white;

    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 4,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: warnas,
                begin: Alignment.topLeft,
                end: Alignment.centerRight)),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
          child: InkWell(
            splashColor: cSplash,
            borderRadius: BorderRadius.circular(20),
            child: Center(
              child: Text(
                button,
                style: TextStyle(color: cText, fontWeight: FontWeight.w600),
              ),
            ),
            onTap: () {
              x();
            },
          ),
        ),
      ),
    );
  }

  void tambahDialog(context) async {
    TextEditingController controller = TextEditingController();
    var data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text != null) {
      controller.text = data.text!;
      c = controller.text;
    }
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.lightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 380,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Masukan Link",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Link",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        controller: controller,
                        onChanged: (val) {
                          c = val;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 170,
                          child: Center(
                            child: Image.network(c),
                          ),
                        ),
                      ),
                      buttonMaterial(context, "Masukan", () {
                        widget.b(c);
                        Navigator.of(context).pop();
                      }),
                    ],
                  ),
                ),
                if (_stage2)
                  ClipPath(
                    clipper: HelpClipper(true),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black38,
                      ),
                      height: 380,
                      child: Center(
                          child: Text(
                        "Lalu Tekan Tombol 'Masukan' \n Untuk Mensave Foto Ke Galeri ini",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 12.46,
                            color: Colors.white),
                      )),
                    ),
                  )
              ],
            ),
          );
        }).then((value) => setState(() {
          _stage2 = false;
        }));
  }

  SizedBox _page1(Link imagine) {
    var seratus = MediaQuery.of(context).size.width;
    Image tryImage = looking(imagine);
    return SizedBox(
      width: seratus,
      height: seratus,
      child: tryImage,
    );
  }

  Widget _imagePro(List<Link> imagine, {index}) {
    Widget child = _page1(imagine[index]);

    return Hero(
      tag: imagine[index],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SecondPage(
                          imagine,
                          index: index,
                        ))).then((value) {
              if (value != null) {
                if ((value as List)[0]) {
                  widget.c(value[1]);
                }
              }
            });
          },
          child: child,
        ),
      ),
    );
  }

  Image looking(Link imagine) {
    Image tryImage;
    ImageProvider<Object> assets;
    if (imagine.bitImg != null) {
      assets = MemoryImage(imagine.bitImg!);
    } else {
      assets = NetworkImage(imagine.route);
    }
    tryImage = Image(
      image: assets,
      fit: BoxFit.cover,
    );
    return tryImage;
  }
}

class HelpClipper extends CustomClipper<Path> {
  final bool dua;
  HelpClipper(this.dua);

  @override
  Path getClip(Size size) {
    double min = 57;
    if (dua) {
      min = 42;
    }
    return Path.combine(
      PathOperation.difference,
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
      Path()
        ..addRect(Rect.fromCenter(
            center: Offset(size.width / 2, size.height - min),
            width: 210,
            height: 50))
        ..close(),
    );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
