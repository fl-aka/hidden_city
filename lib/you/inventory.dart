import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ta_uniska_bjm/gg/hubworld/crystalmenu.dart';
import 'package:ta_uniska_bjm/utils/backend/honeys/card.dart';
import 'package:ta_uniska_bjm/utils/widgets/floatingtext.dart';
import 'package:ta_uniska_bjm/you/addcard.dart';
import 'package:ta_uniska_bjm/you/tools/staticcard.dart';
import 'package:url_launcher/url_launcher.dart';

import '../gg/draw/preview.dart';
import '../gg/network_kominfo/widgetsutils/spcbutton.dart';

class Inventory extends StatefulWidget {
  final FractionalOffset center;
  const Inventory({super.key, required this.center});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            LayoutBuilder(
                builder: (context, consts) => TweenAnimationBuilder(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 1500),
                      builder: (context, double value, child) => ShaderMask(
                          shaderCallback: (rect) => RadialGradient(
                                  radius: value * 5,
                                  colors: const [
                                    Colors.white,
                                    Colors.white,
                                    Colors.transparent,
                                    Colors.transparent,
                                  ],
                                  stops: const [0.0, 0.55, 0.6, 1.0],
                                  center: widget.center)
                              .createShader(rect),
                          child: child),
                      child: const InventoryContent(),
                    )),
            Positioned(
              right: -50,
              bottom: -50,
              child: Hero(
                tag: "PP",
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
                  },
                  child: ClipPath(
                    clipper: DiamondClipper(),
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        color: const Color.fromARGB(255, 194, 46, 46),
                        height: 180,
                        width: 180,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: ClipPath(
                                clipper: DiamondClipper(),
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(user.photoURL!))),
                                ),
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
        ));
  }
}

class InventoryContent extends StatefulWidget {
  const InventoryContent({super.key});

  @override
  State<InventoryContent> createState() => _InventoryContentState();
}

class _InventoryContentState extends State<InventoryContent> {
  final BorderRadius _rad = BorderRadius.circular(25);
  List<Cards> mechaine = [];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    debugPrint('$height');
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
              Color.fromARGB(80, 243, 33, 33),
              Color.fromARGB(110, 255, 94, 0)
            ])),
          ),
        ),
        SizedBox(
          height: height,
          width: width,
          child: ListView(
            children: [
              SizedBox(
                height: height + 100,
                width: width,
                child: Stack(children: [
                  const FloatingText(
                    key: ValueKey(0),
                    unevolved: "Materialistic",
                    evolved: "~hateful~",
                    subText: "You'll Just Never Get Enough!",
                    tittle: 'In This ',
                    tittleAfter: ' World',
                  ),
                  Positioned(
                      top: 75,
                      left: 0,
                      child: SizedBox(
                          width: width,
                          height: width / 1.8,
                          child: const TuningWizard())),
                  Positioned(
                    top: width / 2 + 100,
                    left: 15,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {});
                          },
                          child: ClipRRect(
                            borderRadius: _rad,
                            child: Stack(
                              children: [
                                BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 7.0, sigmaY: 7.0),
                                  child: SizedBox(
                                    width: width - 30,
                                    child: const Text(""),
                                  ),
                                ),
                                Container(
                                  width: width - 30,
                                  height: height / 1.85,
                                  decoration: BoxDecoration(
                                      borderRadius: _rad,
                                      border: Border.all(
                                          color: Colors.white.withOpacity(0.2)),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.grey.withOpacity(0.4),
                                            Colors.grey.withOpacity(0.2),
                                          ],
                                          stops: const [
                                            0.0,
                                            1.0
                                          ])),
                                  child: const StaticCard(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
        Positioned(
            bottom: 5,
            left: 0,
            child: SizedBox(
                height: 65,
                width: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    iconCon('History', Icons.calendar_month_rounded),
                    iconCon('Desire', Icons.check),
                    iconCon('Trade', FontAwesomeIcons.userGroup)
                  ],
                )))
      ],
    );
  }

  Container iconCon(String text, IconData ico) {
    return Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        width: 55,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(offset: Offset(2, 2), color: Colors.black26)
          ],
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              ico,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(height: 5),
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ));
  }
}

class TuningWizard extends StatefulWidget {
  const TuningWizard({
    super.key,
  });

  @override
  State<TuningWizard> createState() => _TuningWizardState();
}

class _TuningWizardState extends State<TuningWizard>
    with TickerProviderStateMixin {
  final BorderRadius _rad = BorderRadius.circular(25);
  late AnimationController _aniCon;
  late Animation<double> _animation;
  bool _isFront = true, _already = false;
  double _horDrag = 0;
  int setof = 0, inside = 0, insideN = 1;
  List<Cards> mechaine = [];

  @override
  void initState() {
    _aniCon = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _aniCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var max = Hive.box('MoneyCards');
    mechaine.clear();
    for (var i = 0; i < max.length; i++) {
      mechaine.add(max.getAt(i));
    }

    return GestureDetector(
      onHorizontalDragStart: (details) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
        _aniCon.reset();
        setState(() {
          _horDrag = 0;
        });
      },
      onHorizontalDragUpdate: (details) {
        setState(() {
          _already = false;
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
        _animation = Tween<double>(begin: _horDrag, end: end).animate(_aniCon)
          ..addListener(() {
            setState(() {
              _horDrag = _animation.value;
              if (end == 180) {
                _horDrag = -(180 - _animation.value);
              }
              if (!_isFront && !_already) {
                if (inside < max.length) {
                  inside++;
                } else {
                  inside = 0;
                }
                if (insideN < max.length) {
                  insideN++;
                } else {
                  insideN = 0;
                }
                if (setof < 6) {
                  setof++;
                } else {
                  setof = 0;
                }
                _isFront = true;
                _already = true;
              }
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
            ? Container(
                margin: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(borderRadius: _rad, color: set1[setof]),
                child: _inside(mechaine, inside, setof))
            : Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateY(pi),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(borderRadius: _rad, color: set1[setof + 1]),
                  child: _inside(mechaine, insideN, setof + 1),
                ),
              ),
      ),
    );
  }

  Widget _inside(List<Cards> mechaine, int q, int setQ) {
    const TextStyle namaKartu = TextStyle(
      fontSize: 30,
      color: Colors.white,
    );
    TextStyle dataSaldo({bool blue = false}) => TextStyle(
          fontSize: blue ? 18 : 15,
          color: blue
              ? setQ == 4
                  ? Colors.lightBlue
                  : Colors.indigo
              : Colors.white,
        );

    if (mechaine.length > q) {
      var tempBox = Hive.box('MoneyCards');
      var tempHis = Hive.box('MoneyHistory');
      String curName = mechaine[q].name;
      Uint8List? curLogo = mechaine[q].logo;
      double curSaldo = mechaine[q].saldo;
      bool curBoolPay = mechaine[q].isPaylater;
      double curPay = mechaine[q].paylater;
      double curPayMax = mechaine[q].maxPaylater;
      String curWeb = mechaine[q].website;
      DateTime oldTime = mechaine[q].forHis;
      List<dynamic> meta = [];
      f = curLogo;
      meta = tempHis.getAt(q);

      return Stack(
        children: [
          Positioned(
              top: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 230,
                    height: 80,
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          String newName = await getTextFromDl(
                                context,
                                "Update Nama Kartu",
                                'Masukan Nama Kartu Sekarang',
                                pretext: curName,
                              ) ??
                              curName;
                          tempBox.putAt(
                              q,
                              Cards(newName, curLogo, curSaldo, curBoolPay,
                                  curPay, curPayMax, curWeb, oldTime));
                          SystemChrome.setEnabledSystemUIMode(
                              SystemUiMode.immersive);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text("Something Wrong...")));
                        }
                        setState(() {});
                      },
                      child: Text(
                        curName,
                        style: namaKartu,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        String tempSal = await getTextFromDl(context,
                                "Update Saldo", 'Masukan Saldo Sekarang',
                                pretext: '$curSaldo',
                                mode: TextInputType.number) ??
                            curSaldo.toString();
                        double newSald = double.parse(tempSal);
                        Cards newCards = Cards(
                            curName,
                            curLogo,
                            newSald,
                            curBoolPay,
                            curPay,
                            curPayMax,
                            curWeb,
                            DateTime.now());

                        tempBox.putAt(q, newCards);
                        meta.add(newCards);
                        tempHis.putAt(q, meta);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text("Something Wrong...")));
                      }
                      SystemChrome.setEnabledSystemUIMode(
                          SystemUiMode.immersive);
                      _send();
                    },
                    child: Text(
                      "Jumlah Saldo : Rp $curSaldo",
                      style: dataSaldo(),
                    ),
                  ),
                  if (mechaine[q].isPaylater)
                    GestureDetector(
                      onTap: () async {
                        try {
                          String tempSal = await getTextFromDl(
                                  context,
                                  "Update Used Paylater",
                                  'Masukan Kredit Sekarang',
                                  pretext: '$curPay',
                                  mode: TextInputType.number) ??
                              curPay.toString();
                          double newPay = double.parse(tempSal);
                          Cards newCard = Cards(
                              curName,
                              curLogo,
                              curSaldo,
                              curBoolPay,
                              newPay,
                              curPayMax,
                              curWeb,
                              DateTime.now());
                          tempBox.putAt(q, newCard);
                          tempHis.add(newPay);
                          SystemChrome.setEnabledSystemUIMode(
                              SystemUiMode.immersive);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text("Something Wrong...")));
                        }
                        setState(() {});
                      },
                      child: Text(
                        "Kredit Terpakai: Rp $curPay",
                        style: dataSaldo(),
                      ),
                    ),
                  if (mechaine[q].isPaylater)
                    GestureDetector(
                      onTap: () async {
                        try {
                          String tempSal = await getTextFromDl(
                                  context,
                                  "Update Maksimal Kredit",
                                  'Masukan Maksimal Kredit Sekarang',
                                  pretext: '$curPayMax',
                                  mode: TextInputType.number) ??
                              curPayMax.toString();
                          double newPayX = double.parse(tempSal);
                          tempBox.putAt(
                              q,
                              Cards(curName, curLogo, curSaldo, curBoolPay,
                                  curPay, newPayX, curWeb, oldTime));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text("Something Wrong...")));
                        }
                        SystemChrome.setEnabledSystemUIMode(
                            SystemUiMode.immersive);
                        setState(() {});
                      },
                      child: Text(
                        "Jumlah Kredit : Rp $curPayMax",
                        style: dataSaldo(),
                      ),
                    ),
                  if (!mechaine[q].isPaylater) const Text(''),
                  if (!mechaine[q].isPaylater) const Text(''),
                  GestureDetector(
                    onTap: () async {
                      if (await canLaunchUrl(Uri.parse(curWeb))) {
                        await launchUrl(Uri.parse(curWeb));
                      } else {
                        throw 'Could not launch $curWeb';
                      }
                    },
                    onDoubleTap: () async {
                      try {
                        String newWeb = await getTextFromDl(context,
                                "Update Website", 'Masukan Website Sekarang',
                                pretext: curWeb) ??
                            curWeb;
                        tempBox.putAt(
                            q,
                            Cards(curName, curLogo, curSaldo, curBoolPay,
                                curPay, curPayMax, newWeb, oldTime));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text("Something Wrong...")));
                      }
                      SystemChrome.setEnabledSystemUIMode(
                          SystemUiMode.immersive);
                      setState(() {});
                    },
                    child: Text(
                      curWeb,
                      style: dataSaldo(blue: true),
                    ),
                  )
                ],
              )),
          Positioned(
              bottom: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    bool delete = await getBoolFromDl(
                            context, "Semua data kartu ini akan dihapus?") ??
                        false;
                    if (delete) {
                      tempBox.deleteAt(q);
                      tempHis.deleteAt(q);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text("Something Wrong...")));
                  }
                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
                  setState(() {});
                },
                child: const Text('Hapus'),
              )),
          Positioned(
              top: 20,
              right: 20,
              child: GestureDetector(
                onTap: () async {
                  try {
                    Uint8List tempImg = await getByteFromDl(
                          context,
                          "Update Logo Kartu",
                        ) ??
                        curLogo!;
                    tempBox.putAt(
                        q,
                        Cards(curName, tempImg, curSaldo, curBoolPay, curPay,
                            curPayMax, curWeb, oldTime));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text("Something Wrong...")));
                  }
                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
                  setState(() {});
                },
                child: Container(
                    height: 80,
                    width: 80,
                    decoration: (curLogo != null)
                        ? BoxDecoration(
                            image: DecorationImage(
                                image: MemoryImage(curLogo), fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(25))
                        : BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25))),
              ))
        ],
      );
    }
    return Center(
        child: ElevatedButton(
      child: const Text('Tambah Kartu'),
      onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddMoreCandy()));
      },
    ));
  }

  void _send() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            const Inventory(center: FractionalOffset(0.5, 0.5))));
  }

  Future<Uint8List?> getByteFromDl(BuildContext context, String text1) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                height: 240,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: (image != null)
                                ? Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: 100,
                                  )
                                : (f != null)
                                    ? Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: MemoryImage(f!))),
                                      )
                                    : const Icon(Icons.question_mark,
                                        size: 200, color: Colors.blue),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                margin: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: spcButton(
                                  doThisQuick: () =>
                                      pickImage(ImageSource.gallery),
                                  child: Row(
                                    children: const [
                                      Text("Gallery"),
                                      Spacer(),
                                      Icon(FontAwesomeIcons.photoFilm,
                                          size: 15),
                                    ],
                                  ),
                                )),
                          ),
                          Expanded(
                            child: Container(
                                margin:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: spcButton(
                                  doThisQuick: () =>
                                      pickImage(ImageSource.camera),
                                  child: Row(
                                    children: const [
                                      Text("Camera"),
                                      Spacer(),
                                      Icon(FontAwesomeIcons.cameraRetro,
                                          size: 15),
                                    ],
                                  ),
                                )),
                          )
                        ],
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
                            if (f != null) {
                              return Colors.lightBlue;
                            } else {
                              return Colors.grey;
                            }
                          })),
                          onPressed: () {
                            if (f != null) {
                              Navigator.pop(context, f);
                            }
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

  File? image;
  Uint8List? f;

  Future pickImage(ImageSource lead) async {
    try {
      final imageP = await ImagePicker().pickImage(source: lead);
      if (imageP == null) return;

      final imageTempo = File(imageP.path);
      setState(() async {
        image = imageTempo;
        f = await image!.readAsBytes();
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to Pick Image : $e');
    }
  }

  void _setImageSide() {
    if (_horDrag <= 90 || _horDrag >= 270) {
      _isFront = true;
    } else {
      _isFront = false;
    }
  }
}
