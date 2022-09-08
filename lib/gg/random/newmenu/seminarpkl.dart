import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hidden_city/gg/random/download.dart';
import 'package:url_launcher/url_launcher.dart';

class SeminarPkl extends StatelessWidget {
  const SeminarPkl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 15,
        widthA = width - ((width / 3) * 2.5) + 16,
        widthB = width - (width - ((width / 3) * 2)) - 15;

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
            Text("Seminar PKL",
                style: TextStyle(fontSize: 12, color: Colors.black45))
          ]),
        ),
        Card(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: const Text("DATA PENDAFTARAN SIDANG PKL"),
                subtitle: const Text("Data Pendaftaran Sidang PKL"),
                trailing: SizedBox(
                  width: 132,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 218, 62, 109)),
                      onPressed: () {},
                      child: Row(
                        children: const [
                          Icon(FontAwesomeIcons.fileLines),
                          Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Text("Edit Data"),
                          )
                        ],
                      )),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5),
              child: Divider(),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 5, bottom: 5, top: 5),
              child: Row(
                children: [
                  SizedBox(
                      width: widthA,
                      child: Text(
                        "NPM",
                        style: bB,
                      )),
                  SizedBox(
                    width: widthB,
                    child: const Text(": 17630204"),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 5, bottom: 5, top: 5),
              child: Row(
                children: [
                  SizedBox(
                      width: widthA,
                      child: Text(
                        "Nama",
                        style: bB,
                      )),
                  SizedBox(
                    width: widthB,
                    child: const Text(": FAJAR RAHMATULLAH"),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 5, bottom: 5, top: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: widthA,
                    child: Text(
                      "Judul pkl",
                      style: bB,
                    ),
                  ),
                  SizedBox(
                    width: widthB,
                    child: const Text(
                        ": Aplikasi Pengajuan, Pemasangan Baru, Pelayanan dan Pelaporan Gangguan WIFI Gratis Berbasis Android"),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 5, bottom: 5, top: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: widthA,
                    child: Text(
                      "Pembimbing PKL",
                      style: bB,
                    ),
                  ),
                  SizedBox(
                    width: widthB,
                    child: const Text(": Muthia Farida, S.Kom, M.Kom"),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 5, bottom: 5, top: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: widthA,
                    child: Text(
                      "Kelas",
                      style: bB,
                    ),
                  ),
                  SizedBox(
                    width: widthB,
                    child: const Text(": REG 7C BJB"),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 5, bottom: 5, top: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: widthA,
                    child: Text(
                      "No. Telepon",
                      style: bB,
                    ),
                  ),
                  SizedBox(
                    width: widthB,
                    child: const Text(": +6289635920098"),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 5, bottom: 5, top: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: widthA,
                    child: Text(
                      "KARTU BIMBINGAN PKL",
                      style: bB,
                    ),
                  ),
                  SizedBox(
                    width: widthB,
                    child: RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              color: Colors.black, fontFamily: "Roboto"),
                          children: [
                            const TextSpan(text: ": "),
                            TextSpan(
                                text: "Lihat File",
                                style: const TextStyle(
                                    color: Colors.blue, fontFamily: "RobotoB"),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    String urlString = await DownloadFromFb()
                                        .getData("pembimbing.pdf");
                                    launchUrl(Uri.parse(urlString));
                                  })
                          ]),
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 5, bottom: 5, top: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: widthA,
                    child: Text(
                      "File PKL",
                      style: bB,
                    ),
                  ),
                  SizedBox(
                    width: widthB,
                    child: Row(
                      children: [
                        const Text(": "),
                        GestureDetector(
                          onTap: () async {
                            String urlString =
                                await DownloadFromFb().getData("lappkl.pdf");
                            launchUrl(Uri.parse(urlString));
                          },
                          child: const Text(
                            "Lihat File",
                            style: TextStyle(
                                color: Colors.blue, fontFamily: "RobotoB"),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 20,
                          width: 3,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 3, bottom: 3, left: 5, right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.indigo,
                          ),
                          child: const Text(
                            "Ganti File",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "RobotoB"),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 5, bottom: 5, top: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: widthA,
                    child: Text(
                      "Status",
                      style: bB,
                    ),
                  ),
                  SizedBox(
                    width: widthB,
                    child: Row(
                      children: [
                        const Text(": "),
                        Container(
                          width: 120,
                          padding: const EdgeInsets.only(
                              top: 3, bottom: 3, left: 5, right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromARGB(255, 38, 116, 77),
                          ),
                          child: const Text(
                            "Sudah terverifikasi",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "RobotoB"),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 5, bottom: 5, top: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: widthA,
                    child: Text(
                      "Status Pengajuan",
                      style: bB,
                    ),
                  ),
                  SizedBox(
                    width: widthB,
                    child: Row(
                      children: [
                        const Text(": "),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 3, bottom: 3, left: 5, right: 5),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Text(
                            "Baru",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "RobotoB"),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5),
              child: Divider(),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 224, 228, 230),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Informasi",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "RobotoB",
                        color: Color.fromARGB(255, 218, 62, 109)),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                      "Selamat data sudah diverifikasi oleh fakultas. Tunggu jadwal sidang yang akan diumumkan."),
                  const SizedBox(
                    height: 6,
                  ),
                  const Text(
                      "Jika anda ingin memperpanjang pengajuan PKL anda bisa mengklik tombol berikut"),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 3, bottom: 3, left: 5, right: 5),
                    decoration:
                        BoxDecoration(color: Colors.blue, border: Border.all()),
                    child: const Text(
                      "Ajukan Pengajuan Ulang",
                      style:
                          TextStyle(color: Colors.white, fontFamily: "RobotoB"),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ],
    );
  }
}
