import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DataProfile extends StatelessWidget {
  const DataProfile({Key? key}) : super(key: key);

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
            Text("Profile",
                style: TextStyle(fontSize: 12, color: Colors.black45))
          ]),
        ),
        Card(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: const Text("DATA PROFILE"),
                subtitle: const Text("Profile Anda Sudah Lengkap.."),
                trailing: SizedBox(
                  width: 132,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 218, 62, 109)),
                      onPressed: () {},
                      child: Row(
                        children: const [
                          Icon(FontAwesomeIcons.pencil),
                          Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Text("Edit Profile"),
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
                      "Tempat, Tanggal Lahir",
                      style: bB,
                    ),
                  ),
                  SizedBox(
                    width: widthB,
                    child: const Text(": Banjarbaru, 20 April 1998"),
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
                      "Email",
                      style: bB,
                    ),
                  ),
                  SizedBox(
                    width: widthB,
                    child: const Text(": wkwkking42@gmail.com"),
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
                      "Alamat",
                      style: bB,
                    ),
                  ),
                  SizedBox(
                    width: widthB,
                    child: const Text(": Jln Sekumpul Gang Purnama no 63"),
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
                      "Zona Kuliah",
                      style: bB,
                    ),
                  ),
                  SizedBox(
                    width: widthB,
                    child: const Text(": BJB"),
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
                      "Jenis Kelas",
                      style: bB,
                    ),
                  ),
                  SizedBox(
                    width: widthB,
                    child: const Text(": REG"),
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
                    child: const Text(": TI"),
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
                        "Photo",
                        style: bB,
                      )),
                  SizedBox(
                      width: widthB - 100,
                      child: Image.network(
                          "https://ta.fti.uniska-bjm.ac.id/arsip/profile/17630204-profile.png"))
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
