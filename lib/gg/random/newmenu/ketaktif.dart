import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ta_uniska_bjm/gg/random/download.dart';
import 'package:url_launcher/url_launcher.dart';

class DataPembimbing extends StatelessWidget {
  const DataPembimbing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class KetAktif extends StatelessWidget {
  const KetAktif({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    TextStyle bB = const TextStyle(fontFamily: "RobotoB");

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 50, left: 25, bottom: 20),
          child: Row(children: const [
            Icon(
              Icons.home,
              size: 14,
              color: Colors.black87,
            ),
            SizedBox(
              width: 5,
            ),
            Text("Home", style: TextStyle(fontSize: 12, color: Colors.black87)),
            SizedBox(
              width: 5,
            ),
            Text(">", style: TextStyle(fontSize: 12, color: Colors.black45)),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.book,
              size: 14,
              color: Colors.black45,
            ),
            SizedBox(
              width: 5,
            ),
            Text("Pengajuan Surat Mahasiswa Aktif",
                style: TextStyle(fontSize: 12, color: Colors.black45))
          ]),
        ),
        Card(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: const Text("DATA SURAT KETERANGAN MAHASISWA AKTIF"),
                subtitle:
                    const Text("Isi Data Pengajuan Surat Mahasiswa Aktif"),
                trailing: Button(
                  lebar: width,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5),
              child: Divider(),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: width < 500 ? 500 : width,
                padding: const EdgeInsets.all(10),
                child: Table(
                  columnWidths: const {
                    0: FractionColumnWidth(0.10),
                    1: FractionColumnWidth(0.20),
                    2: FractionColumnWidth(0.25),
                    3: FractionColumnWidth(0.25),
                    4: FractionColumnWidth(0.20),
                  },
                  border: TableBorder.all(),
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "No.",
                          style: bB,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "NOMOR SURAT",
                          style: bB,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "TUJUAN",
                          style: bB,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "STATUS",
                          style: bB,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "AKSI",
                          style: bB,
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "1",
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "206",
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Tunjangan Gaji",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 3, bottom: 3, left: 5, right: 5),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Text(
                            "Sudah Di TTD",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "RobotoB"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            String urlString = await DownloadFromFb()
                                .getData("surataktif1.pdf");
                            launchUrl(Uri.parse(urlString));
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 3, bottom: 3, left: 5, right: 5),
                            decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Text(
                              "Download",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: "RobotoB"),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "2",
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "103",
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Melengkapi Berkas Pendaftaran Perguruan Tinggi Saudara Kandung",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 3, bottom: 3, left: 5, right: 5),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Text(
                            "Sudah Di TTD",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "RobotoB"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            String urlString = await DownloadFromFb()
                                .getData("surataktif.pdf");
                            launchUrl(Uri.parse(urlString));
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 3, bottom: 3, left: 5, right: 5),
                            decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Text(
                              "Download",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: "RobotoB"),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            )
          ]),
        ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  final double lebar;
  const Button({
    Key? key,
    required this.lebar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: lebar < 500 ? 111 : 190,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 218, 62, 109)),
          onPressed: () {},
          child: Row(
            children: [
              const Icon(FontAwesomeIcons.fileLines),
              Padding(
                padding: const EdgeInsets.only(left: 7.0, top: 7.0, bottom: 7),
                child: SizedBox(
                    width: lebar < 500 ? 48 : 120,
                    child: const Text("Tambah Ajuan Surat")),
              ),
            ],
          )),
    );
  }
}
