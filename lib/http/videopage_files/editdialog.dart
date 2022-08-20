import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ta_uniska_bjm/utils/backend/honeys/urlpath.dart';

class EditBox extends StatelessWidget {
  const EditBox(
      {Key? key,
      required TextEditingController newLabel,
      required TextEditingController newLink,
      required this.urlPaths,
      required this.index})
      : _newLabel = newLabel,
        _newLink = newLink,
        super(key: key);

  final TextEditingController _newLabel;
  final TextEditingController _newLink;
  final Box urlPaths;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 270,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Masukan Data Baru",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 35,
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _newLabel,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Masukan Label",
              ),
            ),
            TextField(
              controller: _newLink,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Masukan Link",
              ),
            ),
            SizedBox(
              width: 320,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.red;
                  }
                  return Colors.lightBlue;
                })),
                onPressed: () {
                  urlPaths.putAt(index, UrlPath(_newLink.text, _newLabel.text));
                },
                child: const Text(
                  "Confirm",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
