import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hidden_city/utils/backend/honeys/link.dart';
import 'package:hidden_city/gg/draw/preview.dart';
import 'package:hidden_city/gg/gallery/zoom_pitch.dart';

class SecondPage extends StatefulWidget {
  final List<Link> imagine;
  final int index;
  const SecondPage(
    this.imagine, {
    super.key,
    required this.index,
  });

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int inIndex = 0;
  double _scaleBegin = 9;
  bool _goingUP = false;
  @override
  void initState() {
    inIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color color, colornt;
    color = Colors.green;
    colornt = Colors.red;
    var scaffoldMsg = ScaffoldMessenger.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.pink[100],
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Detail Photo"),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.download,
                  color:
                      widget.imagine[inIndex].bitImg != null ? color : colornt,
                ),
                onPressed: () async {
                  String judul = await getTextFromDl(
                          context,
                          "Enter File Name, Please Use Correct Type (gif for animated picture)",
                          "File Name Here") ??
                      'Art-${DateTime.now()}';
                  if (widget.imagine[inIndex].bitImg != null) {
                    if (!judul.endsWith(".gif") && !judul.endsWith(".png")) {
                      final Map result = await ImageGallerySaver.saveImage(
                          widget.imagine[inIndex].bitImg!,
                          quality: 100,
                          name: judul);
                      if (result["isSuccess"]) {
                        scaffoldMsg.showSnackBar(
                            const SnackBar(content: Text("Picture Saved!")));
                      } else {
                        scaffoldMsg.showSnackBar(
                            const SnackBar(content: Text("Failed To Saved!")));
                      }
                    } else {
                      var appDocDir = await getTemporaryDirectory();
                      debugPrint(appDocDir.path);
                      String savePath = appDocDir.path + judul;
                      final file = await File(savePath).create();
                      file.writeAsBytes(widget.imagine[inIndex].bitImg!);
                      await ImageGallerySaver.saveFile(savePath, name: judul);
                    }
                  }
                }),
            IconButton(
                icon: Icon(
                  Icons.copy,
                  color: color,
                ),
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: widget.imagine[inIndex].route));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content:
                          Text("${widget.imagine[inIndex].route} is Copied")));
                }),
            IconButton(
                icon: Icon(
                  Icons.delete_sweep,
                  color: color,
                ),
                onPressed: () {
                  Navigator.pop(context, [true, inIndex]);
                })
          ],
        ),
        body: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          transitionBuilder: (child, animation) {
            Animation<double> du;
            if (child.key == ValueKey(inIndex)) {
              if (_goingUP) {
                du = Tween<double>(begin: 9, end: 1).animate(animation);
              } else {
                du = Tween<double>(begin: 0, end: 1).animate(animation);
              }
            } else {
              if (_goingUP) {
                du = Tween<double>(begin: 0, end: 0).animate(animation);
              } else {
                du = Tween<double>(begin: _scaleBegin + 9, end: _scaleBegin)
                    .animate(animation);
              }
            }
            return ScaleTransition(
              filterQuality: FilterQuality.none,
              scale: du,
              child: child,
            );
          },
          child: PinchZoom(
            key: ValueKey<int>(inIndex),
            tooBig: (x) {
              _goingUP = false;
              _scaleBegin = x;
              if (inIndex < widget.imagine.length - 1) {
                inIndex = inIndex + 1;
              } else {
                inIndex = 0;
              }
              setState(() {});
            },
            tooSmall: (x) {
              _goingUP = true;
              if (inIndex > 0) {
                inIndex = inIndex - 1;
              } else {
                inIndex = widget.imagine.length - 1;
              }
              setState(() {});
            },
            child: Hero(
              key: ValueKey<int>(inIndex),
              tag: widget.imagine[inIndex],
              child: looking(widget.imagine[inIndex],
                  tinggi: height, lebar: width),
            ),
          ),
        ));
  }

  Widget looking(Link imagine, {double lebar = 0, double tinggi = 0}) {
    Widget tryImage;
    ImageProvider<Object> assets;
    if (imagine.bitImg != null) {
      assets = MemoryImage(imagine.bitImg!);
    } else {
      assets = NetworkImage(imagine.route);
    }
    tryImage = Container(
      height: tinggi,
      width: lebar,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: assets, fit: BoxFit.contain, alignment: Alignment.center)),
    );
    return tryImage;
  }
}
