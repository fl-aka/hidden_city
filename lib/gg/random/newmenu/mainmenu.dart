import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ta_uniska_bjm/gg/random/download.dart';
import 'package:ta_uniska_bjm/gg/random/myhomepage.dart';
import 'package:ta_uniska_bjm/utils/plainVar/text.dart';
import 'package:url_launcher/url_launcher.dart';

class MainMenu extends StatefulWidget {
  final int hi;
  final double widths;
  final double lebar;
  final double tinggi;
  const MainMenu(
      {Key? key,
      required this.hi,
      required this.widths,
      required this.lebar,
      required this.tinggi})
      : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final ScrollController _rollCon = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 25, bottom: 10, left: 25),
          child: Text(
            'PINTASAN',
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(
          width: widget.widths,
          height: 8 / widget.hi * 100 + 55,
          child: GridView.builder(
              controller: _rollCon,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.hi,
                  childAspectRatio: 3 / 1.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: 8,
              itemBuilder: (BuildContext ctx, index) {
                late Icon ico;
                late String text;
                late Color colo1;
                late Color colo2;

                switch (index) {
                  case 0:
                    ico = const Icon(
                      Icons.mail,
                      size: 40,
                      color: Colors.white,
                    );
                    text = "SURAT MHS AKTIF";
                    colo1 = const Color.fromARGB(255, 20, 190, 212);
                    colo2 = const Color.fromARGB(255, 21, 165, 184);
                    break;
                  case 1:
                    ico = const Icon(
                      Icons.mail,
                      size: 40,
                      color: Colors.white,
                    );
                    text = "SURAT PKL MAHASISWA";
                    colo1 = const Color.fromARGB(255, 20, 190, 212);
                    colo2 = const Color.fromARGB(255, 21, 165, 184);
                    break;
                  case 2:
                    ico = const Icon(
                      FontAwesomeIcons.fileLines,
                      size: 40,
                      color: Colors.white,
                    );
                    text = "SEMINAR PKL";
                    colo1 = const Color.fromARGB(255, 20, 190, 212);
                    colo2 = const Color.fromARGB(255, 21, 165, 184);
                    break;
                  case 3:
                    ico = const Icon(
                      FontAwesomeIcons.clipboardList,
                      size: 40,
                      color: Colors.white,
                    );
                    text = "PROPOSAL SKRIPSI";
                    colo1 = const Color.fromARGB(255, 20, 190, 212);
                    colo2 = const Color.fromARGB(255, 21, 165, 184);
                    break;
                  case 4:
                    ico = const Icon(
                      Icons.check,
                      size: 40,
                      color: Colors.white,
                    );
                    text = "HASIL SIDANG PROPOSAL";
                    colo1 = const Color.fromARGB(255, 20, 190, 212);
                    colo2 = const Color.fromARGB(255, 21, 165, 184);
                    break;
                  case 5:
                    ico = const Icon(
                      FontAwesomeIcons.graduationCap,
                      size: 40,
                      color: Colors.white,
                    );
                    text = "SIDANG SKRIPSI";
                    colo1 = const Color.fromARGB(255, 20, 190, 212);
                    colo2 = const Color.fromARGB(255, 21, 165, 184);
                    break;
                  case 6:
                    ico = const Icon(
                      Icons.check,
                      size: 40,
                      color: Colors.white,
                    );
                    text = "SK SIDANG SKRIPSI";
                    colo1 = const Color.fromARGB(255, 148, 34, 129);
                    colo2 = const Color.fromARGB(255, 124, 27, 108);
                    break;
                  case 7:
                    ico = const Icon(
                      FontAwesomeIcons.certificate,
                      size: 40,
                      color: Colors.white,
                    );
                    text = "SK PENGAMBILAN IJAZAH";
                    colo1 = const Color.fromARGB(255, 148, 34, 129);
                    colo2 = const Color.fromARGB(255, 124, 27, 108);
                    break;

                  default:
                    ico = const Icon(Icons.warehouse);
                    text = "unknown";
                    colo1 = Colors.amber;
                    colo2 = Colors.blue;
                }
                return GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    const MyHomePage(title: 1)));
                      }
                      if (index == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    const MyHomePage(title: 13)));
                      }

                      if (index == 2) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    const MyHomePage(title: 11)));
                      }
                      if (index == 4) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    const MyHomePage(title: 4)));
                      }
                    },
                    child: pintasanPil(ico, colo1, colo2, text));
              }),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 25, bottom: 10, left: 25),
          child: Text(
            'MADING ONLINE',
            style: TextStyle(fontSize: 18),
          ),
        ),
        mading(judul: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 15, right: 15),
            child: Text(
              judel2,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 25.0, top: 5, right: 15, bottom: 15),
            child: Text(
              subJudul,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          )
        ], isi: [
          Container(
              padding: const EdgeInsets.only(top: 17, left: 17),
              child: RichText(
                  text: const TextSpan(
                style: TextStyle(
                    fontFamily: "Roboto", fontSize: 14, color: Colors.black),
                children: [
                  TextSpan(
                      text:
                          "Seminar Proposal Skripsi Tahun Akademik 2021/2022 Semester Genap akan dilaksanakan pada hari "),
                  TextSpan(
                      text: "Jum'at, 8 April 2022.",
                      style: TextStyle(fontFamily: "RobotoB"))
                ],
              ))),
          Container(
              padding: const EdgeInsets.only(top: 17, left: 17),
              child: const Text(
                  "Persiapan yang dilakukan untuk mengikuti Seminar Proposal Skripsi adalah sebagai berikut:")),
          lit(widget.widths),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("4."),
                SizedBox(
                    width: widget.widths - 100,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 2.0),
                      child: Text(
                          "(Untuk Wanita Memakai Jilbab Putih) Wajib Pakai Dasi (Pria/Wanita)"),
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("5."),
                SizedBox(
                    width: widget.widths - 100,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 2.0),
                      child: Text(
                          "Seminar Proposal Skripsi Dilakukan Secara Online Link Zoom Akan Di-infokan Di Group Kelompok Masing-Masing"),
                    ))
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.only(top: 17, left: 17, bottom: 17),
              child: RichText(
                text: TextSpan(
                    style: const TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 14,
                        color: Colors.black),
                    children: [
                      const TextSpan(
                          text:
                              "Jadwal dan Pembagian Kelompok Seminar Proposal "),
                      const TextSpan(text: "Skripsi, silahkan "),
                      TextSpan(
                          text: "Download disini!",
                          style: const TextStyle(
                              fontFamily: "RobotoB", color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              String urlString = await DownloadFromFb()
                                  .getData("Jadwal-Proposal-Skripsi.pdf");
                              launchUrl(Uri.parse(urlString));
                            })
                    ]),
              )),
          Padding(
            padding: const EdgeInsets.only(right: 17, bottom: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "Infomasi diupdate oleh ",
                  style: TextStyle(fontFamily: "RobotoI"),
                ),
                Text(
                  "Admin FTI",
                  style: TextStyle(
                      fontFamily: "RobotoI", fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ]),
        mading(judul: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 15, right: 15),
            child: Text(
              judel,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 25.0, top: 5, right: 15, bottom: 15),
            child: Text(
              subJudul,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          )
        ], isi: [
          Container(
              padding: const EdgeInsets.only(top: 17, left: 17),
              child: RichText(
                  text: const TextSpan(
                style: TextStyle(
                    fontFamily: "Roboto", fontSize: 14, color: Colors.black),
                children: [
                  TextSpan(
                      text:
                          "Seminar Proposal Skripsi Tahun Akademik 2021/2022 Semester Genap akan dilaksanakan pada hari "),
                  TextSpan(
                      text: "Jum'at, 1 April 2022.",
                      style: TextStyle(fontFamily: "RobotoB"))
                ],
              ))),
          Container(
              padding: const EdgeInsets.only(top: 17, left: 17),
              child: const Text(
                  "Persiapan yang dilakukan untuk mengikuti Seminar Proposal Skripsi adalah sebagai berikut:")),
          lit(widget.widths),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("4."),
                SizedBox(
                    width: widget.widths - 100,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 2.0),
                      child: Text(
                          "(Untuk Wanita Memakai Jilbab Putih) Wajib Pakai Dasi (Pria/Wanita)"),
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("5."),
                SizedBox(
                    width: widget.widths - 100,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 2.0),
                      child: Text(
                          "Seminar Proposal Skripsi Dilakukan Secara Online Link Zoom Akan Di-infokan Di Group Kelompok Masing-Masing"),
                    ))
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.only(top: 17, left: 17, bottom: 17),
              child: RichText(
                text: TextSpan(
                    style: const TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 14,
                        color: Colors.black),
                    children: [
                      const TextSpan(
                          text:
                              "Jadwal dan Pembagian Kelompok Seminar Proposal "),
                      const TextSpan(text: "Skripsi, silahkan "),
                      TextSpan(
                          text: "Download disini!",
                          style: const TextStyle(
                              fontFamily: "RobotoB", color: Colors.blue),
                          recognizer: TapGestureRecognizer()..onTap = () {})
                    ]),
              )),
          Padding(
            padding: const EdgeInsets.only(right: 17, bottom: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "Infomasi diupdate oleh ",
                  style: TextStyle(fontFamily: "RobotoI"),
                ),
                Text(
                  "Admin FTI",
                  style: TextStyle(
                      fontFamily: "RobotoI", fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ]),
        mading(judul: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 15, right: 15),
            child: Text(
              judul2,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 25.0, top: 5, right: 15, bottom: 15),
            child: Text(
              subJudul,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          )
        ], isi: [
          Container(
              padding: const EdgeInsets.only(top: 17, left: 17),
              child: RichText(
                text: const TextSpan(
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 14,
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              "Kepada seluruh mahasiswa yang telah menyelesaikan sidang Skripsi Tahun Akademik 2020/2021 Genap dan telah menyelesaikan semua revisi dari penguji, untuk mengupload hasil revisi (File"),
                      TextSpan(
                          text: ".PDF",
                          style: TextStyle(fontFamily: "RobotoB")),
                      TextSpan(text: ") di web ini")
                    ]),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 17, right: 17, bottom: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "Infomasi diupdate oleh ",
                  style: TextStyle(fontFamily: "RobotoI"),
                ),
                Text(
                  "Admin FTI",
                  style: TextStyle(
                      fontFamily: "RobotoI", fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ]),
        mading(judul: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 15, right: 15),
            child: Text(
              judul3,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 25.0, top: 5, right: 15, bottom: 15),
            child: Text(
              subJudul,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          )
        ], isi: [
          Container(
              padding: const EdgeInsets.only(top: 17, left: 17),
              child: RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(text: "Sidang Skripsi dilaksanakan pada hari "),
                      TextSpan(
                          text:
                              "Rabu, 18 Agustus 2021, mulai Jam 08.30 s.d selesai.",
                          style: TextStyle(fontFamily: "RobotoB")),
                      TextSpan(text: " Silahkan cek Kelompok anda (terlampir)")
                    ],
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 14,
                        color: Colors.black)),
              )),
          Container(
              padding: const EdgeInsets.only(top: 17, left: 17),
              child: const Text(
                  "Yang perlu dipersiapkan untuk sidang skripsi adalah sebagai berikut:")),
          lit(widget.widths, a: true),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("4."),
                SizedBox(
                    width: widget.widths - 100,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 2.0),
                      child: Text(
                          "Sidang skripsi dilakukan secara online melalui zoom dan group akan di buat oleh penguji"),
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("5."),
                SizedBox(
                    width: widget.widths - 100,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: RichText(
                            text: const TextSpan(
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.black,
                                    fontSize: 14),
                                children: [
                              TextSpan(text: "Silahkan Cek Pembagian "),
                              TextSpan(
                                  text:
                                      "kelompok sidang Skripsi sesi 3, klik Download.",
                                  style: TextStyle(color: Colors.blue))
                            ]))))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 17, right: 17, bottom: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "Infomasi diupdate oleh ",
                  style: TextStyle(fontFamily: "RobotoI"),
                ),
                Text(
                  "Admin FTI",
                  style: TextStyle(
                      fontFamily: "RobotoI", fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ]),
        mading(judul: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 15, right: 15),
            child: Text(
              judul4,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 25.0, top: 5, right: 15, bottom: 15),
            child: Text(
              subJudul,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          )
        ], isi: [
          Container(
              padding: const EdgeInsets.only(top: 17, left: 17),
              child: RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(text: "Sidang Skripsi dilaksanakan pada hari "),
                      TextSpan(
                          text:
                              "Senin, 16 Agustus 2021, mulai Jam 08.30 s.d selesai.",
                          style: TextStyle(fontFamily: "RobotoB")),
                      TextSpan(text: " Silahkan cek Kelompok anda (terlampir)")
                    ],
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 14,
                        color: Colors.black)),
              )),
          Container(
              padding: const EdgeInsets.only(top: 17, left: 17),
              child: const Text(
                  "Yang perlu dipersiapkan untuk sidang skripsi adalah sebagai berikut:")),
          lit(widget.widths, a: true),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("4."),
                SizedBox(
                    width: widget.widths - 100,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 2.0),
                      child: Text(
                          "Sidang skripsi dilakukan secara online melalui zoom dan group akan di buat oleh penguji"),
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("5."),
                SizedBox(
                    width: widget.widths - 100,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: RichText(
                            text: const TextSpan(
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.black,
                                    fontSize: 14),
                                children: [
                              TextSpan(text: "Silahkan Cek Pembagian "),
                              TextSpan(
                                  text:
                                      "kelompok sidang Skripsi sesi 2, klik Download.",
                                  style: TextStyle(color: Colors.blue))
                            ]))))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 17, right: 17, bottom: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "Infomasi diupdate oleh ",
                  style: TextStyle(fontFamily: "RobotoI"),
                ),
                Text(
                  "Admin FTI",
                  style: TextStyle(
                      fontFamily: "RobotoI", fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ]),
        mading(warna: const Color.fromARGB(255, 55, 125, 216), judul: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 15, right: 15),
            child: Text(
              judul5,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 25.0, top: 5, right: 15, bottom: 15),
            child: Text(
              subJudul,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          )
        ], isi: [
          Container(
              padding: const EdgeInsets.only(top: 17, left: 17),
              child: RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(text: "Sidang Skripsi dilaksanakan pada hari "),
                      TextSpan(
                          text:
                              "Jum'at, 13 Agustus 2021, mulai Jam 08.30 s.d selesai.",
                          style: TextStyle(fontFamily: "RobotoB")),
                      TextSpan(text: " Silahkan cek Kelompok anda (terlampir)")
                    ],
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 14,
                        color: Colors.black)),
              )),
          Container(
              padding: const EdgeInsets.only(top: 17, left: 17),
              child: const Text(
                  "Yang perlu dipersiapkan untuk sidang skripsi adalah sebagai berikut:")),
          lit(widget.widths, a: true),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("4."),
                SizedBox(
                    width: widget.widths - 100,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 2.0),
                      child: Text(
                          "Sidang skripsi dilakukan secara online melalui zoom dan group akan di buat oleh penguji"),
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("5."),
                SizedBox(
                    width: widget.widths - 100,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: RichText(
                            text: const TextSpan(
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.black,
                                    fontSize: 14),
                                children: [
                              TextSpan(text: "Silahkan Cek Pembagian "),
                              TextSpan(
                                  text:
                                      "kelompok sidang Skripsi sesi 1, klik Download.",
                                  style: TextStyle(color: Colors.blue))
                            ]))))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 17, right: 17, bottom: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "Infomasi diupdate oleh ",
                  style: TextStyle(fontFamily: "RobotoI"),
                ),
                Text(
                  "Admin FTI",
                  style: TextStyle(
                      fontFamily: "RobotoI", fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ]),
      ],
    );
  }

  Widget pintasanPil(Icon ico, Color warna, Color warna2, String text) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        elevation: 5,
        color: warna,
        child: SizedBox(
            width: 160,
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 100,
                  color: warna2,
                  child: ico,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    width: 80,
                    child: Center(
                      child: Text(
                        text,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget lit(double widths, {bool a = false}) {
    String subjek = "Proposal";
    if (a) {
      subjek = "Skripsi";
    }
    return Padding(
      padding: const EdgeInsets.only(
        left: 50,
        top: 15,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(a
            ? "1. Power Point 10-12 Slide"
            : "1. Power point 10-12 slide pastikan aplikasi jalan."),
        const SizedBox(
          height: 2,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("2."),
            SizedBox(
                width: widths - 100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Text(
                      "Naskah $subjek 1 Rangkap Ukuran A4 (Untuk Pegangan Sendiri Saat Ujian Lewat Online)"),
                ))
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("3."),
            SizedBox(
                width: widths - 100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Pakaian Putih Hitam Memakai Almamater"),
                      if (a) const Text("Wajib pakai dasi (pria/wanita)")
                    ],
                  ),
                ))
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        const SizedBox(
          height: 2,
        ),
      ]),
    );
  }

  Widget mading(
      {required List<Widget> judul,
      required List<Widget> isi,
      Color warna = const Color.fromARGB(255, 54, 121, 121)}) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Card(
        elevation: 5,
        child: SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 20,
                  color: warna,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: judul),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: isi),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
