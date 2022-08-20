import 'dart:ui';

import 'package:flutter/material.dart';

class GlassHourUi extends StatefulWidget {
  const GlassHourUi(
      {super.key, required this.child, this.height = 300, this.width = 300});
  final Widget child;
  final double height;
  final double width;

  @override
  State<GlassHourUi> createState() => _GlassHourUiState();
}

class _GlassHourUiState extends State<GlassHourUi> {
  final BorderRadius rad = BorderRadius.circular(25);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: rad,
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                child: SizedBox(
                  width: widget.width,
                  height: widget.height,
                  child: const Text(""),
                ),
              ),
              Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                    borderRadius: rad,
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
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
                child: widget.child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
