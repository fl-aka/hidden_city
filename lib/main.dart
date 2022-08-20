import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ta_uniska_bjm/utils/backend/registadapt.dart';
import 'package:ta_uniska_bjm/utils/plainVar/firebaseoptions.dart';
import 'package:ta_uniska_bjm/gg/login/wrapper.dart';
import 'gg/random/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: webby,
    );
    runApp(const MyApp());
  } else if (Platform.isAndroid) {
    await regisTnAdpt();
    await Firebase.initializeApp(
      options: knull,
    );
    runApp(const Belphegor());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TA',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const LoginPage(),
    );
  }
}

final navigatorKey = GlobalKey<NavigatorState>();

class Belphegor extends StatelessWidget {
  const Belphegor({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Shanbara',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Wrapper());
  }
}
