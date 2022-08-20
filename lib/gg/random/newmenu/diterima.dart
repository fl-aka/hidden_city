import 'package:flutter/material.dart';

class DataPembimbing extends StatelessWidget {
  const DataPembimbing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HasilSeminar extends StatelessWidget {
  const HasilSeminar({Key? key}) : super(key: key);

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
            Text("HASIL SEMINAR PROPOSAL SKRIPSI",
                style: TextStyle(fontSize: 12, color: Colors.black45))
          ]),
        ),
        Card(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: const Text("HASIL SEMINAR PROPOSAL SKRIPSI"),
                subtitle: const Text(
                    "Data Hasil Pendaftaran Seminar Proposal Skripsi"),
                trailing: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 91, 5, 250)),
                      onPressed: () {},
                      child: Row(
                        children: const [
                          Icon(Icons.print),
                          Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Text("Print"),
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
                      "NPM",
                      style: bB,
                    ),
                  ),
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
                        "Prodi",
                        style: bB,
                      )),
                  SizedBox(
                    width: widthB,
                    child: const Text(": TEKNIK INFORMATIKA"),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: widthA,
                      child: Text(
                        "Judul",
                        style: bB,
                      )),
                  SizedBox(
                    width: widthB,
                    child: const Text(
                        ": APLIKASI PENGELOLAAN PENGEMBANGAN DIRI DENGAN KOMUNITAS DI DAERAH MARTAPURA DAN BANJARBARU"),
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
                        "Tanggal Seminar",
                        style: bB,
                      )),
                  SizedBox(
                    width: widthB,
                    child: Wrap(
                      children: const [Text(":"), Text(" 8 April 2022")],
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
                        "Status Proposal",
                        style: bB,
                      )),
                  SizedBox(
                      width: widthB,
                      child: Wrap(children: const [
                        Text(":"),
                        Text(
                          " DISETUJUI DENGAN CATATAN",
                          style: TextStyle(fontFamily: "RobotoB"),
                        )
                      ]))
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
                        "Catatan",
                        style: bB,
                      )),
                  SizedBox(
                      width: widthB,
                      child: Wrap(children: const [
                        Text(
                          ": Judul dapat disetujui dengan catatan : * Redaksi judul ubah menjadi seperti yang disarankan penelis 1 * Report Minimal 8 * Harus ada penyempurnaan dari penelitian sejenis yg sudah ada sebelumnya (minimal ada 4 penambahan report/fitur) * Pertimbangkan usulan penelis yg layak dilaksanakan",
                          style: TextStyle(fontSize: 14),
                        )
                      ]))
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
                        "Yang Menyetujui",
                        style: bB,
                      )),
                  SizedBox(
                      width: widthB,
                      child: Wrap(children: [
                        const Text(": DR IR. H. M. MUFLIH M.KOM"),
                        RichText(
                            text: const TextSpan(
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 14,
                                    color: Colors.black),
                                children: [
                              TextSpan(
                                  text: " pada ",
                                  style: TextStyle(
                                      fontFamily: "RobotoB",
                                      color: Colors.black)),
                              TextSpan(text: "28 May 2022"),
                            ])),
                      ]))
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5),
              child: Divider(),
            ),
          ]),
        ),
      ],
    );
  }
}
