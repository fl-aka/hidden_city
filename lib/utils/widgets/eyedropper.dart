import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;

class ColorPickerWidget extends StatefulWidget {
  final Uint8List img;
  final Color initial;
  const ColorPickerWidget(
      {super.key, required this.img, required this.initial});

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  GlobalKey imageKey = GlobalKey();
  GlobalKey paintKey = GlobalKey();

  late GlobalKey currentKey;

  late Color _color;
  img.Image? photo;

  Future<bool> _willPop() async {
    Navigator.of(context).pop(_color);
    return false;
  }

  @override
  void initState() {
    currentKey = paintKey;
    _color = widget.initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const String title = "snapshot";
    return WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
        appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(_color);
              },
              child: const Icon(Icons.arrow_back),
            ),
            title: const Text("Color picker $title")),
        body: Stack(
          children: <Widget>[
            RepaintBoundary(
              key: paintKey,
              child: GestureDetector(
                onPanDown: (details) async {
                  await searchPixel(details.globalPosition);
                  setState(() {});
                },
                onPanUpdate: (details) async {
                  await searchPixel(details.globalPosition);
                  setState(() {});
                },
                child: Center(
                  child: Image.memory(
                    widget.img,
                    key: imageKey,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(70),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _color,
                  border: Border.all(width: 2.0, color: Colors.white),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2))
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> searchPixel(Offset globalPosition) async {
    await loadSnapshotBytes();
    _calculatePixel(globalPosition);
  }

  void _calculatePixel(Offset globalPosition) {
    RenderBox box =
        currentKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    Offset localPosition = box.globalToLocal(globalPosition);

    double px = localPosition.dx;
    double py = localPosition.dy;

    if (photo != null) {
      double widgetScale = box.size.width / photo!.width;
      px = (px / widgetScale);
      py = (py / widgetScale);

      int pixel32 = photo!.getPixelSafe(px.toInt(), py.toInt());
      int hex = abgrToArgb(pixel32);
      _color = Color(hex);
    }
  }

  Future<void> loadSnapshotBytes() async {
    RenderRepaintBoundary boxPaint =
        paintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image capture = await boxPaint.toImage();
    ByteData? imageBytes =
        await capture.toByteData(format: ui.ImageByteFormat.png);
    if (imageBytes != null) {
      setImageBytes(imageBytes);
    }
    capture.dispose();
  }

  void setImageBytes(ByteData imageBytes) {
    List<int> values = imageBytes.buffer.asUint8List();
    photo = null;
    photo = img.decodeImage(values);
  }
}

// image lib uses uses KML color format, convert #AABBGGRR to regular #AARRGGBB
int abgrToArgb(int argbColor) {
  int r = (argbColor >> 16) & 0xFF;
  int b = argbColor & 0xFF;
  return (argbColor & 0xFF00FF00) | (b << 16) | r;
}
