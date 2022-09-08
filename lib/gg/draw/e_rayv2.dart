import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:hidden_city/utils/plainVar/networking.dart' as url;

class XRays extends StatefulWidget {
  const XRays({Key? key}) : super(key: key);

  @override
  State<XRays> createState() => _XRaysState();
}

class _XRaysState extends State<XRays> {
  StrokeCap strokeType = StrokeCap.round;
  double devicePixelRatio = 0, x = 0, y = 0, rad = 0;
  bool _wOh = false;
  String imagePath = url.a0;
  String imageBase = url.a1;
  ui.Image? imageTase, imageCut;

  ClipPath _getClipPathOverlay(double width, double height) {
    return ClipPath(
      clipper: InvertedClipper(x, y, rad),
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imageBase), fit: BoxFit.contain))),
    );
  }

  void onChanged(dynamic details) async {
    Offset kli = details.globalPosition;
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    Offset coor = referenceBox.globalToLocal(kli);
    x = coor.dx + 50;
    y = coor.dy - 50;
    rad = 50;
    debugPrint(x.toString());
  }

  void _handlePanStart(DragStartDetails details) {
    onChanged(details);
    setState(() {});
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    onChanged(details);
    setState(() {});
  }

  void _handlePanEnd(DragEndDetails details) async {
    rad = 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (width > height) {
      _wOh = true;
    } else {
      _wOh = false;
    }
    double tinggi = 0, lebar = 0;
    if (_wOh) {
      lebar = width;
      tinggi = double.infinity;
    } else {
      tinggi = height;
      lebar = double.infinity;
    }
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: tinggi,
              width: lebar,
              child: Stack(
                children: [
                  Container(
                    height: tinggi,
                    width: lebar,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(imagePath),
                            fit: BoxFit.contain)),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onPanStart: _handlePanStart,
                    onPanEnd: _handlePanEnd,
                    onPanUpdate: _handlePanUpdate,
                    child: _getClipPathOverlay(lebar, tinggi),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    child: const Icon(Icons.layers),
                    onPressed: () {
                      setState(() {
                        if (imageBase == url.a1 && imagePath == url.a0) {
                          imageBase = url.s1;
                          imagePath = url.s0;
                          return;
                        }
                        if (imageBase == url.s1 && imagePath == url.s0) {
                          imageBase = url.r1;
                          imagePath = url.r0;
                          return;
                        }
                        if (imageBase == url.r1 && imagePath == url.r0) {
                          imageBase = url.gwn1;
                          imagePath = url.gwn0;
                          return;
                        }
                        if (imageBase == url.gwn1 && imagePath == url.gwn0) {
                          imageBase = url.nz1;
                          imagePath = url.nz0;
                          return;
                        }
                        if (imageBase == url.nz1 && imagePath == url.nz0) {
                          imageBase = url.mt1;
                          imagePath = url.mt0;
                          return;
                        }
                        if (imageBase == url.mt1 && imagePath == url.mt0) {
                          imageBase = url.jnx1;
                          imagePath = url.jnx0;
                          return;
                        }
                        if (imageBase == url.jnx1 && imagePath == url.jnx0) {
                          imageBase = url.nzz1;
                          imagePath = url.nzz0;
                          return;
                        }
                        if (imageBase == url.nzz1 && imagePath == url.nzz0) {
                          imageBase = url.a1;
                          imagePath = url.a0;
                          return;
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvertedClipper extends CustomClipper<Path> {
  final double x;
  final double y;
  final double rad;
  InvertedClipper(this.x, this.y, this.rad);

  @override
  Path getClip(Size size) {
    return Path.combine(
      PathOperation.difference,
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
      Path()
        ..addOval(Rect.fromCircle(center: Offset(x, y), radius: rad))
        ..close(),
    );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
