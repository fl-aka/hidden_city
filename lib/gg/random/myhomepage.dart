import 'package:flutter/material.dart';
import 'package:ta_uniska_bjm/gg/random/newmenu/dataprofile.dart';
import 'package:ta_uniska_bjm/gg/random/newmenu/diterima.dart';
import 'package:ta_uniska_bjm/gg/random/newmenu/ketaktif.dart';
import 'package:ta_uniska_bjm/gg/random/newmenu/mainmenu.dart';
import 'package:ta_uniska_bjm/gg/random/newmenu/pembimbingpkl.dart';
import 'package:ta_uniska_bjm/gg/random/newmenu/pembimbingskripsi.dart';
import 'package:ta_uniska_bjm/gg/random/newmenu/seminarpkl.dart';
import 'package:ta_uniska_bjm/gg/random/newmenu/srtokl.dart';
import 'package:ta_uniska_bjm/gg/random/sidebar.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final int title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int activeMenu = 0;
  bool _expnaded = false;
  DateTime _lastTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    activeMenu = widget.title;
    double widths = MediaQuery.of(context).size.width - 50;
    double lebar = MediaQuery.of(context).size.width;
    double tinggi = MediaQuery.of(context).size.height;
    int hi = int.parse((lebar / 200).round().toString());
    if (lebar > 499) {
      hi = hi - 1;
    }

    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 242, 1),
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                if (DateTime.now().isAfter(
                    _lastTime.add(const Duration(milliseconds: 500)))) {
                  _lastTime = DateTime.now();
                  _expnaded = !_expnaded;
                  setState(() {});
                }
              },
              child: const Icon(Icons.menu)),
          backgroundColor: const Color.fromARGB(255, 218, 62, 109),
          title: const Text("SIMTA-FTI"),
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: Stack(
            children: [
              Builder(builder: ((context) {
                if (activeMenu == 0) {
                  return MainMenu(
                    hi: hi,
                    widths: widths,
                    lebar: lebar,
                    tinggi: tinggi,
                  );
                }
                if (activeMenu == 1) return const KetAktif();
                if (activeMenu == 4) return const HasilSeminar();

                if (activeMenu == 10) return const DataProfile();
                if (activeMenu == 11) return const SeminarPkl();
                if (activeMenu == 13) return const SuratPKL();
                if (activeMenu == 19) return const Pembimbing();
                return const PembimbingPkl();
              })),
              if (_expnaded)
                GestureDetector(
                  onTap: () {
                    _expnaded = !_expnaded;
                    setState(() {});
                  },
                  child:
                      Container(color: const Color.fromARGB(122, 44, 44, 42)),
                ),
              SideBar(
                expanded: _expnaded,
                tinggi: tinggi,
                active: activeMenu,
                x: (x) {
                  _expnaded = x;
                  setState(() {});
                },
              ),
            ],
          ),
        ));
  }
}
