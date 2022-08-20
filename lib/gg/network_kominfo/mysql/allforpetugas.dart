import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

typedef Moradelema = void Function(bool justice);

class CapelessHero {
  final Moradelema action;
  const CapelessHero({required this.action});

  Future<List> getPetugas(String aIPhi, TextEditingController cariCon) async {
    try {
      Uri dophp = Uri.parse("http://$aIPhi/jaringan/conn/doPetugas.php");
      final respone = await http.post(dophp, body: {
        'key': 'RahasiaIlahi',
        'action': 'getAllData',
        'cari': cariCon.text
      });
      List<dynamic> list = jsonDecode(respone.body);

      if (list.isNotEmpty) {
        action(false);
      }
      return list;
    } catch (e) {
      action(true);
      return <String>[];
    }
  }

  Future<List> getNama(String aIPhi, String email) async {
    try {
      Uri dophp = Uri.parse("http://$aIPhi/jaringan/conn/doPetugas.php");
      final respone = await http.post(dophp,
          body: {'key': 'RahasiaIlahi', 'action': 'getName', 'cari': email});
      List<dynamic> list = jsonDecode(respone.body);
      return list;
    } catch (e) {
      return <String>[];
    }
  }
}
