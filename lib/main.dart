import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hidden_city/utils/backend/registadapt.dart';
import 'package:hidden_city/http/fluro/router.dart';
import 'package:hidden_city/utils/plainVar/firebaseoptions.dart';
import 'package:hidden_city/gg/login/wrapper.dart';
import 'gg/random/login.dart';
import 'package:fluro/fluro.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class NavUtils {
  NavUtils._();
  static String? get initialUrl => html.window.location.pathname;
}

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
  final router = FluroRouter();

  @override
  void initState() {
    Routes.configureRoutes(router);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TA',
      initialRoute: NavUtils.initialUrl,
      onGenerateRoute: router.generator,
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
