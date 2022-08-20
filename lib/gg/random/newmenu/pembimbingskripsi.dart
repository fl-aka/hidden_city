import 'package:flutter/material.dart';

class Pembimbing extends StatelessWidget {
  const Pembimbing({Key? key}) : super(key: key);

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
              Icons.person,
              size: 14,
              color: Colors.black45,
            ),
            SizedBox(
              width: 5,
            ),
            Text("Cek Pembimbing",
                style: TextStyle(fontSize: 12, color: Colors.black45))
          ]),
        ),
        Card(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text("DATA PEMBIMBING 1 DAN PEMBIMBING 2"),
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
                    ),
                  ),
                  const SizedBox(
                    width: 5,
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
                        "Nama",
                        style: bB,
                      )),
                  const SizedBox(
                    width: 5,
                  ),
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
                        "Pembimbing 1",
                        style: bB,
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: widthB,
                    child: const Text(": Budi Ramadhani, S.Kom, M.Kom || -"),
                  )
                ],
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
                        "Pembimbing 2",
                        style: bB,
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: widthB,
                    child: RichText(
                        text: const TextSpan(
                            children: [
                          TextSpan(text: ": Budi Setiadi, S.Kom., M.Kom || "),
                          TextSpan(
                              style: TextStyle(color: Colors.blue),
                              text: "081254976999")
                        ],
                            style: TextStyle(
                                fontFamily: "Roboto", color: Colors.black))),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5),
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 240, 190, 54)),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text("CETAK SK PEMBIMBING"),
                      )),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5, bottom: 40),
              child: Divider(),
            ),
          ]),
        ),
      ],
    );
  }
}
