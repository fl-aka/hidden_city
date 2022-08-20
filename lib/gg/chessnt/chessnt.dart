import 'package:flutter/material.dart';
import 'package:ta_uniska_bjm/gg/chessnt/pieces.dart';

class Chessnt extends StatefulWidget {
  const Chessnt({super.key});

  @override
  State<Chessnt> createState() => _ChessntState();
}

class _ChessntState extends State<Chessnt> {
  bool _wmove = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: Center(
        child: Stack(
          children: [
            MagicContainer(
              wmove: _wmove,
              boolC: (x) {
                setState(() {
                  _wmove = x;
                });
              },
            ),
            Positioned(
                right: 20,
                bottom: 100,
                child: ElevatedButton(
                  child: const Icon(Icons.restore),
                  onPressed: () {
                    setState(() {});
                    // if (_wmove) {
                    //   _wmove = false;
                    // } else {
                    //   _wmove = true;
                    // }
                    // setState(() {});
                  },
                ))
          ],
        ),
      ),
    );
  }
}

typedef BoolC = void Function(bool x);

class MagicContainer extends StatefulWidget {
  const MagicContainer({super.key, required this.wmove, required this.boolC});
  final bool wmove;
  final BoolC boolC;

  @override
  State<MagicContainer> createState() => _MagicContainerState();
}

class _MagicContainerState extends State<MagicContainer> {
  final List<Pieces> _wpos = [], _bpos = [];
  final List<Widget> _gridRow = [];
  double _rDpx = 0, _rDpy = 0;
  int? _selectedRow, _selectedCol, _selectedW, _selectedB;
  bool stillDrag = false;

  void begin() {
    _bpos.add(Pieces("Rook", 0, 7, img: "assets/img/bR.png"));
    _bpos.add(Pieces("Knight", 1, 7, img: "assets/img/bN.png"));
    _bpos.add(Pieces("Bishop", 2, 7, img: "assets/img/bB.png"));
    _bpos.add(Pieces("Queen", 3, 7, img: "assets/img/bK.png"));
    _bpos.add(Pieces("King", 4, 7, img: "assets/img/bQ.png"));
    _bpos.add(Pieces("Bishop", 5, 7, img: "assets/img/bB.png"));
    _bpos.add(Pieces("Knight", 6, 7, img: "assets/img/bN.png"));
    _bpos.add(Pieces("Rook", 7, 7, img: "assets/img/bR.png"));

    _bpos.add(Pieces("Pawn", 0, 6, img: "assets/img/bP.png"));
    _bpos.add(Pieces("Pawn", 1, 6, img: "assets/img/bP.png"));
    _bpos.add(Pieces("Pawn", 2, 6, img: "assets/img/bP.png"));
    _bpos.add(Pieces("Pawn", 3, 6, img: "assets/img/bP.png"));
    _bpos.add(Pieces("Pawn", 4, 6, img: "assets/img/bP.png"));
    _bpos.add(Pieces("Pawn", 5, 6, img: "assets/img/bP.png"));
    _bpos.add(Pieces("Pawn", 6, 6, img: "assets/img/bP.png"));
    _bpos.add(Pieces("Pawn", 7, 6, img: "assets/img/bP.png"));

    _wpos.add(Pieces("Pawn", 0, 1, img: "assets/img/wP.png"));
    _wpos.add(Pieces("Pawn", 1, 1, img: "assets/img/wP.png"));
    _wpos.add(Pieces("Pawn", 2, 1, img: "assets/img/wP.png"));
    _wpos.add(Pieces("Pawn", 3, 1, img: "assets/img/wP.png"));
    _wpos.add(Pieces("Pawn", 4, 1, img: "assets/img/wP.png"));
    _wpos.add(Pieces("Pawn", 5, 1, img: "assets/img/wP.png"));
    _wpos.add(Pieces("Pawn", 6, 1, img: "assets/img/wP.png"));
    _wpos.add(Pieces("Pawn", 7, 1, img: "assets/img/wP.png"));

    _wpos.add(Pieces("Rook", 0, 0, img: "assets/img/wR.png"));
    _wpos.add(Pieces("Knight", 1, 0, img: "assets/img/wN.png"));
    _wpos.add(Pieces("Bishop", 2, 0, img: "assets/img/wB.png"));
    _wpos.add(Pieces("Queen", 3, 0, img: "assets/img/wK.png"));
    _wpos.add(Pieces("King", 4, 0, img: "assets/img/wQ.png"));
    _wpos.add(Pieces("Bishop", 5, 0, img: "assets/img/wB.png"));
    _wpos.add(Pieces("Knight", 6, 0, img: "assets/img/wN.png"));
    _wpos.add(Pieces("Rook", 7, 0, img: "assets/img/wR.png"));
  }

  @override
  void initState() {
    begin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(width: 320, height: 320, child: _makingBoard()));
  }

  Widget _makingBoard() {
    _gridRow.clear();
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        _gridRow.add(Positioned(
          left: j * 40,
          bottom: i * 40,
          child: GestureDetector(
              onTap: () {
                if (_selectedRow == j && _selectedCol == i) {
                  _selectedRow = null;
                  _selectedCol = null;
                } else {
                  _selectedRow = j;
                  _selectedCol = i;
                }
                _selectedB = null;
                _selectedW = null;
                setState(() {});
              },
              child: _gridBuilder(j, i).container()),
        ));
      }
    }

    for (int i = 0; i < _bpos.length; i++) {
      _gridRow.add(AnimatedPositioned(
          left: _bpos[i].dx * 40,
          bottom: _bpos[i].dy * 40,
          duration: const Duration(milliseconds: 500),
          child: GestureDetector(
            onTap: () {
              if (_selectedRow == _bpos[i].dx && _selectedCol == _bpos[i].dy) {
                _selectedRow = null;
                _selectedCol = null;
                _selectedB = null;
              } else {
                _selectedRow = _bpos[i].dx;
                _selectedCol = _bpos[i].dy;
                _selectedB = i;
              }
              _selectedW = null;
              setState(() {});
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(_bpos[i].img))),
            ),
          )));
    }

    for (int i = 0; i < _wpos.length; i++) {
      _gridRow.add(AnimatedPositioned(
          left: _wpos[i].dx * 40,
          bottom: _wpos[i].dy * 40,
          duration: const Duration(milliseconds: 500),
          child: GestureDetector(
            onTap: () {
              if (_selectedRow == _wpos[i].dx && _selectedCol == _wpos[i].dy) {
                _selectedRow = null;
                _selectedCol = null;
                _selectedW = null;
              } else {
                _selectedRow = _wpos[i].dx;
                _selectedCol = _wpos[i].dy;
                _selectedW = i;
              }
              _selectedB = null;
              setState(() {});
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(_wpos[i].img))),
            ),
          )));
    }
    if (_selectedW != null) {
      String name = _wpos[_selectedW!].name;
      switch (name) {
        case 'Pawn':
          _pawnMove(true, _wpos, _bpos);
          break;
        case 'Knight':
          _knightMove(true, _wpos, _bpos);
          break;
        case 'Bishop':
          _bishopMove(true, _wpos, _bpos);
          break;
        case 'Rook':
          _rookMove(true, _wpos, _bpos);
          break;
        case 'Queen':
          _bishopMove(true, _wpos, _bpos);
          _rookMove(true, _wpos, _bpos);
          break;
        case 'King':
          _kingMove(true, _wpos, _bpos);
          break;
      }
    }

    if (_selectedB != null) {
      String name = _bpos[_selectedB!].name;
      switch (name) {
        case 'Pawn':
          _pawnMove(false, _bpos, _wpos);
          break;
        case 'Knight':
          _knightMove(false, _bpos, _wpos);
          break;
        case 'Bishop':
          _bishopMove(false, _bpos, _wpos);
          break;
        case 'Rook':
          _rookMove(false, _bpos, _wpos);
          break;
        case 'Queen':
          _bishopMove(false, _bpos, _wpos);
          _rookMove(false, _bpos, _wpos);
          break;
        case 'King':
          _kingMove(false, _bpos, _wpos);
          break;
      }
    }
    return Stack(children: _gridRow);
  }

  void _kingMove(bool white, List<Pieces> wpos, List<Pieces> bpos) {
    int updown = 1, selected;
    if (!white) {
      updown = -1;
      selected = _selectedB!;
    } else {
      selected = _selectedW!;
    }
    bool allyfront = false,
        allyfront2 = false,
        allyfront3 = false,
        allyleft = false,
        allyRight = false,
        allybehind = false,
        allybehind2 = false,
        allybehind3 = false;

    for (int i = 0; i < wpos.length; i++) {
      if (wpos[selected].dy + updown == wpos[i].dy &&
          wpos[selected].dx == wpos[i].dx) {
        allyfront = true;
      }
      if (wpos[selected].dy + updown == wpos[i].dy &&
          wpos[selected].dx - 1 == wpos[i].dx) {
        allyfront2 = true;
      }
      if (wpos[selected].dy + updown == wpos[i].dy &&
          wpos[selected].dx + 1 == wpos[i].dx) {
        allyfront3 = true;
      }

      if (wpos[selected].dy - updown == wpos[i].dy &&
          wpos[selected].dx == wpos[i].dx) {
        allybehind = true;
      }
      if (wpos[selected].dy - updown == wpos[i].dy &&
          wpos[selected].dx - 1 == wpos[i].dx) {
        allybehind2 = true;
      }
      if (wpos[selected].dy - updown == wpos[i].dy &&
          wpos[selected].dx + 1 == wpos[i].dx) {
        allybehind3 = true;
      }

      if (wpos[selected].dy == wpos[i].dy &&
          wpos[selected].dx - 1 == wpos[i].dx) {
        allyleft = true;
      }
      if (wpos[selected].dy == wpos[i].dy &&
          wpos[selected].dx + 1 == wpos[i].dx) {
        allyRight = true;
      }
    }

    if (!allyfront) {
      _gridRow.add(_greenDot(
          selected: selected,
          updown: updown,
          left: wpos[selected].dx * 40,
          bottom: (wpos[selected].dy + updown) * 40,
          onthetap: () {
            wpos[selected].dy = wpos[selected].dy + updown;
            nullify();
            setState(() {});
          }));
    }
    if (!allyfront2) {
      _gridRow.add(_greenDot(
          selected: selected,
          updown: updown,
          left: (wpos[selected].dx - 1) * 40,
          bottom: (wpos[selected].dy + updown) * 40,
          onthetap: () {
            wpos[selected].dy = wpos[selected].dy + updown;
            wpos[selected].dx = wpos[selected].dx - 1;
            nullify();
            setState(() {});
          }));
    }
    if (!allyfront3) {
      _gridRow.add(_greenDot(
          selected: selected,
          updown: updown,
          left: (wpos[selected].dx + 1) * 40,
          bottom: (wpos[selected].dy + updown) * 40,
          onthetap: () {
            wpos[selected].dy = wpos[selected].dy + updown;
            wpos[selected].dx = wpos[selected].dx + 1;
            nullify();
            setState(() {});
          }));
    }

    if (!allybehind) {
      _gridRow.add(_greenDot(
          selected: selected,
          updown: updown,
          left: wpos[selected].dx * 40,
          bottom: (wpos[selected].dy - updown) * 40,
          onthetap: () {
            wpos[selected].dy = wpos[selected].dy - updown;
            nullify();
            setState(() {});
          }));
    }
    if (!allybehind2) {
      _gridRow.add(_greenDot(
          selected: selected,
          updown: updown,
          left: (wpos[selected].dx - 1) * 40,
          bottom: (wpos[selected].dy - updown) * 40,
          onthetap: () {
            wpos[selected].dy = wpos[selected].dy - updown;
            wpos[selected].dx = wpos[selected].dx - 1;
            nullify();
            setState(() {});
          }));
    }
    if (!allybehind3) {
      _gridRow.add(_greenDot(
          selected: selected,
          updown: updown,
          left: (wpos[selected].dx + 1) * 40,
          bottom: (wpos[selected].dy - updown) * 40,
          onthetap: () {
            wpos[selected].dy = wpos[selected].dy - updown;

            wpos[selected].dx = wpos[selected].dx + 1;
            nullify();
            setState(() {});
          }));
    }

    if (!allyleft) {
      _gridRow.add(_greenDot(
          selected: selected,
          updown: updown,
          left: (wpos[selected].dx - 1) * 40,
          bottom: (wpos[selected].dy) * 40,
          onthetap: () {
            wpos[selected].dx = wpos[selected].dx - 1;
            nullify();
            setState(() {});
          }));
    }
    if (!allyRight) {
      _gridRow.add(_greenDot(
          selected: selected,
          updown: updown,
          left: (wpos[selected].dx + 1) * 40,
          bottom: (wpos[selected].dy) * 40,
          onthetap: () {
            wpos[selected].dx = wpos[selected].dx + 1;
            nullify();
            setState(() {});
          }));
    }
  }

  void _rookMove(bool white, List<Pieces> wpos, List<Pieces> bpos) {
    int updown = 1, selected;
    if (!white) {
      updown = -1;
      selected = _selectedB!;
    } else {
      selected = _selectedW!;
    }
    int limitRight = 7 - wpos[selected].dx;
    int limitUp = 7 - wpos[selected].dy;
    int limitLeft = 7 - limitRight;
    int limitDown = 7 - limitUp;

    if (!white) {
      limitDown = 7 - wpos[selected].dy;
      limitUp = 7 - limitDown;
    }

    for (int i = 1; i < limitUp + 1; i++) {
      bool okay = true;
      for (int j = 0; j < wpos.length; j++) {
        if (wpos[selected].dx == wpos[j].dx &&
            wpos[selected].dy + i * updown == wpos[j].dy) {
          okay = false;
          i = limitUp;
        }
      }
      for (int j = 0; j < bpos.length; j++) {
        if (wpos[selected].dx == bpos[j].dx &&
            wpos[selected].dy + i * updown == bpos[j].dy + updown) {
          i = limitUp;
          okay = false;
        }
      }
      if (okay) {
        _gridRow.add(_greenDot(
            selected: selected,
            i: i,
            updown: updown,
            left: wpos[selected].dx * 40,
            bottom: (wpos[selected].dy + updown * i) * 40,
            onthetap: () {
              wpos[selected].dy = wpos[selected].dy + updown * i;
              wpos[selected].dx = wpos[selected].dx;
              nullify();
              setState(() {});
            }));
      }
    }

    for (int i = 1; i < limitDown + 1; i++) {
      bool okay = true;
      for (int j = 0; j < wpos.length; j++) {
        if (wpos[selected].dx == wpos[j].dx &&
            wpos[selected].dy - i * updown == wpos[j].dy) {
          okay = false;
          i = limitDown;
        }
      }

      for (int j = 0; j < bpos.length; j++) {
        if (wpos[selected].dx == bpos[j].dx &&
            wpos[selected].dy - i * updown == bpos[j].dy - updown) {
          i = limitDown;
          okay = false;
        }
      }
      if (okay) {
        _gridRow.add(_greenDot(
            selected: selected,
            i: i,
            updown: updown,
            left: wpos[selected].dx * 40,
            bottom: (wpos[selected].dy - updown * i) * 40,
            onthetap: () {
              wpos[selected].dy = wpos[selected].dy - updown * i;
              wpos[selected].dx = wpos[selected].dx;
              nullify();
              setState(() {});
            }));
      }
    }

    for (int i = 1; i < limitLeft + 1; i++) {
      bool okay = true;
      for (int j = 0; j < wpos.length; j++) {
        if (wpos[selected].dx - i == wpos[j].dx &&
            wpos[selected].dy == wpos[j].dy) {
          okay = false;
          i = limitLeft;
        }
      }

      for (int j = 0; j < bpos.length; j++) {
        if (wpos[selected].dx - i == bpos[j].dx - 1 &&
            wpos[selected].dy == bpos[j].dy) {
          i = limitLeft;
          okay = false;
        }
      }
      if (okay) {
        _gridRow.add(_greenDot(
            selected: selected,
            i: i,
            updown: updown,
            left: (wpos[selected].dx - i) * 40,
            bottom: wpos[selected].dy * 40,
            onthetap: () {
              wpos[selected].dy = wpos[selected].dy;
              wpos[selected].dx = wpos[selected].dx - i;
              nullify();
              setState(() {});
            }));
      }
    }

    for (int i = 1; i < limitRight + 1; i++) {
      bool okay = true;
      for (int j = 0; j < wpos.length; j++) {
        if (wpos[selected].dx + i == wpos[j].dx &&
            wpos[selected].dy == wpos[j].dy) {
          okay = false;
          i = limitRight;
        }
      }
      for (int j = 0; j < bpos.length; j++) {
        if (wpos[selected].dx + i == bpos[j].dx + 1 &&
            wpos[selected].dy == bpos[j].dy) {
          i = limitRight;
          okay = false;
        }
      }
      if (okay) {
        _gridRow.add(_greenDot(
            selected: selected,
            i: i,
            updown: updown,
            left: (wpos[selected].dx + i) * 40,
            bottom: wpos[selected].dy * 40,
            onthetap: () {
              wpos[selected].dy = wpos[selected].dy;
              wpos[selected].dx = wpos[selected].dx + i;
              nullify();
              setState(() {});
            }));
      }
    }
  }

  void _bishopMove(bool white, List<Pieces> wpos, List<Pieces> bpos) {
    int updown = 1, selected;
    if (!white) {
      updown = -1;
      selected = _selectedB!;
    } else {
      selected = _selectedW!;
    }
    int limitRight = 7 - wpos[selected].dx;
    int limitUp = 7 - wpos[selected].dy;
    int limitLeft = 7 - limitRight;
    int limitDown = 7 - limitUp;

    if (!white) {
      limitDown = 7 - wpos[selected].dy;
      limitUp = 7 - limitDown;
    }

    int lower;
    if (limitRight > limitUp) {
      lower = limitUp;
    } else {
      lower = limitRight;
    }

    for (int i = 1; i < lower + 1; i++) {
      bool okay = true;
      for (int j = 0; j < wpos.length; j++) {
        if (wpos[selected].dx + i == wpos[j].dx &&
            wpos[selected].dy + i * updown == wpos[j].dy) {
          okay = false;
          i = lower;
        }
      }
      for (int j = 0; j < bpos.length; j++) {
        if (wpos[selected].dx + i == bpos[j].dx + 1 &&
            wpos[selected].dy + i * updown == bpos[j].dy + updown) {
          i = lower;
          okay = false;
        }
      }
      if (okay) {
        _gridRow.add(_greenDot(
            selected: selected,
            i: i,
            updown: updown,
            left: (wpos[selected].dx + i) * 40,
            bottom: (wpos[selected].dy + updown * i) * 40,
            onthetap: () {
              wpos[selected].dy = wpos[selected].dy + updown * i;
              wpos[selected].dx = wpos[selected].dx + i;
              nullify();
              setState(() {});
            }));
      }
    }

    if (limitLeft > limitUp) {
      lower = limitUp;
    } else {
      lower = limitLeft;
    }

    for (int i = 1; i < lower + 1; i++) {
      bool okay = true;
      for (int j = 0; j < wpos.length; j++) {
        if (wpos[selected].dx - i == wpos[j].dx &&
            wpos[selected].dy + i * updown == wpos[j].dy) {
          okay = false;
          i = lower;
        }
      }

      for (int j = 0; j < bpos.length; j++) {
        if (wpos[selected].dx - i == bpos[j].dx - 1 &&
            wpos[selected].dy + i * updown == bpos[j].dy + updown) {
          i = lower;
          okay = false;
        }
      }
      if (okay) {
        _gridRow.add(_greenDot(
            selected: selected,
            i: i,
            updown: updown,
            left: (wpos[selected].dx - i) * 40,
            bottom: (wpos[selected].dy + updown * i) * 40,
            onthetap: () {
              wpos[selected].dy = wpos[selected].dy + updown * i;
              wpos[selected].dx = wpos[selected].dx - i;
              nullify();
              setState(() {});
            }));
      }
    }

    if (limitLeft > limitDown) {
      lower = limitDown;
    } else {
      lower = limitLeft;
    }

    for (int i = 1; i < lower + 1; i++) {
      bool okay = true;
      for (int j = 0; j < wpos.length; j++) {
        if (wpos[selected].dx - i == wpos[j].dx &&
            wpos[selected].dy - i * updown == wpos[j].dy) {
          okay = false;
          i = lower;
        }
      }

      for (int j = 0; j < bpos.length; j++) {
        if (wpos[selected].dx - i == bpos[j].dx - 1 &&
            wpos[selected].dy - i * updown == bpos[j].dy - updown) {
          i = lower;
          okay = false;
        }
      }
      if (okay) {
        _gridRow.add(_greenDot(
            selected: selected,
            i: i,
            updown: updown,
            left: (wpos[selected].dx - i) * 40,
            bottom: (wpos[selected].dy - updown * i) * 40,
            onthetap: () {
              wpos[selected].dy = wpos[selected].dy - updown * i;
              wpos[selected].dx = wpos[selected].dx - i;
              nullify();
              setState(() {});
            }));
      }
    }

    if (limitRight > limitDown) {
      lower = limitDown;
    } else {
      lower = limitRight;
    }

    for (int i = 1; i < lower + 1; i++) {
      bool okay = true;
      for (int j = 0; j < wpos.length; j++) {
        if (wpos[selected].dx + i == wpos[j].dx &&
            wpos[selected].dy - i * updown == wpos[j].dy) {
          okay = false;
          i = lower;
        }
      }
      for (int j = 0; j < bpos.length; j++) {
        if (wpos[selected].dx + i == bpos[j].dx + 1 &&
            wpos[selected].dy - i * updown == bpos[j].dy - 1) {
          i = lower;
          okay = false;
        }
      }
      if (okay) {
        _gridRow.add(_greenDot(
            selected: selected,
            i: i,
            updown: updown,
            left: (wpos[selected].dx + i) * 40,
            bottom: (wpos[selected].dy - updown * i) * 40,
            onthetap: () {
              wpos[selected].dy = wpos[selected].dy - updown * i;
              wpos[selected].dx = wpos[selected].dx + i;
              nullify();
              setState(() {});
            }));
      }
    }
  }

  void _knightMove(bool white, List<Pieces> wpos, List<Pieces> bpos) {
    bool landLeftUp = false,
        landLeftUp2 = false,
        landLeftDown = false,
        landLeftDown2 = false,
        landRightUp = false,
        landRightUp2 = false,
        landRightDown = false,
        landRightDown2 = false;
    int updown = 1, selected;
    if (!white) {
      updown = -1;
      selected = _selectedB!;
    } else {
      selected = _selectedW!;
    }
    for (int i = 0; i < wpos.length; i++) {
      if (wpos[selected].dy + updown * 2 == wpos[i].dy &&
          wpos[selected].dx - 1 == wpos[i].dx) {
        landLeftUp = true;
      }
      if (wpos[selected].dy + updown == wpos[i].dy &&
          wpos[selected].dx - 2 == wpos[i].dx) {
        landLeftUp2 = true;
      }
      if (wpos[selected].dy + updown * 2 == wpos[i].dy &&
          wpos[selected].dx + 1 == wpos[i].dx) {
        landRightUp = true;
      }
      if (wpos[selected].dy + updown == wpos[i].dy &&
          wpos[selected].dx + 2 == wpos[i].dx) {
        landRightUp2 = true;
      }
      if (wpos[selected].dy - updown * 2 == wpos[i].dy &&
          wpos[selected].dx - 1 == wpos[i].dx) {
        landLeftDown = true;
      }
      if (wpos[selected].dy - updown * 2 == wpos[i].dy &&
          wpos[selected].dx + 1 == wpos[i].dx) {
        landRightDown = true;
      }
      if (wpos[selected].dy - updown == wpos[i].dy &&
          wpos[selected].dx - 2 == wpos[i].dx) {
        landLeftDown2 = true;
      }
      if (wpos[selected].dy - updown == wpos[i].dy &&
          wpos[selected].dx + 2 == wpos[i].dx) {
        landRightDown2 = true;
      }
    }
    if (!landLeftUp) {
      _gridRow.add(Positioned(
        left: (wpos[selected].dx - 1) * 40,
        bottom: (wpos[selected].dy + updown * 2) * 40,
        child: GestureDetector(
          onTap: () {
            wpos[selected].dy = wpos[selected].dy + updown * 2;
            wpos[selected].dx = wpos[selected].dx - 1;
            nullify();
            setState(() {});
          },
          child: Container(
            color: const Color.fromARGB(0, 0, 0, 0),
            width: 40,
            height: 40,
            child: Center(
                child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25)))),
          ),
        ),
      ));
    }
    if (!landRightUp) {
      _gridRow.add(Positioned(
        left: (wpos[selected].dx + 1) * 40,
        bottom: (wpos[selected].dy + updown * 2) * 40,
        child: GestureDetector(
          onTap: () {
            wpos[selected].dy = wpos[selected].dy + updown * 2;
            wpos[selected].dx = wpos[selected].dx + 1;
            nullify();
            setState(() {});
          },
          child: Container(
            color: const Color.fromARGB(0, 0, 0, 0),
            width: 40,
            height: 40,
            child: Center(
                child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25)))),
          ),
        ),
      ));
    }
    if (!landLeftUp2) {
      _gridRow.add(Positioned(
        left: (wpos[selected].dx - 2) * 40,
        bottom: (wpos[selected].dy + updown) * 40,
        child: GestureDetector(
          onTap: () {
            wpos[selected].dy = wpos[selected].dy + updown;
            wpos[selected].dx = wpos[selected].dx - 2;
            nullify();
            setState(() {});
          },
          child: Container(
            color: const Color.fromARGB(0, 0, 0, 0),
            width: 40,
            height: 40,
            child: Center(
                child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25)))),
          ),
        ),
      ));
    }
    if (!landRightUp2) {
      _gridRow.add(Positioned(
        left: (wpos[selected].dx + 2) * 40,
        bottom: (wpos[selected].dy + updown) * 40,
        child: GestureDetector(
          onTap: () {
            wpos[selected].dy = wpos[selected].dy + updown;
            wpos[selected].dx = wpos[selected].dx + 2;
            nullify();
            setState(() {});
          },
          child: Container(
            color: const Color.fromARGB(0, 0, 0, 0),
            width: 40,
            height: 40,
            child: Center(
                child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25)))),
          ),
        ),
      ));
    }
    if (!landLeftDown) {
      _gridRow.add(Positioned(
        left: (wpos[selected].dx - 1) * 40,
        bottom: (wpos[selected].dy - updown * 2) * 40,
        child: GestureDetector(
          onTap: () {
            wpos[selected].dy = wpos[selected].dy - updown * 2;
            wpos[selected].dx = wpos[selected].dx - 1;
            nullify();
            setState(() {});
          },
          child: Container(
            color: const Color.fromARGB(0, 0, 0, 0),
            width: 40,
            height: 40,
            child: Center(
                child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25)))),
          ),
        ),
      ));
    }
    if (!landRightDown) {
      _gridRow.add(Positioned(
        left: (wpos[selected].dx + 1) * 40,
        bottom: (wpos[selected].dy - updown * 2) * 40,
        child: GestureDetector(
          onTap: () {
            wpos[selected].dy = wpos[selected].dy - updown * 2;
            wpos[selected].dx = wpos[selected].dx + 1;
            nullify();
            setState(() {});
          },
          child: Container(
            color: const Color.fromARGB(0, 0, 0, 0),
            width: 40,
            height: 40,
            child: Center(
                child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25)))),
          ),
        ),
      ));
    }
    if (!landLeftDown2) {
      _gridRow.add(Positioned(
        left: (wpos[selected].dx - 2) * 40,
        bottom: (wpos[selected].dy - updown) * 40,
        child: GestureDetector(
          onTap: () {
            wpos[selected].dy = wpos[selected].dy - updown;
            wpos[selected].dx = wpos[selected].dx - 2;
            nullify();
            setState(() {});
          },
          child: Container(
            color: const Color.fromARGB(0, 0, 0, 0),
            width: 40,
            height: 40,
            child: Center(
                child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25)))),
          ),
        ),
      ));
    }
    if (!landRightDown2) {
      _gridRow.add(Positioned(
        left: (wpos[selected].dx + 2) * 40,
        bottom: (wpos[selected].dy - updown) * 40,
        child: GestureDetector(
          onTap: () {
            wpos[selected].dy = wpos[selected].dy - updown;
            wpos[selected].dx = wpos[selected].dx + 2;
            nullify();
            setState(() {});
          },
          child: Container(
            color: const Color.fromARGB(0, 0, 0, 0),
            width: 40,
            height: 40,
            child: Center(
                child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25)))),
          ),
        ),
      ));
    }
  }

  void _pawnMove(bool white, List<Pieces> wpos, List<Pieces> bpos) {
    bool enemyleft = false,
        enemyright = false,
        elpasanLeft = false,
        elpasanRight = false,
        allyfront = false,
        allyfront2 = false,
        enemyfront = false,
        enemyfront2 = false;
    int? updown = 1, selected = _selectedW;
    if (!white) {
      updown = -1;
      selected = _selectedB;
    }
    for (int i = 0; i < bpos.length; i++) {
      if (wpos[selected!].dy + updown == bpos[i].dy &&
          wpos[selected].dx == bpos[i].dx) {
        enemyfront = true;
      }
      if (wpos[selected].dy + updown * 2 == bpos[i].dy &&
          wpos[selected].dx == bpos[i].dx) {
        enemyfront2 = true;
      }
      if (wpos[selected].dy + updown == bpos[i].dy &&
          bpos[i].dx == wpos[selected].dx + 1) {
        enemyright = true;
      }
      if (wpos[selected].dy + updown == bpos[i].dy &&
          bpos[i].dx == wpos[selected].dx - 1) {
        enemyleft = true;
      }
    }

    for (int i = 0; i < wpos.length; i++) {
      if (wpos[selected!].dy + updown == wpos[i].dy &&
          wpos[selected].dx == wpos[i].dx) {
        allyfront = true;
      }
      if (wpos[selected].dy + updown * 2 == wpos[i].dy &&
          wpos[selected].dx == wpos[i].dx) {
        allyfront2 = true;
      }
    }

    if (wpos[selected!].dy + updown == _rDpy &&
        wpos[selected].dx + 1 == _rDpx) {
      elpasanRight = true;
    }
    if (wpos[selected].dy + updown == _rDpy && wpos[selected].dx - 1 == _rDpx) {
      elpasanLeft = true;
    }
    if (!enemyfront && !allyfront) {
      _gridRow.add(_greenDot(
          selected: selected,
          updown: updown,
          left: wpos[selected].dx * 40,
          bottom: (wpos[selected].dy + updown) * 40,
          onthetap: () {
            wpos[selected!].dy = wpos[selected].dy + updown!;
            nullify();
            setState(() {});
          }));
      if (((wpos[selected].dy == 1 && white) ||
              (wpos[selected].dy == 6 && !white)) &&
          !enemyfront2 &&
          !allyfront2) {
        _gridRow.add(_greenDot(
            selected: selected,
            updown: updown,
            left: wpos[selected].dx * 40,
            bottom: (wpos[selected].dy + updown * 2) * 40,
            onthetap: () {
              int newDy = 0, newDy2 = 0;
              if (white) {
                newDy = wpos[selected!].dy + 2;
                newDy2 = wpos[selected].dy + 1;
              } else {
                newDy = wpos[selected!].dy - 2;
                newDy2 = wpos[selected].dy - 1;
              }
              _rDpx = wpos[selected].dx / 1;
              _rDpy = newDy2 / 1;
              wpos[selected].dy = newDy;
              nullify(redDot: true);
              setState(() {});
            }));
      }
    }
    if (enemyleft && wpos[selected].dx - 1 != 0) {
      _gridRow.add(_greenDot(
          selected: selected,
          updown: updown,
          left: (wpos[selected].dx - 1) * 40,
          bottom: (wpos[selected].dy + updown) * 40,
          onthetap: () {}));
    }
    if (enemyright && wpos[selected].dx + 1 != 8) {
      _gridRow.add(_greenDot(
          selected: selected,
          updown: updown,
          left: (wpos[selected].dx + 1) * 40,
          bottom: (wpos[selected].dy + updown) * 40,
          onthetap: () {}));
    }
    if (elpasanLeft && wpos[selected].dx - 1 != 0) {
      _gridRow.add(_greenDot(
          selected: selected,
          updown: updown,
          left: (wpos[selected].dx - 1) * 40,
          bottom: (wpos[selected].dy + updown) * 40,
          onthetap: () {}));
    }
    if (elpasanRight && wpos[selected].dx + 1 != 8) {
      _gridRow.add(_greenDot(
          selected: selected,
          updown: updown,
          left: (wpos[selected].dx + 1) * 40,
          bottom: (wpos[selected].dy + updown) * 40,
          onthetap: () {}));
    }
  }

  void nullify({bool redDot = false}) {
    if (!redDot) {
      _rDpx = 0;
      _rDpy = 0;
    }
    _selectedB = null;
    _selectedCol = null;
    _selectedW = null;
    _selectedRow = null;
  }

  Widget _greenDot(
      {required int selected,
      int i = 0,
      required int updown,
      required double left,
      required double bottom,
      required void Function() onthetap}) {
    return Positioned(
      left: left,
      bottom: bottom,
      child: GestureDetector(
        onTap: onthetap,
        child: Container(
          color: const Color.fromARGB(0, 0, 0, 0),
          width: 40,
          height: 40,
          child: Center(
              child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25)))),
        ),
      ),
    );
  }

  Grid _gridBuilder(int j, int i) {
    bool selected = false;
    if (_selectedRow == j && _selectedCol == i) selected = true;
    return Grid(
      j,
      i,
      selected: selected,
    );
  }
}
