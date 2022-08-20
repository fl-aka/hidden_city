import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'eyedropper.dart';

typedef Col = void Function(Color x);
Widget colorChooser(BuildContext context, Color pickerColor,
    {required Col col, required Col changeColor}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(50),
        child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(50)),
            child: const Icon(
              Icons.color_lens,
              color: Colors.white,
            )),
      ),
      onDoubleTap: () {
        chooseCol2(context, pickerColor, changeColor, col);
      },
    ),
  );
}

void chooseCol2(
    BuildContext context, Color pickerColor, Col changeColor, Col col) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Pick a color!'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: pickerColor,
          onColorChanged: changeColor,
        ),
        // Use Material color picker:
        //
        // child: MaterialPicker(
        //   pickerColor: pickerColor,
        //   onColorChanged: changeColor,
        //   showLabel: true, // only on portrait mode
        // ),
        //
        // Use Block color picker:
        //
        // child: BlockPicker(
        //   pickerColor: currentColor,
        //   onColorChanged: changeColor,
        // ),
        //
        // child: MultipleChoiceBlockPicker(
        //   pickerColors: currentColors,
        //   onColorsChanged: changeColors,
        // ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('OK'),
          onPressed: () {
            col(pickerColor);
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}

void chooseCol(
    BuildContext context, Color pickerColor, Col changeColor, Col col,
    {required Uint8List? a, required Future<void> getLast}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Pick a color!'),
      content: SingleChildScrollView(
        child: MaterialPicker(
          pickerColor: pickerColor,
          onColorChanged: changeColor,
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Use Eyedropper'),
          onPressed: () async {
            if (a != null) {
              await Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => ColorPickerWidget(
                            img: a,
                            initial: pickerColor,
                          )))
                  .then((value) {
                pickerColor = value;
              });
            }
            changeColor(pickerColor);
          },
        ),
        ElevatedButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
