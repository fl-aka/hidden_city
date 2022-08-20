import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

typedef RunEnd = void Function();

class OldPic extends StatefulWidget {
  final bool clean;
  final Uint8List? memory;
  final RunEnd x;
  const OldPic(
      {super.key, required this.clean, required this.memory, required this.x});

  @override
  State<OldPic> createState() => _OldPicState();
}

class _OldPicState extends State<OldPic> {
  Box? memimage;
  Uint8List? image;
  @override
  void dispose() {
    if (memimage != null && widget.memory != null) {
      if (memimage!.isNotEmpty) {
        memimage!.putAt(0, widget.memory!);
      } else {
        memimage!.add(widget.memory!);
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    double tinggi = MediaQuery.of(context).size.height;
    bool cleanThis = widget.clean;
    return FutureBuilder(
        future: Hive.openBox('Memimage'),
        builder: (context, snapshot) {
          try {
            if (snapshot.connectionState == ConnectionState.done) {
              memimage = Hive.box("Memimage");
              if (memimage!.isNotEmpty) {
                image = memimage!.getAt(0);
              }

              if (cleanThis) {
                debugPrint(memimage!.length.toString());
                if (memimage != null) {
                  memimage!.deleteAt(0);
                }
                image = null;
                if (mounted) {
                  setState(() {});
                }
                widget.x();
              }
            }

            return Container(
              height: tinggi,
              width: lebar,
              decoration: (image != null)
                  ? BoxDecoration(
                      image: DecorationImage(image: MemoryImage(image!)))
                  : const BoxDecoration(),
            );
          } catch (e) {
            return const Center();
          }
        });
  }
}
