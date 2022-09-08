import 'package:flutter/material.dart';

class GlassMaji extends StatelessWidget {
  const GlassMaji({super.key, required this.size});
  final double size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CustomPaint(painter: GlassPainter()),
    );
  }
}

class GlassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
