import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ta_uniska_bjm/utils/backend/honeys/reminder.dart';

class RubicExe extends StatefulWidget {
  const RubicExe({Key? key}) : super(key: key);

  @override
  State<RubicExe> createState() => _RubicExeState();
}

class _RubicExeState extends State<RubicExe> {
  late double _ukuran, _ghost;
  double _counter = 0, _angles = 0, _side = 0, _bg = 0, _bgra = 0, _bgra1 = 0;
  DateTime sabar = DateTime.now();

  bool _add = false,
      _minus = false,
      _rollRight = false,
      _rollRightUp = false,
      _rollAbove = false,
      _rollAboveUp = false,
      _rollBellow = false,
      _rollBellowUp = false,
      _rollLeft = false,
      _rollLeftUp = false,
      _rollCenterV = false,
      _rollCenterVUp = false,
      _rollCenterH = false,
      _rollCenterHUp = false;

  double _rAni = 0, _rAniT = 0;
  double _lAni = 0, _lAniT = 0;
  double _uAni = 0, _uAniT = 0;
  double _dAni = 0, _dAniT = 0;
  double _cVAni = 0, _cVAniT = 0;
  double _cHAni = 0, _cHAniT = 0;

  double _ckaAni = 0, _ckaAni1 = 0, _ckaAni2 = 0;
  double _ckkAni = 0, _ckkAni1 = 0, _ckkAni2 = 0;
  double _rotAniA = 0, _rotAniK = 0, _rotAniKa = 0, _rotAniB = 0;

  double _ckcAni = 0;

  final List<Color> _colRub = [];

  void _sideCheck() {
    if (_side == 4) _side = 0;
  }

  void _incrementCounter() {
    if (_uAni == _uAniT &&
        _dAni == _dAniT &&
        _lAni == _lAniT &&
        _rAni == _rAniT &&
        _cVAni == _cVAniT &&
        _cHAni == _cHAniT &&
        _angles == _counter) {
      _side++;

      _bg = _ukuran;
      _sideCheck();
      setState(() {
        _counter = _counter + pi / 2;
        _add = true;
      });
    }
  }

  void _lessCounter() {
    if (_uAni == _uAniT &&
        _dAni == _dAniT &&
        _lAni == _lAniT &&
        _rAni == _rAniT &&
        _cVAni == _cVAniT &&
        _cHAni == _cHAniT &&
        _angles == _counter) {
      _sideCheck();
      if (_side == 0) {
        _side = 7;
      } else {
        _side--;
      }
      _bg = _ukuran;
      setState(() {
        _counter = _counter - pi / 2;
        _minus = true;
      });
    }
  }

  void _invasionRightD({bool down = true}) {
    if (_uAni == _uAniT &&
        _dAni == _dAniT &&
        _rAni == _rAniT &&
        _cHAni == _cHAniT &&
        _angles == _counter) {
      _rAni = 0;
      if (down) {
        _rAniT = _ukuran;
        _rollRight = true;
      } else {
        _rAniT = -_ukuran;
        _rollRightUp = true;
      }
      setState(() {});
    }
  }

  void _invasionUpD({bool down = true}) {
    if (_uAni == _uAniT &&
        _rAni == _rAniT &&
        _lAni == _lAniT &&
        _cVAni == _cVAniT &&
        _angles == _counter) {
      _uAni = 0;
      if (down) {
        _uAniT = _ukuran;
        _rollAbove = true;
      } else {
        _uAniT = -_ukuran;
        _rollAboveUp = true;
      }
      setState(() {});
    }
  }

  void _invasionDownD({bool down = true}) {
    if (_dAni == _dAniT &&
        _lAni == _rAniT &&
        _lAni == _rAniT &&
        _cVAni == _cVAniT &&
        _angles == _counter) {
      _dAni = 0;
      if (down) {
        _dAniT = _ukuran;
        _rollBellow = true;
      } else {
        _dAniT = -_ukuran;

        _rollBellowUp = true;
      }
      setState(() {});
    }
  }

  void _invasionLeftD({bool down = true}) {
    if (_uAni == _uAniT &&
        _dAni == _dAniT &&
        _lAni == _lAniT &&
        _cHAni == _cHAniT &&
        _angles == _counter) {
      _lAni = 0;
      if (down) {
        _lAniT = _ukuran;
        _rollLeft = true;
      } else {
        _lAniT = -_ukuran;
        _rollLeftUp = true;
      }
      setState(() {});
    }
  }

  void _invasionCenterH({bool down = true}) {
    if (_lAni == _lAniT &&
        _rAni == _rAniT &&
        _cHAni == _cHAniT &&
        _cVAni == _cVAniT &&
        _angles == _counter) {
      _cHAni = 0;
      if (down) {
        _cHAniT = _ukuran;
        _rollCenterH = true;
      } else {
        _cHAniT = -_ukuran;
        _rollCenterHUp = true;
      }
      setState(() {});
    }
  }

  void _invasionCenterV({bool down = true}) {
    if (_cHAni == _cHAniT &&
        _uAni == _uAniT &&
        _dAni == _dAniT &&
        _cVAni == _cVAniT &&
        _angles == _counter) {
      _cVAni = 0;
      if (down) {
        _cVAniT = _ukuran;
        _rollCenterV = true;
      } else {
        _cVAniT = -_ukuran;
        _rollCenterVUp = true;
      }
      setState(() {});
    }
  }

  Future<void> _update() async {
    var pieces = Hive.box('Pieces');
    int num = 6;
    for (int i = 0; i < 54; i++) {
      if (_colRub[i] == const Color(0xffffffff)) {
        num = 0;
      }
      if (_colRub[i] == const Color(0xfff44336)) {
        num = 1;
      }
      if (_colRub[i] == const Color(0xff4caf50)) {
        num = 2;
      }
      if (_colRub[i] == const Color(0xffff9800)) {
        num = 3;
      }
      if (_colRub[i] == const Color(0xff2196f3)) {
        num = 4;
      }
      if (_colRub[i] == const Color(0xffffeb3b)) {
        num = 5;
      }

      pieces.putAt(i, Pieces(num));
    }
  }

  @override
  void initState() {
    List<Color> colList = [
      Colors.white,
      const Color(0xfff44336),
      const Color(0xff4caf50),
      const Color(0xffff9800),
      const Color(0xff2196f3),
      const Color(0xffffeb3b)
    ];
    for (int j = 0; j < 6; j++) {
      for (int i = 0; i < 9; i++) {
        _colRub.add(colList[j]);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    _ukuran = lebar / 1.6363636363636365;
    _ghost = lebar / 7.854545454545455;
    return Scaffold(
        appBar: AppBar(
            title: const Text("2D Rubic"), backgroundColor: Colors.black),
        body: Center(
            child: FutureBuilder(
                future: Hive.openBox('Pieces'),
                builder: (context, ss) {
                  if (ConnectionState.done == ss.connectionState) {
                    var pieces = Hive.box('Pieces');

                    if (pieces.length == 0) {
                      for (int i = 0; i < 6; i++) {
                        for (int j = 0; j < 9; j++) {
                          pieces.add(Pieces(i));
                        }
                      }
                    } else {
                      List<Pieces> x = [];
                      for (int i = 0; i < 54; i++) {
                        x.add(pieces.getAt(i));
                        switch (x[i].col) {
                          case 0:
                            _colRub[i] = Colors.white;
                            break;
                          case 1:
                            _colRub[i] = const Color(0xfff44336);
                            break;
                          case 2:
                            _colRub[i] = const Color(0xff4caf50);
                            break;
                          case 3:
                            _colRub[i] = const Color(0xffff9800);
                            break;
                          case 4:
                            _colRub[i] = const Color(0xff2196f3);
                            break;
                          case 5:
                            _colRub[i] = const Color(0xffffeb3b);
                            break;
                          default:
                            _colRub[i] = Colors.black;
                            break;
                        }
                      }
                    }
                  }
                  return SizedBox(
                    height: 500,
                    width: (MediaQuery.of(context).size.width > 500)
                        ? 500
                        : MediaQuery.of(context).size.width,
                    child: StreamBuilder(
                        stream:
                            Stream.periodic(const Duration(milliseconds: 50)),
                        builder: (context, snapshot) {
                          if ((!_rollCenterH && !_rollCenterHUp) ||
                              (!_rollBellow && !_rollBellowUp)) {}
                          if (_add) {
                            if (_angles < _counter) {
                              _angles += 0.09;
                              _ckcAni += 3;
                            } else {
                              _add = false;
                              _angles = 0;
                              _counter = 0;
                              _ckcAni = 0;
                              _bg = 0;

                              List<Color> bench = [];
                              bench.add(_colRub[0]);
                              bench.add(_colRub[1]);
                              bench.add(_colRub[2]);

                              _colRub[0] = _colRub[6];
                              _colRub[1] = _colRub[3];
                              _colRub[3] = _colRub[7];
                              _colRub[7] = _colRub[5];
                              _colRub[6] = _colRub[8];
                              _colRub[2] = bench[0];
                              _colRub[5] = bench[1];
                              _colRub[8] = bench[2];

                              bench.clear();
                              bench.add(_colRub[15]);
                              bench.add(_colRub[16]);
                              bench.add(_colRub[17]);

                              _colRub[15] = _colRub[42];
                              _colRub[16] = _colRub[43];
                              _colRub[17] = _colRub[44];

                              _colRub[42] = _colRub[33];
                              _colRub[43] = _colRub[34];
                              _colRub[44] = _colRub[35];

                              _colRub[33] = _colRub[24];
                              _colRub[34] = _colRub[25];
                              _colRub[35] = _colRub[26];

                              _colRub[24] = bench[0];
                              _colRub[25] = bench[1];
                              _colRub[26] = bench[2];
                              _update();
                            }
                          }
                          if (_minus) {
                            if (_angles > _counter) {
                              _angles -= 0.09;
                              _ckcAni -= 3;
                            } else {
                              _minus = false;
                              _angles = 0;
                              _counter = 0;
                              _ckcAni = 0;
                              _bg = 0;

                              List<Color> bench = [];
                              bench.add(_colRub[0]);
                              bench.add(_colRub[1]);
                              bench.add(_colRub[2]);

                              _colRub[0] = bench[2];
                              _colRub[1] = _colRub[5];
                              _colRub[5] = _colRub[7];
                              _colRub[7] = _colRub[3];
                              _colRub[3] = bench[1];
                              _colRub[2] = _colRub[8];
                              _colRub[8] = _colRub[6];
                              _colRub[6] = bench[0];

                              bench.clear();
                              bench.add(_colRub[15]);
                              bench.add(_colRub[16]);
                              bench.add(_colRub[17]);

                              _colRub[15] = _colRub[24];
                              _colRub[16] = _colRub[25];
                              _colRub[17] = _colRub[26];

                              _colRub[24] = _colRub[33];
                              _colRub[25] = _colRub[34];
                              _colRub[26] = _colRub[35];

                              _colRub[33] = _colRub[42];
                              _colRub[34] = _colRub[43];
                              _colRub[35] = _colRub[44];

                              _colRub[42] = bench[0];
                              _colRub[43] = bench[1];
                              _colRub[44] = bench[2];

                              _update();
                            }
                          }
                          if (_rollLeft) {
                            if (_lAni < _lAniT) {
                              _lAni += 20;
                              _ckaAni2 += 4.5;
                              _rotAniK += 0.12;
                            } else {
                              _rollLeft = false;
                              _lAni = _lAniT;
                              _lAni = 0;
                              _lAniT = 0;
                              _ckaAni2 = 0;
                              _rotAniK = 0;

                              List<Color> bench = [];
                              bench.add(_colRub[0]);
                              bench.add(_colRub[3]);
                              bench.add(_colRub[6]);

                              _colRub[0] = _colRub[9];
                              _colRub[3] = _colRub[12];
                              _colRub[6] = _colRub[15];

                              _colRub[9] = _colRub[45];
                              _colRub[12] = _colRub[48];
                              _colRub[15] = _colRub[51];

                              _colRub[45] = _colRub[35];
                              _colRub[48] = _colRub[32];
                              _colRub[51] = _colRub[29];

                              _colRub[35] = bench[0];
                              _colRub[32] = bench[1];
                              _colRub[29] = bench[2];

                              bench.clear();
                              bench.add(_colRub[38]);
                              bench.add(_colRub[41]);
                              bench.add(_colRub[44]);

                              _colRub[38] = _colRub[36];
                              _colRub[41] = _colRub[37];
                              _colRub[37] = _colRub[39];
                              _colRub[39] = _colRub[43];
                              _colRub[36] = _colRub[42];
                              _colRub[44] = bench[0];
                              _colRub[43] = bench[1];
                              _colRub[42] = bench[2];

                              _update();
                            }
                          }
                          if (_rollRight) {
                            if (_rAni < _rAniT) {
                              _rAni += 20;
                              _ckaAni += 4.5;
                              _rotAniKa -= 0.12;
                            } else {
                              _rollRight = false;
                              _rotAniKa = 0;
                              _rAni = _rAniT;
                              _rAni = 0;
                              _rAniT = 0;
                              _ckaAni = 0;

                              List<Color> bench = [];
                              bench.add(_colRub[2]);
                              bench.add(_colRub[5]);
                              bench.add(_colRub[8]);

                              _colRub[2] = _colRub[11];
                              _colRub[5] = _colRub[14];
                              _colRub[8] = _colRub[17];

                              _colRub[11] = _colRub[47];
                              _colRub[14] = _colRub[50];
                              _colRub[17] = _colRub[53];

                              _colRub[47] = _colRub[33];
                              _colRub[50] = _colRub[30];
                              _colRub[53] = _colRub[27];

                              _colRub[33] = bench[0];
                              _colRub[30] = bench[1];
                              _colRub[27] = bench[2];

                              bench.clear();
                              bench.add(_colRub[24]);
                              bench.add(_colRub[21]);
                              bench.add(_colRub[18]);

                              _colRub[24] = bench[2];
                              _colRub[21] = _colRub[19];
                              _colRub[18] = _colRub[20];
                              _colRub[19] = _colRub[23];
                              _colRub[23] = _colRub[25];
                              _colRub[20] = _colRub[26];
                              _colRub[26] = bench[0];
                              _colRub[25] = bench[1];

                              _update();
                            }
                          }
                          if (_rollLeftUp) {
                            if (_lAni > _lAniT) {
                              _lAni -= 20;
                              _ckaAni2 -= 4.5;
                              _rotAniK -= 0.12;
                            } else {
                              _rotAniK = 0;
                              _rollLeftUp = false;
                              _lAni = _lAniT;
                              _lAni = 0;
                              _lAniT = 0;
                              _ckaAni2 = 0;

                              List<Color> bench = [];
                              bench.add(_colRub[0]);
                              bench.add(_colRub[3]);
                              bench.add(_colRub[6]);

                              _colRub[0] = _colRub[35];
                              _colRub[3] = _colRub[32];
                              _colRub[6] = _colRub[29];

                              _colRub[35] = _colRub[45];
                              _colRub[32] = _colRub[48];
                              _colRub[29] = _colRub[51];

                              _colRub[45] = _colRub[9];
                              _colRub[48] = _colRub[12];
                              _colRub[51] = _colRub[15];

                              _colRub[9] = bench[0];
                              _colRub[12] = bench[1];
                              _colRub[15] = bench[2];

                              bench.clear();
                              bench.add(_colRub[38]);
                              bench.add(_colRub[41]);
                              bench.add(_colRub[44]);

                              _colRub[41] = _colRub[43];
                              _colRub[44] = _colRub[42];
                              _colRub[43] = _colRub[39];
                              _colRub[39] = _colRub[37];
                              _colRub[42] = _colRub[36];
                              _colRub[36] = bench[0];
                              _colRub[37] = bench[1];
                              _colRub[38] = bench[2];
                              _update();
                            }
                          }
                          if (_rollRightUp) {
                            if (_rAni > _rAniT) {
                              _rAni -= 20;
                              _ckaAni -= 4.5;
                              _rotAniKa += 0.12;
                            } else {
                              _rotAniKa = 0;
                              _rollRightUp = false;
                              _rAni = _rAniT;
                              _rAni = 0;
                              _rAniT = 0;
                              _ckaAni = 0;

                              List<Color> bench = [];
                              bench.add(_colRub[2]);
                              bench.add(_colRub[5]);
                              bench.add(_colRub[8]);

                              _colRub[2] = _colRub[33];
                              _colRub[5] = _colRub[30];
                              _colRub[8] = _colRub[27];

                              _colRub[33] = _colRub[47];
                              _colRub[30] = _colRub[50];
                              _colRub[27] = _colRub[53];

                              _colRub[47] = _colRub[11];
                              _colRub[50] = _colRub[14];
                              _colRub[53] = _colRub[17];

                              _colRub[11] = bench[0];
                              _colRub[14] = bench[1];
                              _colRub[17] = bench[2];

                              bench.clear();
                              bench.add(_colRub[24]);
                              bench.add(_colRub[21]);
                              bench.add(_colRub[18]);

                              _colRub[24] = _colRub[26];
                              _colRub[21] = _colRub[25];
                              _colRub[18] = bench[0];
                              _colRub[25] = _colRub[23];
                              _colRub[23] = _colRub[19];
                              _colRub[19] = bench[1];
                              _colRub[26] = _colRub[20];
                              _colRub[20] = bench[2];
                              _update();
                            }
                          }
                          if (_rollAbove) {
                            if (_uAni < _uAniT) {
                              _uAni += 20;
                              _ckkAni += 4.5;
                              _rotAniA -= 0.12;
                            } else {
                              _rollAbove = false;
                              _rotAniA = 0;
                              _uAni = _uAniT;
                              _uAni = 0;
                              _uAniT = 0;
                              _ckkAni = 0;

                              List<Color> bench = [];
                              bench.add(_colRub[0]);
                              bench.add(_colRub[1]);
                              bench.add(_colRub[2]);

                              _colRub[0] = _colRub[38];
                              _colRub[1] = _colRub[41];
                              _colRub[2] = _colRub[44];

                              _colRub[38] = _colRub[53];
                              _colRub[41] = _colRub[52];
                              _colRub[44] = _colRub[51];

                              _colRub[53] = _colRub[24];
                              _colRub[52] = _colRub[21];
                              _colRub[51] = _colRub[18];

                              _colRub[24] = bench[0];
                              _colRub[21] = bench[1];
                              _colRub[18] = bench[2];

                              bench.clear();
                              bench.add(_colRub[9]);
                              bench.add(_colRub[10]);
                              bench.add(_colRub[11]);

                              _colRub[9] = bench[2];
                              _colRub[10] = _colRub[14];
                              _colRub[11] = _colRub[17];
                              _colRub[14] = _colRub[16];
                              _colRub[16] = _colRub[12];
                              _colRub[17] = _colRub[15];
                              _colRub[12] = bench[1];
                              _colRub[15] = bench[0];
                              _update();
                            }
                          }
                          if (_rollAboveUp) {
                            if (_uAni > _uAniT) {
                              _uAni -= 20;
                              _ckkAni -= 4.5;
                              _rotAniA += 0.12;
                            } else {
                              _rotAniA = 0;
                              _rollAboveUp = false;
                              _uAni = _uAniT;
                              _uAni = 0;
                              _uAniT = 0;
                              _ckkAni = 0;
                              List<Color> bench = [];
                              bench.add(_colRub[0]);
                              bench.add(_colRub[1]);
                              bench.add(_colRub[2]);

                              _colRub[0] = _colRub[24];
                              _colRub[1] = _colRub[21];
                              _colRub[2] = _colRub[18];

                              _colRub[24] = _colRub[53];
                              _colRub[21] = _colRub[52];
                              _colRub[18] = _colRub[51];

                              _colRub[53] = _colRub[38];
                              _colRub[52] = _colRub[41];
                              _colRub[51] = _colRub[44];

                              _colRub[38] = bench[0];
                              _colRub[41] = bench[1];
                              _colRub[44] = bench[2];

                              bench.clear();
                              bench.add(_colRub[9]);
                              bench.add(_colRub[10]);
                              bench.add(_colRub[11]);

                              _colRub[9] = _colRub[15];
                              _colRub[10] = _colRub[12];
                              _colRub[11] = bench[0];
                              _colRub[12] = _colRub[16];
                              _colRub[15] = _colRub[17];
                              _colRub[16] = _colRub[14];
                              _colRub[17] = bench[2];
                              _colRub[14] = bench[1];
                              _update();
                            }
                          }
                          if (_rollBellow) {
                            if (_dAni < _dAniT) {
                              _dAni += 20;
                              _ckkAni2 += 4.5;
                              _rotAniB += 0.12;
                            } else {
                              _rollBellow = false;
                              _rotAniB = 0;
                              _dAni = _dAniT;
                              _dAni = 0;
                              _dAniT = 0;
                              _ckkAni2 = 0;

                              List<Color> bench = [];
                              bench.add(_colRub[6]);
                              bench.add(_colRub[7]);
                              bench.add(_colRub[8]);

                              _colRub[6] = _colRub[36];
                              _colRub[7] = _colRub[39];
                              _colRub[8] = _colRub[42];

                              _colRub[36] = _colRub[47];
                              _colRub[39] = _colRub[46];
                              _colRub[42] = _colRub[45];

                              _colRub[47] = _colRub[26];
                              _colRub[46] = _colRub[23];
                              _colRub[45] = _colRub[20];

                              _colRub[26] = bench[0];
                              _colRub[23] = bench[1];
                              _colRub[20] = bench[2];

                              bench.clear();
                              bench.add(_colRub[35]);
                              bench.add(_colRub[34]);
                              bench.add(_colRub[33]);

                              _colRub[35] = _colRub[29];
                              _colRub[34] = _colRub[32];
                              _colRub[33] = bench[0];
                              _colRub[32] = _colRub[28];
                              _colRub[28] = _colRub[30];
                              _colRub[29] = _colRub[27];
                              _colRub[30] = bench[1];
                              _colRub[27] = bench[2];
                              _update();
                            }
                          }
                          if (_rollBellowUp) {
                            if (_dAni > _dAniT) {
                              _dAni -= 20;
                              _ckkAni2 -= 4.5;
                              _rotAniB -= 0.12;
                            } else {
                              _rollBellowUp = false;
                              _dAni = _dAniT;
                              _dAni = 0;
                              _dAniT = 0;
                              _ckkAni2 = 0;
                              _rotAniB = 0;

                              List<Color> bench = [];
                              bench.add(_colRub[6]);
                              bench.add(_colRub[7]);
                              bench.add(_colRub[8]);

                              _colRub[6] = _colRub[26];
                              _colRub[7] = _colRub[23];
                              _colRub[8] = _colRub[20];

                              _colRub[26] = _colRub[47];
                              _colRub[23] = _colRub[46];
                              _colRub[20] = _colRub[45];

                              _colRub[47] = _colRub[36];
                              _colRub[46] = _colRub[39];
                              _colRub[45] = _colRub[42];

                              _colRub[36] = bench[0];
                              _colRub[39] = bench[1];
                              _colRub[42] = bench[2];

                              bench.clear();
                              bench.add(_colRub[35]);
                              bench.add(_colRub[34]);
                              bench.add(_colRub[33]);

                              _colRub[35] = bench[2];
                              _colRub[34] = _colRub[30];
                              _colRub[33] = _colRub[27];
                              _colRub[30] = _colRub[28];
                              _colRub[28] = _colRub[32];
                              _colRub[27] = _colRub[29];
                              _colRub[29] = bench[0];
                              _colRub[32] = bench[1];
                              _update();
                            }
                          }
                          if (_rollCenterV) {
                            if (_cVAni < _cVAniT) {
                              _cVAni += 20;
                              _ckaAni1 += 4.5;
                              _bgra1 += 0.12;
                            } else {
                              _rollCenterV = false;
                              _cVAni = _cVAniT;
                              _cVAni = 0;
                              _cVAniT = 0;
                              _ckaAni1 = 0;
                              _bgra1 = 0;

                              List<Color> bench = [];
                              bench.add(_colRub[1]);
                              bench.add(_colRub[4]);
                              bench.add(_colRub[7]);

                              _colRub[1] = _colRub[10];
                              _colRub[4] = _colRub[13];
                              _colRub[7] = _colRub[16];

                              _colRub[10] = _colRub[46];
                              _colRub[13] = _colRub[49];
                              _colRub[16] = _colRub[52];

                              _colRub[46] = _colRub[34];
                              _colRub[49] = _colRub[31];
                              _colRub[52] = _colRub[28];

                              _colRub[34] = bench[0];
                              _colRub[31] = bench[1];
                              _colRub[28] = bench[2];
                              _update();
                            }
                          }
                          if (_rollCenterVUp) {
                            if (_cVAni > _cVAniT) {
                              _cVAni -= 20;
                              _ckaAni1 -= 4.5;
                              _bgra1 -= 0.12;
                            } else {
                              _rollCenterVUp = false;
                              _cVAni = _cVAniT;
                              _cVAni = 0;
                              _cVAniT = 0;
                              _ckaAni1 = 0;
                              _bgra1 = 0;

                              List<Color> bench = [];
                              bench.add(_colRub[1]);
                              bench.add(_colRub[4]);
                              bench.add(_colRub[7]);

                              _colRub[1] = _colRub[34];
                              _colRub[4] = _colRub[31];
                              _colRub[7] = _colRub[28];

                              _colRub[34] = _colRub[46];
                              _colRub[31] = _colRub[49];
                              _colRub[28] = _colRub[52];

                              _colRub[46] = _colRub[10];
                              _colRub[49] = _colRub[13];
                              _colRub[52] = _colRub[16];

                              _colRub[10] = bench[0];
                              _colRub[13] = bench[1];
                              _colRub[16] = bench[2];
                              _update();
                            }
                          }
                          if (_rollCenterH) {
                            if (_cHAni < _cHAniT) {
                              _cHAni += 20;
                              _ckkAni1 += 4.5;
                              _bgra -= 0.12;
                            } else {
                              _bgra = 0;
                              _rollCenterH = false;
                              _cHAni = _cHAniT;
                              _cHAni = 0;
                              _cHAniT = 0;
                              _ckkAni1 = 0;

                              List<Color> bench = [];
                              bench.add(_colRub[3]);
                              bench.add(_colRub[4]);
                              bench.add(_colRub[5]);

                              _colRub[3] = _colRub[37];
                              _colRub[4] = _colRub[40];
                              _colRub[5] = _colRub[43];

                              _colRub[37] = _colRub[50];
                              _colRub[40] = _colRub[49];
                              _colRub[43] = _colRub[48];

                              _colRub[50] = _colRub[25];
                              _colRub[49] = _colRub[22];
                              _colRub[48] = _colRub[19];

                              _colRub[25] = bench[0];
                              _colRub[22] = bench[1];
                              _colRub[19] = bench[2];
                              _update();
                            }
                          }
                          if (_rollCenterHUp) {
                            if (_cHAni > _cHAniT) {
                              _cHAni -= 20;
                              _ckkAni1 -= 4.5;
                              _bgra += 0.12;
                            } else {
                              _bgra = 0;
                              _rollCenterHUp = false;
                              _cHAni = _cHAniT;
                              _cHAni = 0;
                              _cHAniT = 0;
                              _ckkAni1 = 0;

                              List<Color> bench = [];
                              bench.add(_colRub[3]);
                              bench.add(_colRub[4]);
                              bench.add(_colRub[5]);

                              _colRub[3] = _colRub[25];
                              _colRub[4] = _colRub[22];
                              _colRub[5] = _colRub[19];

                              _colRub[25] = _colRub[50];
                              _colRub[22] = _colRub[49];
                              _colRub[19] = _colRub[48];

                              _colRub[50] = _colRub[37];
                              _colRub[49] = _colRub[40];
                              _colRub[48] = _colRub[43];

                              _colRub[37] = bench[0];
                              _colRub[40] = bench[1];
                              _colRub[43] = bench[2];
                              _update();
                            }
                          }
                          if (_side == 0 && _angles == _counter) {
                            _angles = 0;
                            _counter = 0;
                          }

                          return Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Stack(
                              children: [
                                //+++++++++++++L-L**********ATAS**********J-J+++++++++++++++++
                                Positioned(
                                  top: 20,
                                  left:
                                      (MediaQuery.of(context).size.width < 500)
                                          ? 175
                                          : 225,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (DateTime.now().isAfter(sabar.add(
                                          const Duration(milliseconds: 800)))) {
                                        _invasionRightD();
                                        _invasionCenterV();
                                        _invasionLeftD();
                                        sabar = DateTime.now();
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        Transform.rotate(
                                          angle: -_rotAniB,
                                          child: Container(
                                            height: _ghost,
                                            width: _ghost,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Transform.rotate(
                                          angle: _bgra,
                                          child: Container(
                                            height: _ghost,
                                            width: _ghost,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Transform.rotate(
                                          angle: _rotAniA,
                                          child: SizedBox(
                                            height: _ghost,
                                            width: _ghost,
                                            child: Stack(children: [
                                              //Precube Atas
                                              //Kanan
                                              Positioned(
                                                  left: 2 * _ghost / 8 + 20,
                                                  top: -_ghost + _ckaAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[47])),
                                              Positioned(
                                                  left: 2 * _ghost / 8 + 20,
                                                  top: -_ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckaAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[50])),
                                              Positioned(
                                                  left: 2 * _ghost / 8 + 20,
                                                  top: -_ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckaAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[53])),
                                              //Tengah
                                              Positioned(
                                                  left: _ghost / 8 + 10,
                                                  top: -_ghost + _ckaAni1,
                                                  child: _rubicPb(
                                                      warna: _colRub[46])),
                                              Positioned(
                                                  left: _ghost / 8 + 10,
                                                  top: -_ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckaAni1,
                                                  child: _rubicPb(
                                                      warna: _colRub[49])),
                                              Positioned(
                                                  left: _ghost / 8 + 10,
                                                  top: -_ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckaAni1,
                                                  child: _rubicPb(
                                                      warna: _colRub[52])),
                                              //kiri
                                              Positioned(
                                                  left: 0,
                                                  top: -_ghost + _ckaAni2,
                                                  child: _rubicPb(
                                                      warna: _colRub[45])),
                                              Positioned(
                                                  left: 0,
                                                  top: -_ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckaAni2,
                                                  child: _rubicPb(
                                                      warna: _colRub[48])),
                                              Positioned(
                                                  left: 0,
                                                  top: -_ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckaAni2,
                                                  child: _rubicPb(
                                                      warna: _colRub[51])),

                                              //Precube Bawah
                                              //Kanan
                                              Positioned(
                                                  left: 2 * _ghost / 8 + 20,
                                                  top: _ghost + _ckaAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[2])),
                                              Positioned(
                                                  left: 2 * _ghost / 8 + 20,
                                                  top: _ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckaAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[5])),
                                              Positioned(
                                                  left: 2 * _ghost / 8 + 20,
                                                  top: _ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckaAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[8])),
                                              //Tengah
                                              Positioned(
                                                  left: _ghost / 8 + 10,
                                                  top: _ghost + _ckaAni1,
                                                  child: _rubicPb(
                                                      warna: _colRub[1])),
                                              Positioned(
                                                  left: _ghost / 8 + 10,
                                                  top: _ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckaAni1,
                                                  child: _rubicPb(
                                                      warna: _colRub[4])),
                                              Positioned(
                                                  left: _ghost / 8 + 10,
                                                  top: _ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckaAni1,
                                                  child: _rubicPb(
                                                      warna: _colRub[7])),
                                              //Kiri
                                              Positioned(
                                                  left: 0,
                                                  top: _ghost + _ckaAni2,
                                                  child: _rubicPb(
                                                      warna: _colRub[0])),
                                              Positioned(
                                                  left: 0,
                                                  top: _ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckaAni2,
                                                  child: _rubicPb(
                                                      warna: _colRub[3])),
                                              Positioned(
                                                  left: 0,
                                                  top: _ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckaAni2,
                                                  child: _rubicPb(
                                                      warna: _colRub[6])),

                                              //Rotasi Kiri
                                              Positioned(
                                                  left: -_ghost + _ckcAni,
                                                  top: (2 * _ghost / 8 + 20),
                                                  child: _rubicPb(
                                                      warna: _colRub[42])),
                                              Positioned(
                                                  left: -_ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckcAni,
                                                  top: (2 * _ghost / 8 + 20),
                                                  child: _rubicPb(
                                                      warna: _colRub[43])),
                                              Positioned(
                                                  left: -_ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckcAni,
                                                  top: (2 * _ghost / 8 + 20),
                                                  child: _rubicPb(
                                                      warna: _colRub[44])),

                                              //Rotasi Kanan
                                              Positioned(
                                                  left: _ghost + _ckcAni,
                                                  top: (2 * _ghost / 8 + 20),
                                                  child: _rubicPb(
                                                      warna: _colRub[24])),
                                              Positioned(
                                                  left: _ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckcAni,
                                                  top: (2 * _ghost / 8 + 20),
                                                  child: _rubicPb(
                                                      warna: _colRub[25])),
                                              Positioned(
                                                  left: _ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckcAni,
                                                  top: (2 * _ghost / 8 + 20),
                                                  child: _rubicPb(
                                                      warna: _colRub[26])),

                                              // Cube Asli
                                              Positioned(
                                                  left: 0,
                                                  top: 0 + _ckaAni2,
                                                  child: _rubicPb(
                                                      warna: _colRub[9])),
                                              Positioned(
                                                left: _ghost / 8 + 10,
                                                top: 0 + _ckaAni1,
                                                child: _rubicPb(
                                                    warna: _colRub[10]),
                                              ),
                                              Positioned(
                                                  left: (2 * _ghost / 8 + 20),
                                                  top: 0 + _ckaAni,
                                                  child: _rubicPb(
                                                    warna: _colRub[11],
                                                  )),
                                              //_______________________++++++++++++++++++++++++++_____________________//
                                              Positioned(
                                                  left: 0,
                                                  top: _ghost / 8 +
                                                      10 +
                                                      _ckaAni2,
                                                  child: _rubicPb(
                                                      warna: _colRub[12])),
                                              Positioned(
                                                  left: _ghost / 8 + 10,
                                                  top: _ghost / 8 +
                                                      10 +
                                                      _ckaAni1,
                                                  child: _rubicPb(
                                                      warna: _colRub[13])),
                                              Positioned(
                                                  left: 2 * _ghost / 8 + 20,
                                                  top:
                                                      _ghost / 8 + 10 + _ckaAni,
                                                  child: _rubicPb(
                                                    warna: _colRub[14],
                                                  )),
                                              //_______________________++++++++++++++++++++++++++_____________________//
                                              Positioned(
                                                  left: 0 + _ckcAni,
                                                  top: 2 * _ghost / 8 +
                                                      20 +
                                                      _ckaAni2,
                                                  child: _rubicPb(
                                                      warna: _colRub[15])),
                                              Positioned(
                                                  left:
                                                      _ghost / 8 + 10 + _ckcAni,
                                                  top: 2 * _ghost / 8 +
                                                      20 +
                                                      _ckaAni1,
                                                  child: _rubicPb(
                                                      warna: _colRub[16])),
                                              Positioned(
                                                  left: 2 * _ghost / 8 +
                                                      20 +
                                                      _ckcAni,
                                                  top: 2 * _ghost / 8 +
                                                      20 +
                                                      _ckaAni,
                                                  child: _rubicPb(
                                                    warna: _colRub[17],
                                                  )),
                                            ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //+++++++++++++L-L**********ATAS**********J-J+++++++++++++++++
                                //+++++++++++++L-L**********KIRI**********J-J+++++++++++++++++
                                Positioned(
                                  top: MediaQuery.of(context).size.height / 4,
                                  left:
                                      (MediaQuery.of(context).size.width < 500)
                                          ? 5
                                          : 50,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (DateTime.now().isAfter(sabar.add(
                                          const Duration(milliseconds: 800)))) {
                                        _invasionCenterH();
                                        _invasionUpD();
                                        _invasionDownD();
                                        sabar = DateTime.now();
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        Transform.rotate(
                                          angle: -_rotAniKa,
                                          child: Container(
                                            height: _ghost,
                                            width: _ghost,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Transform.rotate(
                                          angle: _bgra1,
                                          child: Container(
                                            height: _ghost,
                                            width: _ghost,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Transform.rotate(
                                          angle: _rotAniK,
                                          child: SizedBox(
                                            height: _ghost,
                                            width: _ghost,
                                            child: Stack(children: [
                                              //Precube Kiri
                                              //Atas
                                              Positioned(
                                                  left: -_ghost + _ckkAni,
                                                  top: 0,
                                                  child: _rubicPb(
                                                      warna: _colRub[53])),
                                              Positioned(
                                                  left: -_ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckkAni,
                                                  top: 0,
                                                  child: _rubicPb(
                                                      warna: _colRub[52])),
                                              Positioned(
                                                  left: -_ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckkAni,
                                                  top: 0,
                                                  child: _rubicPb(
                                                      warna: _colRub[51])),
                                              //Tengah
                                              Positioned(
                                                  left: -_ghost + _ckkAni1,
                                                  top: _ghost / 8 + 10,
                                                  child: _rubicPb(
                                                      warna: _colRub[50])),
                                              Positioned(
                                                  left: -_ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckkAni1,
                                                  top: _ghost / 8 + 10,
                                                  child: _rubicPb(
                                                      warna: _colRub[49])),
                                              Positioned(
                                                  left: -_ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckkAni1,
                                                  top: _ghost / 8 + 10,
                                                  child: _rubicPb(
                                                      warna: _colRub[48])),
                                              //bawah
                                              Positioned(
                                                  left: -_ghost + _ckkAni2,
                                                  top: 2 * _ghost / 8 + 20,
                                                  child: _rubicPb(
                                                      warna: _colRub[47])),
                                              Positioned(
                                                  left: -_ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckkAni2,
                                                  top: 2 * _ghost / 8 + 20,
                                                  child: _rubicPb(
                                                      warna: _colRub[46])),
                                              Positioned(
                                                  left: -_ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckkAni2,
                                                  top: 2 * _ghost / 8 + 20,
                                                  child: _rubicPb(
                                                      warna: _colRub[45])),

                                              //Precube Kanan
                                              //Kanan
                                              Positioned(
                                                  left: _ghost + _ckkAni,
                                                  top: 0,
                                                  child: _rubicPb(
                                                      warna: _colRub[0])),
                                              Positioned(
                                                  left: _ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckkAni,
                                                  top: 0,
                                                  child: _rubicPb(
                                                      warna: _colRub[1])),
                                              Positioned(
                                                  left: _ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckkAni,
                                                  top: 0,
                                                  child: _rubicPb(
                                                      warna: _colRub[2])),
                                              //Tengah
                                              Positioned(
                                                  left: _ghost + _ckkAni1,
                                                  top: _ghost / 8 + 10,
                                                  child: _rubicPb(
                                                      warna: _colRub[3])),
                                              Positioned(
                                                  left: _ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckkAni1,
                                                  top: _ghost / 8 + 10,
                                                  child: _rubicPb(
                                                      warna: _colRub[4])),
                                              Positioned(
                                                  left: _ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckkAni1,
                                                  top: _ghost / 8 + 10,
                                                  child: _rubicPb(
                                                      warna: _colRub[5])),
                                              //bawah
                                              Positioned(
                                                  left: _ghost + _ckkAni2,
                                                  top: 2 * _ghost / 8 + 20,
                                                  child: _rubicPb(
                                                      warna: _colRub[6])),
                                              Positioned(
                                                  left: _ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckkAni2,
                                                  top: 2 * _ghost / 8 + 20,
                                                  child: _rubicPb(
                                                      warna: _colRub[7])),
                                              Positioned(
                                                  left: _ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckkAni2,
                                                  top: 2 * _ghost / 8 + 20,
                                                  child: _rubicPb(
                                                      warna: _colRub[8])),

                                              //Rotasi Bawah
                                              Positioned(
                                                  left: (2 * _ghost / 8 + 20),
                                                  top: _ghost - _ckcAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[35])),
                                              Positioned(
                                                  left: (2 * _ghost / 8 + 20),
                                                  top: _ghost +
                                                      (_ghost / 8 + 10) -
                                                      _ckcAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[34])),
                                              Positioned(
                                                  left: (2 * _ghost / 8 + 20),
                                                  top: _ghost +
                                                      (2 * _ghost / 8 + 20) -
                                                      _ckcAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[33])),

                                              //Rotasi Atas
                                              Positioned(
                                                  left: (2 * _ghost / 8 + 20),
                                                  top: -_ghost - (_ckcAni),
                                                  child: _rubicPb(
                                                      warna: _colRub[17])),
                                              Positioned(
                                                  left: (2 * _ghost / 8 + 20),
                                                  top: -_ghost +
                                                      (_ghost / 8 + 10) -
                                                      (_ckcAni),
                                                  child: _rubicPb(
                                                      warna: _colRub[16])),
                                              Positioned(
                                                  left: (2 * _ghost / 8 + 20),
                                                  top: -_ghost +
                                                      (2 * _ghost / 8 + 20) -
                                                      _ckcAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[15])),

                                              // Cube Asli
                                              Positioned(
                                                  left: 0 + _ckkAni,
                                                  top: 0,
                                                  child: _rubicPb(
                                                      warna: _colRub[38])),
                                              Positioned(
                                                left: _ghost / 8 + 10 + _ckkAni,
                                                top: 0,
                                                child: _rubicPb(
                                                    warna: _colRub[41]),
                                              ),
                                              Positioned(
                                                  left: (2 * _ghost / 8 + 20) +
                                                      _ckkAni,
                                                  top: 0 - _ckcAni,
                                                  child: _rubicPb(
                                                    warna: _colRub[44],
                                                  )),
                                              //_______________________++++++++++++++++++++++++++_____________________//
                                              Positioned(
                                                  left: 0 + _ckkAni1,
                                                  top: _ghost / 8 + 10,
                                                  child: _rubicPb(
                                                      warna: _colRub[37])),
                                              Positioned(
                                                  left: _ghost / 8 +
                                                      10 +
                                                      _ckkAni1,
                                                  top: _ghost / 8 + 10,
                                                  child: _rubicPb(
                                                      warna: _colRub[40])),
                                              Positioned(
                                                  left: 2 * _ghost / 8 +
                                                      20 +
                                                      _ckkAni1,
                                                  top:
                                                      _ghost / 8 + 10 - _ckcAni,
                                                  child: _rubicPb(
                                                    warna: _colRub[43],
                                                  )),
                                              //_______________________++++++++++++++++++++++++++_____________________//
                                              Positioned(
                                                  left: 0 + _ckkAni2,
                                                  top: 2 * _ghost / 8 + 20,
                                                  child: _rubicPb(
                                                      warna: _colRub[36])),
                                              Positioned(
                                                  left: _ghost / 8 +
                                                      10 +
                                                      _ckkAni2,
                                                  top: 2 * _ghost / 8 + 20,
                                                  child: _rubicPb(
                                                      warna: _colRub[39])),
                                              Positioned(
                                                  left: 2 * _ghost / 8 +
                                                      20 +
                                                      _ckkAni2,
                                                  top: 2 * _ghost / 8 +
                                                      20 -
                                                      _ckcAni,
                                                  child: _rubicPb(
                                                    warna: _colRub[42],
                                                  )),
                                            ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //+++++++++++++L-L**********KIRI**********J-J+++++++++++++++++
                                //+++++++++++++L-L**********KANAN*********J-J+++++++++++++++++
                                Positioned(
                                  top: MediaQuery.of(context).size.height / 4,
                                  right:
                                      (MediaQuery.of(context).size.width < 500)
                                          ? 5
                                          : 50,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (DateTime.now().isAfter(sabar.add(
                                          const Duration(milliseconds: 800)))) {
                                        _invasionUpD(down: false);
                                        _invasionCenterH(down: false);
                                        _invasionDownD(down: false);
                                        sabar = DateTime.now();
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        Transform.rotate(
                                          angle: -_rotAniK,
                                          child: Container(
                                            height: _ghost,
                                            width: _ghost,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Transform.rotate(
                                          angle: -_bgra1,
                                          child: Container(
                                            height: _ghost,
                                            width: _ghost,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Transform.rotate(
                                          angle: _rotAniKa,
                                          child: SizedBox(
                                            height: _ghost,
                                            width: _ghost,
                                            child: Stack(children: [
                                              //Precube Kiri
                                              //Atas
                                              Positioned(
                                                  left: -_ghost + _ckkAni,
                                                  top: 0,
                                                  child: _rubicPb(
                                                      warna: _colRub[0])),
                                              Positioned(
                                                  left: -_ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckkAni,
                                                  top: 0,
                                                  child: _rubicPb(
                                                      warna: _colRub[1])),
                                              Positioned(
                                                  left: -_ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckkAni,
                                                  top: 0,
                                                  child: _rubicPb(
                                                      warna: _colRub[2])),
                                              //Tengah
                                              Positioned(
                                                  left: -_ghost + _ckkAni1,
                                                  top: _ghost / 8 + 10,
                                                  child: _rubicPb(
                                                      warna: _colRub[3])),
                                              Positioned(
                                                  left: -_ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckkAni1,
                                                  top: _ghost / 8 + 10,
                                                  child: _rubicPb(
                                                      warna: _colRub[4])),
                                              Positioned(
                                                  left: -_ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckkAni1,
                                                  top: _ghost / 8 + 10,
                                                  child: _rubicPb(
                                                      warna: _colRub[5])),
                                              //bawah
                                              Positioned(
                                                  left: -_ghost + _ckkAni2,
                                                  top: 2 * _ghost / 8 + 20,
                                                  child: _rubicPb(
                                                      warna: _colRub[6])),
                                              Positioned(
                                                  left: -_ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckkAni2,
                                                  top: 2 * _ghost / 8 + 20,
                                                  child: _rubicPb(
                                                      warna: _colRub[7])),
                                              Positioned(
                                                  left: -_ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckkAni2,
                                                  top: 2 * _ghost / 8 + 20,
                                                  child: _rubicPb(
                                                      warna: _colRub[8])),

                                              //Precube Kanan
                                              //Kanan
                                              Positioned(
                                                  left: _ghost + _ckkAni,
                                                  top: 0,
                                                  child: _rubicPb(
                                                      warna: _colRub[53])),
                                              Positioned(
                                                  left: _ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckkAni,
                                                  top: 0,
                                                  child: _rubicPb(
                                                      warna: _colRub[52])),
                                              Positioned(
                                                  left: _ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckkAni,
                                                  top: 0,
                                                  child: _rubicPb(
                                                      warna: _colRub[51])),
                                              //Tengah
                                              Positioned(
                                                  left: _ghost + _ckkAni1,
                                                  top: _ghost / 8 + 10,
                                                  child: _rubicPb(
                                                      warna: _colRub[50])),
                                              Positioned(
                                                  left: _ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckkAni1,
                                                  top: _ghost / 8 + 10,
                                                  child: _rubicPb(
                                                      warna: _colRub[49])),
                                              Positioned(
                                                  left: _ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckkAni1,
                                                  top: _ghost / 8 + 10,
                                                  child: _rubicPb(
                                                      warna: _colRub[48])),
                                              //bawah
                                              Positioned(
                                                  left: _ghost + _ckkAni2,
                                                  top: 2 * _ghost / 8 + 20,
                                                  child: _rubicPb(
                                                      warna: _colRub[47])),
                                              Positioned(
                                                  left: _ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckkAni2,
                                                  top: 2 * _ghost / 8 + 20,
                                                  child: _rubicPb(
                                                      warna: _colRub[46])),
                                              Positioned(
                                                  left: _ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckkAni2,
                                                  top: 2 * _ghost / 8 + 20,
                                                  child: _rubicPb(
                                                      warna: _colRub[45])),

                                              //Rotasi Bawah
                                              Positioned(
                                                  left: 0,
                                                  top: _ghost + _ckcAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[33])),
                                              Positioned(
                                                  left: 0,
                                                  top: _ghost +
                                                      (_ghost / 8 + 10) +
                                                      _ckcAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[34])),
                                              Positioned(
                                                  left: 0,
                                                  top: _ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckcAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[35])),

                                              //Rotasi Atas
                                              Positioned(
                                                  left: 0,
                                                  top: -_ghost + (_ckcAni),
                                                  child: _rubicPb(
                                                      warna: _colRub[15])),
                                              Positioned(
                                                  left: 0,
                                                  top: -_ghost +
                                                      (_ghost / 8 + 10) +
                                                      (_ckcAni),
                                                  child: _rubicPb(
                                                      warna: _colRub[16])),
                                              Positioned(
                                                  left: 0,
                                                  top: -_ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckcAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[17])),

                                              // Cube Asli
                                              Positioned(
                                                  left: 0 + _ckkAni,
                                                  top: 0 + _ckcAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[24])),
                                              Positioned(
                                                left: _ghost / 8 + 10 + _ckkAni,
                                                top: 0,
                                                child: _rubicPb(
                                                    warna: _colRub[21]),
                                              ),
                                              Positioned(
                                                  left: (2 * _ghost / 8 + 20) +
                                                      _ckkAni,
                                                  top: 0,
                                                  child: _rubicPb(
                                                    warna: _colRub[18],
                                                  )),
                                              //_______________________++++++++++++++++++++++++++_____________________//
                                              Positioned(
                                                  left: 0 + _ckkAni1,
                                                  top:
                                                      _ghost / 8 + 10 + _ckcAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[25])),
                                              Positioned(
                                                  left: _ghost / 8 +
                                                      10 +
                                                      _ckkAni1,
                                                  top: _ghost / 8 + 10,
                                                  child: _rubicPb(
                                                      warna: _colRub[22])),
                                              Positioned(
                                                  left: 2 * _ghost / 8 +
                                                      20 +
                                                      _ckkAni1,
                                                  top: _ghost / 8 + 10,
                                                  child: _rubicPb(
                                                    warna: _colRub[19],
                                                  )),
                                              //_______________________++++++++++++++++++++++++++_____________________//
                                              Positioned(
                                                  left: 0 + _ckkAni2,
                                                  top: 2 * _ghost / 8 +
                                                      20 +
                                                      _ckcAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[26])),
                                              Positioned(
                                                  left: _ghost / 8 +
                                                      10 +
                                                      _ckkAni2,
                                                  top: 2 * _ghost / 8 + 20,
                                                  child: _rubicPb(
                                                      warna: _colRub[23])),
                                              Positioned(
                                                  left: 2 * _ghost / 8 +
                                                      20 +
                                                      _ckkAni2,
                                                  top: 2 * _ghost / 8 + 20,
                                                  child: _rubicPb(
                                                    warna: _colRub[20],
                                                  )),
                                            ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //+++++++++++++L-L**********KANAN**********J-J+++++++++++++++++
                                //+++++++++++++L-L**********BAWAH*********J-J+++++++++++++++++
                                Positioned(
                                  bottom: 30,
                                  left:
                                      (MediaQuery.of(context).size.width < 500)
                                          ? 175
                                          : 225,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (DateTime.now().isAfter(sabar.add(
                                          const Duration(milliseconds: 800)))) {
                                        _invasionRightD(down: false);
                                        _invasionCenterV(down: false);
                                        _invasionLeftD(down: false);
                                        sabar = DateTime.now();
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        Transform.rotate(
                                          angle: -_rotAniA,
                                          child: Container(
                                            height: _ghost,
                                            width: _ghost,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Transform.rotate(
                                          angle: -_bgra,
                                          child: Container(
                                            height: _ghost,
                                            width: _ghost,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Transform.rotate(
                                          angle: _rotAniB,
                                          child: SizedBox(
                                            height: _ghost,
                                            width: _ghost,
                                            child: Stack(children: [
                                              //Precube Atas
                                              //Kanan
                                              Positioned(
                                                  left: 2 * _ghost / 8 + 20,
                                                  top: -_ghost + _ckaAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[2])),
                                              Positioned(
                                                  left: 2 * _ghost / 8 + 20,
                                                  top: -_ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckaAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[5])),
                                              Positioned(
                                                  left: 2 * _ghost / 8 + 20,
                                                  top: -_ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckaAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[8])),
                                              //Tengah
                                              Positioned(
                                                  left: _ghost / 8 + 10,
                                                  top: -_ghost + _ckaAni1,
                                                  child: _rubicPb(
                                                      warna: _colRub[1])),
                                              Positioned(
                                                  left: _ghost / 8 + 10,
                                                  top: -_ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckaAni1,
                                                  child: _rubicPb(
                                                      warna: _colRub[4])),
                                              Positioned(
                                                  left: _ghost / 8 + 10,
                                                  top: -_ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckaAni1,
                                                  child: _rubicPb(
                                                      warna: _colRub[7])),
                                              //kiri
                                              Positioned(
                                                  left: 0,
                                                  top: -_ghost + _ckaAni2,
                                                  child: _rubicPb(
                                                      warna: _colRub[0])),
                                              Positioned(
                                                  left: 0,
                                                  top: -_ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckaAni2,
                                                  child: _rubicPb(
                                                      warna: _colRub[3])),
                                              Positioned(
                                                  left: 0,
                                                  top: -_ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckaAni2,
                                                  child: _rubicPb(
                                                      warna: _colRub[6])),

                                              //Precube Bawah
                                              //Kanan
                                              Positioned(
                                                  left: 2 * _ghost / 8 + 20,
                                                  top: _ghost + _ckaAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[47])),
                                              Positioned(
                                                  left: 2 * _ghost / 8 + 20,
                                                  top: _ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckaAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[50])),
                                              Positioned(
                                                  left: 2 * _ghost / 8 + 20,
                                                  top: _ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckaAni,
                                                  child: _rubicPb(
                                                      warna: _colRub[53])),
                                              //Tengah
                                              Positioned(
                                                  left: _ghost / 8 + 10,
                                                  top: _ghost + _ckaAni1,
                                                  child: _rubicPb(
                                                      warna: _colRub[46])),
                                              Positioned(
                                                  left: _ghost / 8 + 10,
                                                  top: _ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckaAni1,
                                                  child: _rubicPb(
                                                      warna: _colRub[49])),
                                              Positioned(
                                                  left: _ghost / 8 + 10,
                                                  top: _ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckaAni1,
                                                  child: _rubicPb(
                                                      warna: _colRub[52])),
                                              //Kiri
                                              Positioned(
                                                  left: 0,
                                                  top: _ghost + _ckaAni2,
                                                  child: _rubicPb(
                                                      warna: _colRub[45])),
                                              Positioned(
                                                  left: 0,
                                                  top: _ghost +
                                                      _ghost / 8 +
                                                      10 +
                                                      _ckaAni2,
                                                  child: _rubicPb(
                                                      warna: _colRub[48])),
                                              Positioned(
                                                  left: 0,
                                                  top: _ghost +
                                                      (2 * _ghost / 8 + 20) +
                                                      _ckaAni2,
                                                  child: _rubicPb(
                                                      warna: _colRub[51])),

                                              //Rotasi Kiri
                                              Positioned(
                                                  left: -_ghost - _ckcAni,
                                                  top: 0,
                                                  child: _rubicPb(
                                                      warna: _colRub[44])),
                                              Positioned(
                                                  left: -_ghost +
                                                      _ghost / 8 +
                                                      10 -
                                                      _ckcAni,
                                                  top: 0,
                                                  child: _rubicPb(
                                                      warna: _colRub[43])),
                                              Positioned(
                                                  left: -_ghost +
                                                      (2 * _ghost / 8 + 20) -
                                                      _ckcAni,
                                                  top: 0,
                                                  child: _rubicPb(
                                                      warna: _colRub[42])),

                                              //Rotasi Kanan
                                              Positioned(
                                                  left: _ghost - _ckcAni,
                                                  top: 0,
                                                  child: _rubicPb(
                                                      warna: _colRub[26])),
                                              Positioned(
                                                  left: (_ghost +
                                                          _ghost / 8 +
                                                          10) -
                                                      _ckcAni,
                                                  top: 0,
                                                  child: _rubicPb(
                                                      warna: _colRub[25])),
                                              Positioned(
                                                  left: _ghost +
                                                      (2 * _ghost / 8 + 20) -
                                                      _ckcAni,
                                                  top: 0,
                                                  child: _rubicPb(
                                                      warna: _colRub[24])),

                                              // Cube Asli
                                              Positioned(
                                                  left: 0 - _ckcAni,
                                                  top: 0 + _ckaAni2,
                                                  child: _rubicPb(
                                                      warna: _colRub[35])),
                                              Positioned(
                                                left: _ghost / 8 + 10 - _ckcAni,
                                                top: 0 + _ckaAni1,
                                                child: _rubicPb(
                                                    warna: _colRub[34]),
                                              ),
                                              Positioned(
                                                  left: (2 * _ghost / 8 + 20) -
                                                      _ckcAni,
                                                  top: 0 + _ckaAni,
                                                  child: _rubicPb(
                                                    warna: _colRub[33],
                                                  )),
                                              //_______________________++++++++++++++++++++++++++_____________________//
                                              Positioned(
                                                  left: 0,
                                                  top: _ghost / 8 +
                                                      10 +
                                                      _ckaAni2,
                                                  child: _rubicPb(
                                                      warna: _colRub[32])),
                                              Positioned(
                                                  left: _ghost / 8 + 10,
                                                  top: _ghost / 8 +
                                                      10 +
                                                      _ckaAni1,
                                                  child: _rubicPb(
                                                      warna: _colRub[31])),
                                              Positioned(
                                                  left: 2 * _ghost / 8 + 20,
                                                  top:
                                                      _ghost / 8 + 10 + _ckaAni,
                                                  child: _rubicPb(
                                                    warna: _colRub[30],
                                                  )),
                                              //_______________________++++++++++++++++++++++++++_____________________//
                                              Positioned(
                                                  left: 0,
                                                  top: 2 * _ghost / 8 +
                                                      20 +
                                                      _ckaAni2,
                                                  child: _rubicPb(
                                                      warna: _colRub[29])),
                                              Positioned(
                                                  left: _ghost / 8 + 10,
                                                  top: 2 * _ghost / 8 +
                                                      20 +
                                                      _ckaAni1,
                                                  child: _rubicPb(
                                                      warna: _colRub[28])),
                                              Positioned(
                                                  left: 2 * _ghost / 8 + 20,
                                                  top: 2 * _ghost / 8 +
                                                      20 +
                                                      _ckaAni,
                                                  child: _rubicPb(
                                                    warna: _colRub[27],
                                                  )),
                                            ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //+++++++++++++L-L**********BAWAH*********J-J+++++++++++++++++
                                Positioned(
                                  top: 100,
                                  left:
                                      (MediaQuery.of(context).size.width < 500)
                                          ? 80
                                          : 130,
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(left: 0.5),
                                        height: _bg,
                                        width: _bg,
                                        color: Colors.black,
                                      ),
                                      Transform.rotate(
                                        angle: _angles,
                                        child: SizedBox(
                                          height: _ukuran,
                                          width: _ukuran,
                                          child: Stack(children: [
                                            //Precube Kanan
                                            //Atas Kanan
                                            Positioned(
                                                left: _ukuran + _uAni,
                                                top: 0,
                                                child: _rubicPc(
                                                    warna: _getWarnaKanan(1))),
                                            Positioned(
                                                left: _ukuran +
                                                    _ukuran / 3.4 +
                                                    9 +
                                                    _uAni,
                                                top: 0,
                                                child: _rubicPc(
                                                    warna: _getWarnaKanan(2))),
                                            Positioned(
                                              left: _ukuran +
                                                  (2 * _ukuran / 3.4 + 18) +
                                                  _uAni,
                                              top: 0,
                                              child: _rubicPc(
                                                  warna: _getWarnaKanan(3)),
                                            ),
                                            //Kanan Tengah
                                            Positioned(
                                                left: _ukuran + _cHAni,
                                                top: _ukuran / 3.4 + 9,
                                                child: _rubicPc(
                                                    warna: _getWarnaTengahH(1,
                                                        balik: true))),
                                            Positioned(
                                                left: _ukuran +
                                                    _ukuran / 3.4 +
                                                    9 +
                                                    _cHAni,
                                                top: _ukuran / 3.4 + 9,
                                                child: _rubicPc(
                                                    warna: _getWarnaTengahH(2,
                                                        balik: true))),
                                            Positioned(
                                                left: _ukuran +
                                                    (2 * _ukuran / 3.4 + 18) +
                                                    _cHAni,
                                                top: _ukuran / 3.4 + 9,
                                                child: _rubicPc(
                                                    warna: _getWarnaTengahH(3,
                                                        balik: true))),
                                            //Bawah kanan
                                            Positioned(
                                                left: _ukuran + _dAni,
                                                top: 2 * _ukuran / 3.4 + 18,
                                                child: _rubicPc(
                                                    warna: _getWarnaKanan(1,
                                                        bawah: true))),
                                            Positioned(
                                                left: _ukuran +
                                                    _ukuran / 3.4 +
                                                    9 +
                                                    _dAni,
                                                top: 2 * _ukuran / 3.4 + 18,
                                                child: _rubicPc(
                                                    warna: _getWarnaKanan(2,
                                                        bawah: true))),
                                            Positioned(
                                                left: _ukuran +
                                                    (2 * _ukuran / 3.4 + 18) +
                                                    _dAni,
                                                top: 2 * _ukuran / 3.4 + 18,
                                                child: _rubicPc(
                                                    warna: _getWarnaKanan(3,
                                                        bawah: true))),
                                            //Precube kiri
                                            //Atas Kiri
                                            Positioned(
                                                left: -_ukuran + _uAni,
                                                top: 0,
                                                child: _rubicPc(
                                                    warna: _getWarnaKiri(1))),
                                            Positioned(
                                                left: -_ukuran +
                                                    _ukuran / 3.4 +
                                                    9 +
                                                    _uAni,
                                                top: 0,
                                                child: _rubicPc(
                                                    warna: _getWarnaKiri(2))),
                                            Positioned(
                                                left: -_ukuran +
                                                    (2 * _ukuran / 3.4 + 18) +
                                                    _uAni,
                                                top: 0,
                                                child: _rubicPc(
                                                    warna: _getWarnaKiri(3))),
                                            //Kiri Tengah
                                            Positioned(
                                                left: -_ukuran + _cHAni,
                                                top: _ukuran / 3.4 + 9,
                                                child: _rubicPc(
                                                    warna:
                                                        _getWarnaTengahH(1))),
                                            Positioned(
                                                left: -_ukuran +
                                                    _ukuran / 3.4 +
                                                    9 +
                                                    _cHAni,
                                                top: _ukuran / 3.4 + 9,
                                                child: _rubicPc(
                                                    warna:
                                                        _getWarnaTengahH(2))),
                                            Positioned(
                                                left: -_ukuran +
                                                    (2 * _ukuran / 3.4 + 18) +
                                                    _cHAni,
                                                top: _ukuran / 3.4 + 9,
                                                child: _rubicPc(
                                                    warna:
                                                        _getWarnaTengahH(3))),
                                            //Bawah kiri
                                            Positioned(
                                                left: -_ukuran + _dAni,
                                                top: 2 * _ukuran / 3.4 + 18,
                                                child: _rubicPc(
                                                    warna: _getWarnaKiri(1,
                                                        bawah: true))),
                                            Positioned(
                                                left: -_ukuran +
                                                    _ukuran / 3.4 +
                                                    9 +
                                                    _dAni,
                                                top: 2 * _ukuran / 3.4 + 18,
                                                child: _rubicPc(
                                                    warna: _getWarnaKiri(2,
                                                        bawah: true))),
                                            Positioned(
                                                left: -_ukuran +
                                                    (2 * _ukuran / 3.4 + 18) +
                                                    _dAni,
                                                top: 2 * _ukuran / 3.4 + 18,
                                                child: _rubicPc(
                                                    warna: _getWarnaKiri(3,
                                                        bawah: true))),
                                            //Precube Atas
                                            //Kanan
                                            Positioned(
                                                left: 2 * _ukuran / 3.4 + 18,
                                                top: -_ukuran + _rAni,
                                                child: _rubicPc(
                                                    warna: _getWarnaAtas(1))),
                                            Positioned(
                                                left: 2 * _ukuran / 3.4 + 18,
                                                top: -_ukuran +
                                                    _ukuran / 3.4 +
                                                    9 +
                                                    _rAni,
                                                child: _rubicPc(
                                                    warna: _getWarnaAtas(2))),
                                            Positioned(
                                                left: 2 * _ukuran / 3.4 + 18,
                                                top: -_ukuran +
                                                    (2 * _ukuran / 3.4 + 18) +
                                                    _rAni,
                                                child: _rubicPc(
                                                    warna: _getWarnaAtas(3))),
                                            //Tengah
                                            Positioned(
                                                left: _ukuran / 3.4 + 9,
                                                top: -_ukuran + _cVAni,
                                                child: _rubicPc(
                                                    warna:
                                                        _getWarnaTengahV(1))),
                                            Positioned(
                                                left: _ukuran / 3.4 + 9,
                                                top: -_ukuran +
                                                    _ukuran / 3.4 +
                                                    9 +
                                                    _cVAni,
                                                child: _rubicPc(
                                                    warna:
                                                        _getWarnaTengahV(2))),
                                            Positioned(
                                                left: _ukuran / 3.4 + 9,
                                                top: -_ukuran +
                                                    (2 * _ukuran / 3.4 + 18) +
                                                    _cVAni,
                                                child: _rubicPc(
                                                    warna:
                                                        _getWarnaTengahV(3))),
                                            //kiri
                                            Positioned(
                                                left: 0,
                                                top: -_ukuran + _lAni,
                                                child: _rubicPc(
                                                    warna: _getWarnaAtas(1,
                                                        kiri: true))),
                                            Positioned(
                                                left: 0,
                                                top: -_ukuran +
                                                    _ukuran / 3.4 +
                                                    9 +
                                                    _lAni,
                                                child: _rubicPc(
                                                    warna: _getWarnaAtas(2,
                                                        kiri: true))),
                                            Positioned(
                                                left: 0,
                                                top: -_ukuran +
                                                    (2 * _ukuran / 3.4 + 18) +
                                                    _lAni,
                                                child: _rubicPc(
                                                    warna: _getWarnaAtas(3,
                                                        kiri: true))),

                                            //Precube Bawah
                                            //Kanan
                                            Positioned(
                                                left: 2 * _ukuran / 3.4 + 18,
                                                top: _ukuran + _rAni,
                                                child: _rubicPc(
                                                    warna: _getWarnaBawah(1))),
                                            Positioned(
                                                left: 2 * _ukuran / 3.4 + 18,
                                                top: _ukuran +
                                                    _ukuran / 3.4 +
                                                    9 +
                                                    _rAni,
                                                child: _rubicPc(
                                                    warna: _getWarnaBawah(2))),
                                            Positioned(
                                                left: 2 * _ukuran / 3.4 + 18,
                                                top: _ukuran +
                                                    (2 * _ukuran / 3.4 + 18) +
                                                    _rAni,
                                                child: _rubicPc(
                                                    warna: _getWarnaBawah(3))),
                                            //Tengah
                                            Positioned(
                                                left: _ukuran / 3.4 + 9,
                                                top: _ukuran + _cVAni,
                                                child: _rubicPc(
                                                    warna: _getWarnaTengahV(1,
                                                        balik: true))),
                                            Positioned(
                                                left: _ukuran / 3.4 + 9,
                                                top: _ukuran +
                                                    _ukuran / 3.4 +
                                                    9 +
                                                    _cVAni,
                                                child: _rubicPc(
                                                    warna: _getWarnaTengahV(2,
                                                        balik: true))),
                                            Positioned(
                                                left: _ukuran / 3.4 + 9,
                                                top: _ukuran +
                                                    (2 * _ukuran / 3.4 + 18) +
                                                    _cVAni,
                                                child: _rubicPc(
                                                    warna: _getWarnaTengahV(3,
                                                        balik: true))),
                                            //Kiri
                                            Positioned(
                                                left: 0,
                                                top: _ukuran + _lAni,
                                                child: _rubicPc(
                                                    warna: _getWarnaBawah(1,
                                                        kiri: true))),
                                            Positioned(
                                                left: 0,
                                                top: _ukuran +
                                                    _ukuran / 3.4 +
                                                    9 +
                                                    _lAni,
                                                child: _rubicPc(
                                                    warna: _getWarnaBawah(2,
                                                        kiri: true))),
                                            Positioned(
                                                left: 0,
                                                top: _ukuran +
                                                    (2 * _ukuran / 3.4 + 18) +
                                                    _lAni,
                                                child: _rubicPc(
                                                    warna: _getWarnaBawah(3,
                                                        kiri: true))),
                                            // Cube Asli
                                            Positioned(
                                                left: 0 + _uAni,
                                                top: 0 + _lAni,
                                                child: GestureDetector(
                                                  onPanUpdate: (details) {
                                                    if (details.delta.dx < -2) {
                                                      _lessCounter();
                                                    }
                                                    if (details.delta.dy > 2) {
                                                      _lessCounter();
                                                    }
                                                    if (details.delta.dx > 2) {
                                                      _incrementCounter();
                                                    }
                                                  },
                                                  child: _rubicPc(
                                                      warna: _colRub[0]),
                                                )),
                                            Positioned(
                                              left: _ukuran / 3.4 + 9 + _uAni,
                                              top: 0 + _cVAni,
                                              child: GestureDetector(
                                                  onPanUpdate: (details) {
                                                    if (details.delta.dx < -2) {
                                                      _invasionUpD(down: false);
                                                    }
                                                    if (details.delta.dx > 2) {
                                                      _invasionUpD();
                                                    }
                                                  },
                                                  child: _rubicPc(
                                                      warna: _colRub[1])),
                                            ),
                                            Positioned(
                                                left: (2 * _ukuran / 3.4 + 18) +
                                                    _uAni,
                                                top: 0 + _rAni,
                                                child: GestureDetector(
                                                  onPanUpdate: (details) {
                                                    if (details.delta.dy < -2) {
                                                      _lessCounter();
                                                    }
                                                    if (details.delta.dx < -2) {
                                                      _lessCounter();
                                                    }
                                                    if (details.delta.dy > 2) {
                                                      _incrementCounter();
                                                    }
                                                  },
                                                  child: _rubicPc(
                                                    warna: _colRub[2],
                                                  ),
                                                )),
                                            //_______________________++++++++++++++++++++++++++_____________________//
                                            Positioned(
                                                left: 0 + _cHAni,
                                                top: _ukuran / 3.4 + 9 + _lAni,
                                                child: GestureDetector(
                                                    onPanUpdate: (details) {
                                                      if (details.delta.dy <
                                                          -2) {
                                                        _invasionLeftD(
                                                            down: false);
                                                      }
                                                      if (details.delta.dy >
                                                          2) {
                                                        _invasionLeftD();
                                                      }
                                                    },
                                                    child: _rubicPc(
                                                        warna: _colRub[3]))),
                                            Positioned(
                                                left:
                                                    _ukuran / 3.4 + 9 + _cHAni,
                                                top: _ukuran / 3.4 + 9 + _cVAni,
                                                child: GestureDetector(
                                                    onPanUpdate: (details) {
                                                      if (details.delta.dx <
                                                          -2) {
                                                        _invasionCenterH(
                                                            down: false);
                                                      }
                                                      if (details.delta.dx >
                                                          2) {
                                                        _invasionCenterH();
                                                      }
                                                      if (details.delta.dy <
                                                          -2) {
                                                        _invasionCenterV(
                                                            down: false);
                                                      }
                                                      if (details.delta.dy >
                                                          2) {
                                                        _invasionCenterV();
                                                      }
                                                    },
                                                    child: _rubicPc(
                                                        warna: _colRub[4]))),

                                            Positioned(
                                                left: 2 * _ukuran / 3.4 +
                                                    18 +
                                                    _cHAni,
                                                top: _ukuran / 3.4 + 9 + _rAni,
                                                child: GestureDetector(
                                                    onPanUpdate: (details) {
                                                      if (details.delta.dy <
                                                          -2) {
                                                        _invasionRightD(
                                                            down: false);
                                                      }
                                                      if (details.delta.dy >
                                                          2) {
                                                        _invasionRightD();
                                                      }
                                                    },
                                                    child: _rubicPc(
                                                      warna: _colRub[5],
                                                    ))),
                                            //_______________________++++++++++++++++++++++++++_____________________//
                                            Positioned(
                                                left: 0 + _dAni,
                                                top: 2 * _ukuran / 3.4 +
                                                    18 +
                                                    _lAni,
                                                child: GestureDetector(
                                                  onPanUpdate: (details) {
                                                    if (details.delta.dy < -2) {
                                                      _incrementCounter();
                                                    }
                                                    if (details.delta.dy > 2) {
                                                      _lessCounter();
                                                    }
                                                    if (details.delta.dx > 2) {
                                                      _lessCounter();
                                                    }
                                                  },
                                                  child: _rubicPc(
                                                      warna: _colRub[6]),
                                                )),
                                            Positioned(
                                                left: _ukuran / 3.4 + 9 + _dAni,
                                                top: 2 * _ukuran / 3.4 +
                                                    18 +
                                                    _cVAni,
                                                child: GestureDetector(
                                                    onPanUpdate: (details) {
                                                      if (details.delta.dx <
                                                          -2) {
                                                        _invasionDownD(
                                                            down: false);
                                                      }
                                                      if (details.delta.dx >
                                                          2) {
                                                        _invasionDownD();
                                                      }
                                                    },
                                                    child: _rubicPc(
                                                        warna: _colRub[7]))),
                                            Positioned(
                                                left: 2 * _ukuran / 3.4 +
                                                    18 +
                                                    _dAni,
                                                top: 2 * _ukuran / 3.4 +
                                                    18 +
                                                    _rAni,
                                                child: GestureDetector(
                                                  onPanUpdate: (details) {
                                                    if (details.delta.dy < -2) {
                                                      _lessCounter();
                                                    }
                                                    if (details.delta.dy > 2) {
                                                      _incrementCounter();
                                                    }
                                                    if (details.delta.dx < -2) {
                                                      _incrementCounter();
                                                    }
                                                  },
                                                  child: _rubicPc(
                                                    warna: _colRub[8],
                                                  ),
                                                )),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                })),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.question_mark),
        ));
  }

  Color _getWarnaAtas(int pos, {bool kiri = false}) {
    if (pos == 1) {
      if (kiri) {
        return _colRub[9];
      }
      return _colRub[11];
    }
    if (pos == 2) {
      if (kiri) {
        return _colRub[12];
      }
      return _colRub[14];
    }
    if (pos == 3) {
      if (kiri) {
        return _colRub[15];
      }
      return _colRub[17];
    }

    return Colors.black;
  }

  Color _getWarnaBawah(int pos, {bool kiri = false}) {
    if (pos == 1) {
      if (kiri) {
        return _colRub[35];
      }
      return _colRub[33];
    }
    if (pos == 2) {
      if (kiri) {
        return _colRub[32];
      }
      return _colRub[30];
    }
    if (pos == 3) {
      if (kiri) {
        return _colRub[29];
      }
      return _colRub[27];
    }

    return Colors.black;
  }

  Color _getWarnaKanan(int pos, {bool bawah = false}) {
    if (pos == 1) {
      if (bawah) {
        return _colRub[26];
      }
      return _colRub[24];
    }
    if (pos == 2) {
      if (bawah) {
        return _colRub[23];
      }
      return _colRub[21];
    }
    if (pos == 3) {
      if (bawah) {
        return _colRub[20];
      }
      return _colRub[18];
    }

    return Colors.black;
  }

  Color _getWarnaKiri(int pos, {bool bawah = false}) {
    if (pos == 1) {
      if (bawah) {
        return _colRub[36];
      }
      return _colRub[38];
    }
    if (pos == 2) {
      if (bawah) {
        return _colRub[39];
      }
      return _colRub[41];
    }
    if (pos == 3) {
      if (bawah) {
        return _colRub[42];
      }
      return _colRub[44];
    }

    return Colors.black;
  }

  Color _getWarnaTengahH(int pos, {bool balik = false}) {
    if (pos == 1) {
      if (balik) {
        return _colRub[25];
      }
      return _colRub[37];
    }
    if (pos == 2) {
      if (balik) {
        return _colRub[22];
      }
      return _colRub[40];
    }
    if (pos == 3) {
      if (balik) {
        return _colRub[19];
      }
      return _colRub[43];
    }

    return Colors.black;
  }

  Color _getWarnaTengahV(int pos, {bool balik = false}) {
    if (pos == 1) {
      if (balik) {
        return _colRub[34];
      }
      return _colRub[10];
    }
    if (pos == 2) {
      if (balik) {
        return _colRub[31];
      }
      return _colRub[13];
    }
    if (pos == 3) {
      if (balik) {
        return _colRub[28];
      }
      return _colRub[16];
    }

    return Colors.black;
  }

  Container _rubicPc({Color warna = Colors.black}) {
    return Container(
      width: _ukuran / 2.98,
      height: _ukuran / 2.98,
      color: Colors.black,
      padding: const EdgeInsets.all(8),
      child: Container(
        color: warna,
      ),
    );
  }

  Container _rubicPb({Color warna = Colors.black}) {
    return Container(
      width: _ghost / 2.9,
      height: _ghost / 2.9,
      color: Colors.black,
      padding: const EdgeInsets.all(2),
      child: Container(
        color: warna,
      ),
    );
  }
}
