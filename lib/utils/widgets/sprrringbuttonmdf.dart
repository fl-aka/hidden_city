import 'package:flutter/material.dart';

typedef DoThis = void Function();

class Button extends StatefulWidget {
  final bool active;
  final String text;
  final Color dasar;
  final double size;
  final Duration long;
  final DoThis doThis;
  const Button(this.active, this.text,
      {Key? key,
      this.dasar = const Color.fromRGBO(97, 63, 117, 1),
      this.size = 20,
      this.long = const Duration(milliseconds: 5),
      required this.doThis})
      : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  double finale = 5;
  bool naik = false;
  bool mulai = false;

  void ending() {
    naik = false;
    mulai = false;
    finale = 5;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Stream.periodic(const Duration(milliseconds: 5)),
        builder: (context, snapshot) {
          if (mulai) {
            if (!naik) {
              if (finale > 1.5) finale -= 0.5;
            } else {
              finale += 0.5;
            }
            if (finale < 1.6) {
              naik = true;
            }

            if (naik && finale > 5) {
              ending();
              widget.doThis();
            }
          }

          return GestureDetector(
            onTap: () {
              mulai = true;
            },
            child: Material(
              borderRadius: BorderRadius.circular(25),
              elevation: widget.active ? finale : 5,
              color: widget.dasar,
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(widget.text,
                      style: TextStyle(
                          fontSize: widget.active
                              ? (widget.size + finale / 10) - 0.5
                              : widget.size,
                          color: Colors.white))),
            ),
          );
        });
  }
}
