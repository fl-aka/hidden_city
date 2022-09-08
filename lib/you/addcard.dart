import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hidden_city/gg/network_kominfo/widgetsutils/spcbutton.dart';
import 'package:hidden_city/utils/backend/honeys/card.dart';

class AddMoreCandy extends StatefulWidget {
  const AddMoreCandy({super.key});

  @override
  State<AddMoreCandy> createState() => _AddMoreCandyState();
}

class _AddMoreCandyState extends State<AddMoreCandy> {
  var oni = Hive.box('MoneyCards');
  var gin = Hive.box('MoneyHistory');
  File? image;
  bool _paylaterEnable = false, _renNow = false;

  final _namaCon = TextEditingController(text: '');
  final _saldoCon = TextEditingController(text: '');
  final _paylaterCon = TextEditingController(text: '');
  final _paylaterMaxCon = TextEditingController(text: '');
  final _webCon = TextEditingController(text: 'https://');
  final _focNam = FocusNode();
  final _focSal = FocusNode();
  final _focPay = FocusNode();
  final _focPayX = FocusNode();
  final _focWeb = FocusNode();

  Color hexCol = Colors.grey;
  Future pickImage(ImageSource lead) async {
    try {
      final imageP = await ImagePicker().pickImage(source: lead);
      if (imageP == null) return;

      final imageTempo = File(imageP.path);
      setState(() {
        image = imageTempo;
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to Pick Image : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox.expand(
        child: ListView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: (image != null)
                    ? Image.file(
                        image!,
                        fit: BoxFit.cover,
                        height: 200,
                        width: 200,
                      )
                    : const Icon(Icons.account_circle,
                        size: 200, color: Colors.blue),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: spcButton(
                      doThisQuick: () => pickImage(ImageSource.gallery),
                      child: Row(
                        children: const [
                          Text("Gallery"),
                          Spacer(),
                          Icon(FontAwesomeIcons.photoFilm, size: 15),
                        ],
                      ),
                    )),
              ),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: spcButton(
                      doThisQuick: () => pickImage(ImageSource.camera),
                      child: Row(
                        children: const [
                          Text("Camera"),
                          Spacer(),
                          Icon(FontAwesomeIcons.cameraRetro, size: 15),
                        ],
                      ),
                    )),
              )
            ],
          ),
          textField(1, _namaCon, 'Nama Kartu', focus: _focNam),
          textField(1, _saldoCon, 'Saldo',
              mode: TextInputType.number, focus: _focSal),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                  value: _paylaterEnable,
                  onChanged: (val) {
                    _paylaterEnable = !_paylaterEnable;
                    if (!_paylaterEnable) {
                      _renNow = false;
                    }
                    setState(() {});
                  }),
              textMng("Pay Later Credit ?", insideBubble),
            ],
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: !_paylaterEnable ? 0 : 200,
            width: !_paylaterEnable ? 0 : lebar - 50,
            onEnd: () {
              setState(() {
                if (_paylaterEnable) {
                  _renNow = true;
                  return;
                }
                _renNow = false;
              });
            },
            child: _renNow
                ? Column(
                    children: [
                      textField(1, _paylaterMaxCon, 'Maximal Paylater',
                          mode: TextInputType.number, focus: _focPayX),
                      textField(1, _paylaterCon, 'Used Paylater',
                          mode: TextInputType.number, focus: _focPay),
                    ],
                  )
                : const Center(),
          ),
          textField(1, _webCon, 'Website Kartu', focus: _focWeb),
          Row(
            children: [
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: spcButton(
                      doThisQuick: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: const [
                          Text("Kembali"),
                          Spacer(),
                          Icon(Icons.keyboard_return, size: 15),
                        ],
                      ),
                    )),
              ),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: spcButton(
                      color: hexCol,
                      doThisQuick: () {
                        if (hexCol == const Color.fromARGB(255, 250, 141, 98) &&
                            image != null) {
                          try {
                            Uint8List temp = image!.readAsBytesSync();
                            Cards newCard = Cards(
                                _namaCon.text,
                                temp,
                                double.parse(_saldoCon.text.trim()),
                                _paylaterEnable,
                                _paylaterEnable
                                    ? double.parse(_paylaterCon.text.trim())
                                    : 0,
                                _paylaterEnable
                                    ? double.parse(_paylaterMaxCon.text.trim())
                                    : 0,
                                _webCon.text,
                                DateTime.now());
                            oni.add(newCard);
                            List<Cards> history = [];
                            history.add(newCard);
                            gin.add(history);
                            image = null;
                            _namaCon.text = '';
                            _paylaterCon.text = '';
                            _paylaterMaxCon.text = '';
                            _webCon.text = '';
                            _saldoCon.text = '';
                            _changeCol();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text("Kartu Berhasil Dibuat")));
                          } on Exception {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                        "Ada Kesalahan, Mohon coba lagi")));
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      child: Row(
                        children: const [
                          Text("Tambah"),
                          Spacer(),
                          Icon(Icons.add, size: 15),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ]),
      ),
    );
  }

  void _changeCol() {
    if (_namaCon.text != '' &&
        _saldoCon.text != '' &&
        _webCon.text != '' &&
        image != null) {
      if (_paylaterEnable &&
          _paylaterCon.text == '' &&
          _paylaterMaxCon.text == '') {
        return;
      }
      try {
        double.parse(_saldoCon.text.trim());
        if (_paylaterEnable) {
          double.parse(_paylaterCon.text.trim());
          double.parse(_paylaterMaxCon.text.trim());
        }
        setState(() {
          hexCol = const Color.fromARGB(255, 250, 141, 98);
        });
      } catch (e) {
        setState(() {
          hexCol = Colors.grey;
        });
      }
    }
  }

  Padding textMng(String text, TextStyle style) => Padding(
        padding: const EdgeInsets.only(bottom: 5, top: 5),
        child: Text(
          text,
          style: style,
        ),
      );
  TextStyle insideBubble = const TextStyle(fontSize: 16, color: Colors.black);
  Padding textField(int maxLn, TextEditingController con, String hintText,
          {FocusNode? focus,
          bool? enabled,
          TextInputType? mode,
          int maxs = 30}) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onTap: () {
            _changeCol();
          },
          onEditingComplete: () {
            _changeCol();
            if (focus != null) {
              focus.unfocus();
            }
          },
          maxLength: maxs,
          keyboardType: mode,
          enabled: (enabled != null) ? enabled : true,
          focusNode: (focus != null) ? focus : null,
          maxLines: maxLn,
          style: const TextStyle(fontSize: 18),
          controller: con,
          decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: Colors.grey.shade100,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
      );
}
