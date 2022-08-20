import 'dart:math';
import 'package:flutter/material.dart';

Future<bool> _deny() async {
  return false;
}

Future<void> loading(BuildContext context) async {
  showDialog(
      context: context,
      builder: (context) => WillPopScope(
            onWillPop: _deny,
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                height: 150,
                width: 0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image:
                                        AssetImage('assets/img/loading.gif')))),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 20.0),
                        child: Text("Loading..."),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ));
}

String answerGen() {
  String answ = "";
  switch (Random().nextInt(9)) {
    case 0:
      answ = "Elephant";
      break;
    case 1:
      answ = "Cars";
      break;
    case 2:
      answ = "Dogs";
      break;
    case 3:
      answ = "Yoyo";
      break;
    case 4:
      answ = "Hat";
      break;
    case 5:
      answ = "Clock";
      break;
    case 6:
      answ = "Jar";
      break;
    case 7:
      answ = "Wardrobe";
      break;
    case 8:
      answ = "Camera";
      break;
    default:
      answ = "Phone";
      break;
  }
  return answ;
}

String tokenGen() {
  String generator = "";
  String token = '${DateTime.now()}!@!&()^(*&';
  for (int i = 0; i < token.length; i++) {
    switch (token[i]) {
      case '1':
        if (Random().nextBool()) {
          generator += 'a';
        } else {
          if (Random().nextBool()) {
            generator += 'A';
          } else {
            generator += 'y';
          }
        }
        break;
      case '2':
        if (Random().nextBool()) {
          generator += 'c';
        } else {
          if (Random().nextBool()) {
            generator += 'B';
          } else {
            generator += 'Y';
          }
        }
        break;
      case '3':
        if (Random().nextBool()) {
          generator += 'd';
        } else {
          generator += 'D';
        }
        break;
      case '4':
        if (Random().nextBool()) {
          generator += 'w';
        } else {
          generator += 'W';
        }
        break;
      case '5':
        if (Random().nextBool()) {
          generator += 'd';
        } else {
          generator += 'U';
        }
        break;
      case '6':
        if (Random().nextBool()) {
          generator += 'Z';
        } else {
          generator += 's';
        }
        break;
      case '7':
        if (Random().nextBool()) {
          generator += 'z';
        } else {
          generator += 'k';
        }
        break;
      case '8':
        if (Random().nextBool()) {
          generator += 'l';
        } else {
          generator += 'J';
        }
        break;
      case '9':
        if (Random().nextBool()) {
          generator += 'U';
        } else {
          generator += 'g';
        }
        break;
      case '0':
        if (Random().nextBool()) {
          generator += 'C';
        } else {
          generator += 'u';
        }
        break;
      default:
        if (Random().nextBool()) {
          switch (Random().nextInt(11)) {
            case 0:
              generator += 'p';
              break;
            case 1:
              generator += 'r';
              break;
            case 2:
              generator += 'b';
              break;
            case 3:
              generator += 'e';
              break;
            case 4:
              generator += 'f';
              break;
            case 5:
              generator += 'G';
              break;
            case 6:
              generator += 'h';
              break;
            case 7:
              generator += 'i';
              break;
            case 8:
              generator += 'j';
              break;
            case 9:
              generator += 'K';
              break;
            case 10:
              generator += 'L';
              break;
            default:
              generator += 'mM';
          }
        } else {
          switch (Random().nextInt(11)) {
            case 0:
              generator += 'm';
              break;
            case 1:
              generator += 'M';
              break;
            case 2:
              generator += 'n';
              break;
            case 3:
              generator += 'N';
              break;
            case 4:
              generator += 'o';
              break;
            case 5:
              generator += 'O';
              break;
            case 6:
              generator += 'p';
              break;
            case 7:
              generator += 'P';
              break;
            case 8:
              generator += 'q';
              break;
            case 9:
              generator += 'Q';
              break;
            case 10:
              generator += 'r';
              break;
            default:
              generator += 'yY';
          }
        }
        break;
    }
  }

  String a = generator.substring(0, 6);
  String b = generator.substring(6, 12);
  String c = generator.substring(12, generator.length);

  switch (Random().nextInt(5)) {
    case 0:
      token = a + b + c;
      break;
    case 1:
      token = a + c + b;
      break;
    case 2:
      token = b + a + c;
      break;
    case 3:
      token = b + c + a;
      break;
    case 4:
      token = c + a + b;
      break;
    default:
      token = c + b + a;
      break;
  }

  return token;
}

class AniRotBu extends StatelessWidget {
  final Widget child;
  final Animation<double> rotate;
  final bool fronts;
  const AniRotBu({
    Key? key,
    required this.rotate,
    required this.child,
    required this.fronts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: rotate,
        child: child,
        builder: (context, child) {
          final angles = (fronts) ? min(rotate.value, pi / 2) : rotate.value;
          return Transform(
            transform: Matrix4.rotationY(angles),
            alignment: Alignment.center,
            child: child,
          );
        });
  }
}

double posR(String posisi, int pos, double tinggi, double lebar, bool hide) {
  if (pos == 0) {
    if (posisi == "rgt") {
      if (!hide) {
        return 0;
      } else {
        return -180;
      }
    }
    if (posisi == "btm") {
      return 90;
    }
  }
  if (pos == 1) {
    if (posisi == "rgt") {
      if (!hide) {
        return 0;
      } else {
        return -180;
      }
    }
    if (posisi == "btm") {
      return tinggi - 400;
    }
  }
  if (pos == 2) {
    if (posisi == "rgt") {
      if (!hide) {
        return lebar - 72;
      } else {
        return lebar + 180;
      }
    }
    if (posisi == "btm") {
      return 90;
    }
  }
  if (pos == 3) {
    if (posisi == "rgt") {
      if (!hide) {
        return lebar - 72;
      } else {
        return lebar + 180;
      }
    }
    if (posisi == "btm") {
      return tinggi - 400;
    }
  }

  return 0;
}
