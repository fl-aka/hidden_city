import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hidden_city/gg/draw/preview.dart';
import 'package:hidden_city/utils/backend/honeys/link.dart';
import 'package:hidden_city/gg/gallery/main_content.dart';

class GaleriPage extends StatefulWidget {
  const GaleriPage({super.key, this.delInd = 0, this.delete = false});
  final int delInd;
  final bool delete;

  @override
  State<GaleriPage> createState() => _GaleriPageState();
}

class _GaleriPageState extends State<GaleriPage> {
  bool saving = false, deleting = false;
  int index = 0;
  String saveThis = '';
  String _boxName = "Link";

  Future<Uint8List?> hex(String x) async {
    await Hive.openBox(_boxName);
    if (saving) {
      http.Response response = await http.get(Uri.parse(x));
      return response.bodyBytes;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text(
              "Link Secret Gallery",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                  icon: const Icon(
                    Icons.airplay,
                    color: Colors.green,
                  ),
                  onPressed: () async {
                    _boxName = await getTextFromDl(
                            context, "Enter Box Name", "Box Name Here") ??
                        "Link";
                    setState(() {});
                  }),
            ]),
        body: FutureBuilder<Uint8List?>(
          future: hex(saveThis),
          builder: (context, ss) {
            if (ss.connectionState == ConnectionState.done) {
              var linkBox = Hive.box(_boxName);
              if (saving) {
                if (ss.hasData) {
                  linkBox.add(Link(saveThis, bitImg: ss.data));
                } else {
                  linkBox.add(Link(saveThis));
                }
                saving = false;
              }
              if (deleting) {
                linkBox.deleteAt(index);
                deleting = false;
              }

              return MainContent(
                a: linkBox,
                b: (val) {
                  setState(() {
                    if (val != '') {
                      saveThis = val;
                      saving = true;
                    }
                  });
                },
                c: (val) {
                  setState(() {
                    deleting = true;
                    index = val;
                  });
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
