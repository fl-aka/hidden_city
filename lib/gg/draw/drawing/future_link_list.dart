import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ta_uniska_bjm/utils/backend/honeys/link.dart';

class ListFromLink extends StatefulWidget {
  const ListFromLink({super.key, this.current, required this.changeOld});
  final Uint8List? current;
  final Function(Uint8List x) changeOld;

  @override
  State<ListFromLink> createState() => _ListFromLinkState();
}

class _ListFromLinkState extends State<ListFromLink> {
  List<Widget> x = [];
  late ImageProvider q;

  Future<void> _openBoxes() async {
    await Hive.openBox('Link');
    await Hive.openBox('Memimage');
  }

  Widget cntnr(ImageProvider qq) {
    return Container(
        margin: const EdgeInsets.only(left: 2.5, right: 2.5),
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          border: Border.all(),
          shape: BoxShape.circle,
          image: DecorationImage(fit: BoxFit.cover, image: qq),
        ));
  }

  @override
  void initState() {
    if (widget.current != null) {
      q = MemoryImage(widget.current!);
    } else {
      q = const AssetImage('assets/img/hiddencity.png');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (x.isEmpty) {
      x.add(cntnr(q));
    }
    return SizedBox.expand(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: FutureBuilder(
          future: _openBoxes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var imgBox = Hive.box('Link');
              var lstBox = Hive.box('Memimage');

              if (x.length == 1) {
                for (int i = 0; i < imgBox.length; i++) {
                  Link now = imgBox.getAt(i);
                  x.add(GestureDetector(
                    onTap: () {
                      if (lstBox.isEmpty) {
                        lstBox.add(now.bitImg);
                      } else {
                        lstBox.putAt(0, now.bitImg!);
                      }
                      widget.changeOld(now.bitImg!);
                    },
                    child: cntnr(MemoryImage(now.bitImg!)),
                  ));
                }
              }

              return Row(key: const ValueKey<int>(2), children: x);
            }
            return const Center();
          },
        ),
      ),
    );
  }
}
