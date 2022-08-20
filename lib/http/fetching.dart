// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

typedef Moradelema = void Function(bool justice, String hero);
typedef Arival = void Function(String hero);

class ActionLawsuit {
  final Moradelema action;
  final Arival heroIsHere;
  const ActionLawsuit({required this.action, required this.heroIsHere});

  Future<void> doConnect(
      TextEditingController ip, BuildContext context, bool connect) async {
    try {
      Uri dophp = Uri.parse("http://${ip.text}/linerdraw/all.php");
      final respone = await http
          .post(dophp, body: {'key': 'TortoiseKnight', 'action': 'connect'});
      if (respone.body == '"Connected"') {
        connect = true;
        action(connect, ip.text);
      } else {
        int r = 0;
        for (int i = 0; i < ip.text.length; i++) {
          if (ip.text[i] == '.') r = i;
        }
        ip.text = ip.text.substring(0, r + 1);
        Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: (builder) => AlertDialog(
                  content: Text(respone.body),
                  title: const Text("Error"),
                ));
      }
    } catch (e) {
      if (!connect) {
        int r = 0;
        for (int i = 0; i < ip.text.length; i++) {
          if (ip.text[i] == '.') r = i;
        }
        ip.text = ip.text.substring(0, r + 1);
        Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: (builder) => AlertDialog(
                  content: Text(e.toString()),
                  title: const Text("Error"),
                ));
      }
    }
  }

  Future<void> makeRoom(String ipIs, String token, String roomName,
      String answer, BuildContext context) async {
    try {
      String player =
          '[{"player" : "$token", "activeT" : "${DateTime.now().toString()}", "role" : "drawer"}]';
      Uri dophp = Uri.parse("http://$ipIs/linerdraw/all.php");

      final returner = await http.post(dophp, body: {
        'action': 'makeRoom',
        'key': 'TortoiseKnight',
        'token': token,
        'roomName': roomName,
        'player': player,
        'answer': answer
      });
      if (returner.body == 'Sucess') {
        heroIsHere(returner.body);
      } else {
        showDialog(
            context: context,
            builder: (builder) => AlertDialog(
                  content: Text(returner.body),
                  title: const Text("Sum Ting Wung"),
                ));
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (builder) => AlertDialog(
                content: Text(e.toString()),
                title: const Text("Error"),
              ));
    }
  }

  Future<void> joinRoom(String ipIs, String token, String roomId, String player,
      BuildContext context) async {
    String P = player.substring(0, player.length - 1);
    P +=
        ', {"player" : "$token", "activeT" : "${DateTime.now().toString()}", "role" : "guesser"}]';
    Uri dophp = Uri.parse("http://$ipIs/linerdraw/all.php");
    final returner = await http.post(dophp, body: {
      'action': 'joinRoom',
      'key': 'TortoiseKnight',
      'roomId': roomId,
      'player': P,
    });

    if (returner.body == 'Sucess') {
      heroIsHere(returner.body);
    } else {
      showDialog(
          context: context,
          builder: (builder) => AlertDialog(
                content: Text(returner.body),
                title: const Text("Sum Ting Wung"),
              ));
    }
  }

  Future<void> checkPoint(String ipIs, String token, String roomId,
      String player, BuildContext context) async {
    String P = player.substring(0, player.length - 1);
    P +=
        ', {"player" : "$token", "activeT" : "${DateTime.now().toString()}", "role" : "guesser"}]';
    Uri dophp = Uri.parse("http://$ipIs/linerdraw/all.php");
    final returner = await http.post(dophp, body: {
      'action': 'checkPoint',
      'key': 'TortoiseKnight',
      'roomId': roomId,
      'player': P,
    });

    if (returner.body == 'Sucess') {
      heroIsHere(returner.body);
    } else {
      showDialog(
          context: context,
          builder: (builder) => AlertDialog(
                content: Text(returner.body),
                title: const Text("Sum Ting Wung"),
              ));
    }
  }

  Future<List<dynamic>?> getPlayer(
      String ipIs, String roomId, BuildContext context) async {
    try {
      Uri dophp = Uri.parse("http://$ipIs/linerdraw/all.php");
      final play = await http.post(dophp, body: {
        'action': 'getPlayer',
        'key': 'TortoiseKnight',
        'roomId': roomId
      });
      List<dynamic> A = jsonDecode(play.body);
      List<dynamic> Q = jsonDecode(A[0]['players']);
      return Q;
    } catch (e) {
      showDialog(
          context: context,
          builder: (builder) => AlertDialog(
                content: Text(e.toString()),
                title: const Text("Get Player Error"),
              ));
    }
    return null;
  }

  Future<void> getPoints(
      String ipIs, String roomId, BuildContext context) async {
    try {
      Uri dophp = Uri.parse("http://$ipIs/linerdraw/all.php");
      final play = await http.post(dophp, body: {
        'action': 'getLine',
        'key': 'TortoiseKnight',
        'roomId': roomId
      });
      List<dynamic> A = jsonDecode(play.body);
      if (A[0]['pointo'] != null) {
        heroIsHere(A[0]['pointo']);
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (builder) => AlertDialog(
                content: Text(e.toString()),
                title: const Text("Get Point Error"),
              ));
    }
  }

  Future<List<dynamic>?> getAnswer(
      String ipIs, String roomId, BuildContext context) async {
    try {
      Uri dophp = Uri.parse("http://$ipIs/linerdraw/all.php");
      final play = await http.post(dophp, body: {
        'action': 'getAnswer',
        'key': 'TortoiseKnight',
        'roomId': roomId
      });
      List<dynamic> A = jsonDecode(play.body);
      return A;
    } catch (e) {
      showDialog(
          context: context,
          builder: (builder) => AlertDialog(
                content: Text(e.toString()),
                title: const Text("Get Answer Error"),
              ));
    }
    return null;
  }

  Future<void> sendLine(
      String ipIs, String line, String roomId, BuildContext context) async {
    Uri dophp = Uri.parse("http://$ipIs/linerdraw/all.php");
    final returner = await http.post(dophp, body: {
      'action': 'sendPoint',
      'key': 'TortoiseKnight',
      'roomId': roomId,
      'points': line,
    });

    if (returner.body == 'Sucess') {
    } else {
      showDialog(
          context: context,
          builder: (builder) => AlertDialog(
                content: Text(returner.body),
                title: const Text("Sum Ting Wung Sending Line"),
              ));
    }
  }

  Future<void> keepRoom(String ipIs, String token, String roomId, bool boolWin,
      BuildContext context) async {
    Uri dophp = Uri.parse("http://$ipIs/linerdraw/all.php");
    List<dynamic>? Q = await getPlayer(ipIs, roomId, context);
    for (int i = 0; i < Q!.length; i++) {
      if (Q[i]['player'] == token) {
        Q[i]['activeT'] = DateTime.now().toString();
        if (boolWin) {
          Q[i]['role'] = "winner";
        }
        heroIsHere(Q[i]['role']);
      }
    }
    String stringP = '[';
    for (int i = 0; i < Q.length; i++) {
      String activeT = Q[i]['activeT'];
      String tokenI = Q[i]['player'];
      String role = Q[i]['role'];
      if (!DateTime.now()
          .isAfter(DateTime.parse(activeT).add(const Duration(seconds: 6)))) {
        stringP +=
            '{"player" : "$tokenI", "activeT" : "$activeT", "role" : "$role"},';
      }
    }
    if (stringP != '[') stringP = stringP.substring(0, stringP.length - 1);
    stringP += ']';
    final returner = await http.post(dophp, body: {
      'action': 'joinRoom',
      'key': 'TortoiseKnight',
      'roomId': roomId,
      'player': stringP,
    });

    if (returner.body != 'Sucess') {
      showDialog(
          context: context,
          builder: (builder) => AlertDialog(
                content: Text(returner.body),
                title: const Text("Sum Ting Wung"),
              ));
    }
  }

  Future<List?> getRoom(String ipIs, BuildContext context) async {
    String ponProblemRoom = "";
    Uri dophp = Uri.parse("http://$ipIs/linerdraw/all.php");
    try {
      final selector = await http.post(dophp, body: {
        'action': 'getAllPlayer',
        'key': 'TortoiseKnight',
      });
      List<dynamic> newS = jsonDecode(selector.body);
      bool delRoom = false;
      for (int i = 0; newS.length > i; i++) {
        ponProblemRoom = newS[i]['id'];
        List<dynamic> selector = jsonDecode(newS[i]['players']);
        if (selector.isEmpty) {
          delRoom = true;
        }
        for (int y = 0; selector.length > y; y++) {
          DateTime exam = DateTime.parse(selector[y]["activeT"]);

          if (DateTime.now().isAfter(exam.add(const Duration(seconds: 15)))) {
            delRoom = true;
          } else {
            delRoom = false;
          }
        }
        if (delRoom) {
          await http.post(dophp, body: {
            'action': 'deleteRoom',
            'roomId': newS[i]['id'],
            'key': 'TortoiseKnight',
          });
        }
      }
      final returner = await http.post(dophp, body: {
        'action': 'checkRoom',
        'key': 'TortoiseKnight',
      });
      return jsonDecode(returner.body);
    } catch (e) {
      showDialog(
          context: context,
          builder: (builder) => AlertDialog(
                content: Text(e.toString()),
                title: const Text("Get Room Error"),
              ));
      if (ponProblemRoom != "") {
        await http.post(dophp, body: {
          'action': 'deleteRoom',
          'roomId': ponProblemRoom,
          'key': 'TortoiseKnight',
        });
      }
      return null;
    }
  }
}
