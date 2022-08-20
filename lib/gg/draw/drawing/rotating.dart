import 'dart:math';

import 'package:flutter/material.dart';
import 'cameracame.dart';

class RotatingCircle extends StatefulWidget {
  final Tame onTap;
  const RotatingCircle({super.key, required this.onTap});

  @override
  State<RotatingCircle> createState() => _RotatingCircleState();
}

class _RotatingCircleState extends State<RotatingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _angle = 0;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(50),
        child: GestureDetector(
          child: Transform.rotate(
            angle: _angle,
            child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50)),
                child: const Icon(Icons.change_circle, color: Colors.white)),
          ),
          onTap: () {
            _animation = Tween<double>(begin: 0, end: pi).animate(_controller)
              ..addListener(() {
                setState(() {
                  _angle = -_animation.value;
                });
              });
            _controller.forward(from: 0);
            widget.onTap();
          },
        ),
      ),
    );
  }
}
