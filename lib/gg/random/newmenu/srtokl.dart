import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ta_uniska_bjm/gg/random/download.dart';
import 'package:url_launcher/url_launcher.dart';

class SuratPKL extends StatelessWidget {
  const SuratPKL({Key? key}) : super(key: key);

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
            Text("Pengajuan Surat Magang PKL",
                style: TextStyle(fontSize: 12, color: Colors.black45))
          ]),
        ),
        Card(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: const Text("LIST PENGAJUAN SURAT MAGANG"),
                subtitle: const Text("surat dapat dibuat lebih dari 1 kali"),
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
                    1: FractionColumnWidth(0.30),
                    2: FractionColumnWidth(0.25),
                    3: FractionColumnWidth(0.25),
                    4: FractionColumnWidth(0.10),
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
                          "Tujuan SURAT",
                          style: bB,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Tahun Pengajuan",
                          style: bB,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Ditandatangi",
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
                          "Dinas Komunikasi Informatika, Statiska dan Persandian Kabupaten Banjar Jl. A. Yani No.3, Cindai Alus, Kec. Martapura, Banjar, Kalimantan Selatan 70614",
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "2021/2022 Ganjil",
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Dr. Hj. Silvia Ratna, S.Kom., M.Kom",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                String urlString = await DownloadFromFb()
                                    .getData("suratpkl.pdf");
                                launchUrl(Uri.parse(urlString));
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 3, bottom: 3, left: 5, right: 5),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Icon(
                                  Icons.download,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 3, bottom: 3, left: 5, right: 5),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Icon(
                                Icons.zoom_in,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Keterangan :",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontFamily: "RobotoB"),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Icon(
                    FontAwesomeIcons.pen,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                    width: width - 90,
                    child: const Text(
                        "Data dapat diedit jika belum di verifikasi fakultas dan belum ada nomor surat"),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Icon(
                    FontAwesomeIcons.arrowRotateRight,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                    width: width - 90,
                    child: const Text(
                        "Jika data sudah diverifikasi dan sudah diberikan nomor, anda dapat memperbaharui surat dengan tujuan surat dan nomor yang berbeda"),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Icon(
                    Icons.zoom_in,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                    width: width - 90,
                    child: const Text("Melihat detail surat"),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Icon(
                    Icons.download,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                    width: width - 90,
                    child: const Text("Download Surat"),
                  ),
                )
              ],
            ),
            const SizedBox(height: 50)
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
      width: lebar < 500 ? 128 : 190,
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
                    width: lebar < 500 ? 65 : 120,
                    child: const Text("Tambah Pengajuan")),
              ),
            ],
          )),
    );
  }
}
