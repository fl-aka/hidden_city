import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ta_uniska_bjm/gg/random/myhomepage.dart';

typedef Pop = void Function(bool x);

class SideBar extends StatefulWidget {
  final bool expanded;
  final int active;
  final double tinggi;
  final Pop x;
  const SideBar(
      {Key? key,
      required this.expanded,
      required this.tinggi,
      this.active = 0,
      required this.x})
      : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  TextStyle side(int i) {
    return TextStyle(
        color: widget.active == i
            ? const Color.fromARGB(255, 218, 62, 109)
            : const Color.fromARGB(255, 61, 56, 63),
        fontFamily: "RobotoB",
        fontSize: 15);
  }

  bool _tile = false, _tile1 = false;
  final ScrollController _no = ScrollController();

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        duration: const Duration(milliseconds: 500),
        left: widget.expanded ? 0 : -310,
        top: 0,
        child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            height: widget.tinggi,
            width: 310,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: widget.tinggi - 150,
                  child: ListView(children: [
                    Container(
                      height: 190,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 170, 166, 182),
                          image: DecorationImage(
                              scale: 0.9,
                              alignment: Alignment.topLeft,
                              fit: BoxFit.none,
                              image: AssetImage("assets/img/user-bg.jpg"))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 55,
                            height: 55,
                            margin: const EdgeInsets.only(left: 15, top: 10),
                            child: const CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://ta.fti.uniska-bjm.ac.id/arsip/profile/17630204-profile.png",
                              ),
                              radius: 13,
                            ),
                          ),
                          const Spacer(),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              "FAJAR RAHMATULLAH",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 8.0, top: 4, bottom: 25),
                            child: Text(
                              "wkwkkking42@gmail.com",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 295,
                      color: const Color.fromARGB(255, 184, 182, 189),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "MAIN NAVIGATION",
                        style: side(99),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.x(false);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    const MyHomePage(title: 0)));
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.home,
                          color: widget.active == 0
                              ? const Color.fromARGB(255, 218, 62, 109)
                              : const Color.fromARGB(255, 81, 82, 92),
                        ),
                        title: Text("Home", style: side(0)),
                      ),
                    ),
                    Container(
                      width: 295,
                      color: const Color.fromARGB(255, 184, 182, 189),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "PKL",
                        style: side(99),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _tile = !_tile;
                        if (_tile1) {
                          _tile1 = false;
                        }
                        setState(() {});
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: _tile ? 225 : 60,
                        child: ListView(controller: _no, children: [
                          ListTile(
                            leading: Icon(
                              FontAwesomeIcons.fileLines,
                              color: widget.active == 11 ||
                                      widget.active == 12 ||
                                      widget.active == 13
                                  ? const Color.fromARGB(255, 218, 62, 109)
                                  : const Color.fromARGB(255, 81, 82, 92),
                            ),
                            title: Text("PKL (Praktik Kerja Lapangan)",
                                style: widget.active == 11 ||
                                        widget.active == 12 ||
                                        widget.active == 13
                                    ? side(widget.active)
                                    : side(99)),
                            trailing: _tile
                                ? Icon(
                                    Icons.remove,
                                    color: widget.active == 11 ||
                                            widget.active == 12 ||
                                            widget.active == 13
                                        ? const Color.fromARGB(
                                            255, 218, 62, 109)
                                        : const Color.fromARGB(255, 81, 82, 92),
                                  )
                                : Icon(
                                    Icons.add,
                                    color: widget.active == 11 ||
                                            widget.active == 12 ||
                                            widget.active == 13
                                        ? const Color.fromARGB(
                                            255, 218, 62, 109)
                                        : const Color.fromARGB(255, 81, 82, 92),
                                  ),
                          ),
                          if (_tile)
                            Material(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  widget.x(false);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              const MyHomePage(title: 13)));
                                },
                                child: ListTile(
                                  title: Text(
                                    "Pengajuan Surat Magang",
                                    style: widget.active == 13
                                        ? side(13)
                                        : const TextStyle(),
                                  ),
                                ),
                              ),
                            ),
                          if (_tile)
                            Material(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  widget.x(false);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              const MyHomePage(title: 12)));
                                },
                                child: ListTile(
                                  title: Text(
                                    "Cek Pembimbing PKL",
                                    style: widget.active == 12
                                        ? side(12)
                                        : const TextStyle(),
                                  ),
                                ),
                              ),
                            ),
                          if (_tile)
                            Material(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  widget.x(false);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              const MyHomePage(title: 11)));
                                },
                                child: ListTile(
                                  title: Text(
                                    "Seminar PKL",
                                    style: widget.active == 11
                                        ? side(11)
                                        : const TextStyle(),
                                  ),
                                ),
                              ),
                            ),
                        ]),
                      ),
                    ),
                    Container(
                      width: 295,
                      color: const Color.fromARGB(255, 184, 182, 189),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "SKRIPSI",
                        style: side(99),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _tile1 = !_tile1;
                        if (_tile) {
                          _tile = false;
                        }
                        setState(() {});
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: _tile1 ? 280 : 60,
                        child: ListView(controller: _no, children: [
                          ListTile(
                            leading: Icon(
                              FontAwesomeIcons.clipboardList,
                              color: widget.active == 19
                                  ? const Color.fromARGB(255, 218, 62, 109)
                                  : const Color.fromARGB(255, 81, 82, 92),
                            ),
                            title: Text(
                              "Daftar Proposal Skripsi",
                              style: side(19),
                            ),
                            trailing: _tile1
                                ? const Icon(Icons.remove)
                                : const Icon(Icons.add),
                          ),
                          if (_tile1)
                            Material(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {},
                                child: const ListTile(
                                  title: Text("Daftar Proposal Skripsi"),
                                ),
                              ),
                            ),
                          if (_tile1)
                            Material(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              const MyHomePage(title: 19)));
                                },
                                child: ListTile(
                                  title: Text(
                                    "Cek Pembimbing Skripsi",
                                    style: side(19),
                                  ),
                                ),
                              ),
                            ),
                          if (_tile1)
                            Material(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {},
                                child: const ListTile(
                                  title: Text("Daftar Sidang Skripsi"),
                                ),
                              ),
                            ),
                          if (_tile1)
                            Material(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {},
                                child: const ListTile(
                                  title: Text("Update Revisi Skripsi"),
                                ),
                              ),
                            ),
                        ]),
                      ),
                    ),
                    Container(
                      width: 295,
                      color: const Color.fromARGB(255, 184, 182, 189),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Lainnya",
                        style: side(99),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.search,
                        color: widget.active == 3
                            ? const Color.fromARGB(255, 218, 62, 109)
                            : const Color.fromARGB(255, 81, 82, 92),
                      ),
                      title: Text("Cari Judul", style: side(3)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    const MyHomePage(title: 1)));
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.mail,
                          color: widget.active == 4
                              ? const Color.fromARGB(255, 218, 62, 109)
                              : const Color.fromARGB(255, 81, 82, 92),
                        ),
                        title: Text("Surat Keterangan Mahasiswa Aktif",
                            style: side(1)),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.mail,
                        color: widget.active == 5
                            ? const Color.fromARGB(255, 218, 62, 109)
                            : const Color.fromARGB(255, 81, 82, 92),
                      ),
                      title: Text("Surat Izin Penelitian", style: side(5)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    const MyHomePage(title: 10)));
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          color: widget.active == 6
                              ? const Color.fromARGB(255, 218, 62, 109)
                              : const Color.fromARGB(255, 81, 82, 92),
                        ),
                        title: Text("Lihat Profile", style: side(10)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.popUntil(
                            context, ModalRoute.withName('/login'));
                        Navigator.pop(context);
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.exit_to_app,
                          color: widget.active == 7
                              ? const Color.fromARGB(255, 218, 62, 109)
                              : const Color.fromARGB(255, 81, 82, 92),
                        ),
                        title: Text("Logout", style: side(7)),
                      ),
                    ),
                  ]),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: const TextSpan(
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 14,
                                  color: Colors.black),
                              children: [
                            TextSpan(text: "Coded By © "),
                            TextSpan(
                                text: "Muharir",
                                style: TextStyle(
                                    fontFamily: "RobotoB",
                                    color: Color.fromARGB(255, 218, 62, 109)))
                          ])),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: RichText(
                            text: const TextSpan(
                                style: TextStyle(
                                    fontFamily: "RobotoB",
                                    fontSize: 14,
                                    color: Colors.black),
                                children: [
                              TextSpan(text: "Version: "),
                              TextSpan(
                                  text: "2.0.5",
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      color: Colors.black))
                            ])),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
