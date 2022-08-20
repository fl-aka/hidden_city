import 'package:flutter/material.dart';

class PembimbingPkl extends StatelessWidget {
  const PembimbingPkl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width - 15,
    //     widthA = width - ((width / 3) * 2.5) + 16,
    //     widthB = width - (width - ((width / 3) * 2)) - 15;
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
                title: Text("DATA PEMBIMBING PKL"),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5),
              child: Divider(),
            ),
            Container(
              margin:
                  const EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 50),
              padding: const EdgeInsets.all(20),
              color: Colors.red,
              child: const Text(
                "Pembimbing PKL Belum ditentukan fakultas. Tunggu ya ^^",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
          ]),
        ),
      ],
    );
  }
}
