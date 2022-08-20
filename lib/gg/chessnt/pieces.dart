import 'package:flutter/material.dart';

class Grid {
  final int _row;
  final int _col;
  bool selected;
  Grid(this._row, this._col, {this.selected = false});

  String _id() => "R${_row}C$_col";

  String get id => _id();

  int get row => _row;
  int get col => _col;

  Color _colorPicker(int row, int col) {
    Color returner = Colors.white;
    if (col % 2 != 0) {
      if (row % 2 == 0) {
        returner = const Color.fromARGB(255, 248, 142, 56);
      }
    } else {
      if (row % 2 != 0) {
        returner = const Color.fromARGB(255, 248, 142, 56);
      }
    }
    return returner;
  }

  Color get gridColor => _colorPicker(_row, _col);

  Container container({bool fal = false}) => Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: gridColor,
            border: (!fal)
                ? ((!selected)
                    ? Border.all(color: Colors.black, width: 1)
                    : Border.all(color: Colors.green, width: 5))
                : Border.all(color: Colors.black, width: 1)),
      );
}

class Pieces {
  String name;
  int dx;
  int dy;
  String img;
  bool dead;
  Pieces(this.name, this.dx, this.dy, {required this.img, this.dead = false});
}
