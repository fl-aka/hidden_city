import 'package:flutter/material.dart';
import 'package:ta_uniska_bjm/gg/random/myhomepage.dart';
import 'package:ta_uniska_bjm/gg/hubworld/hubworld.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _login = TextEditingController();
  final _pass = TextEditingController();
  bool _check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(56, 194, 242, 1),
        body: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Center(
                  child: Text("LOGIN",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: "RobotoB"))),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 5,
                    child: Container(
                      width: 375,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 20),
                              child: Text("Login Untuk Memulai Sesi",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Roboto",
                                      fontStyle: FontStyle.normal)),
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.only(left: 20, right: 15.0),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(
                                  width: 290,
                                  child: TextField(
                                    controller: _login,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.only(left: 20, right: 15.0),
                                  child: Icon(
                                    Icons.lock,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(
                                  width: 290,
                                  child: TextField(
                                    obscureText: true,
                                    controller: _pass,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 12, left: 8, right: 25),
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: _check,
                                      onChanged: (_) {
                                        _check = !_check;
                                        setState(() {});
                                      }),
                                  const Text(
                                    "Remember Me",
                                    style: TextStyle(
                                        fontFamily: "Roboto", fontSize: 14),
                                  ),
                                  const Spacer(),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(
                                              250, 5, 148, 1)),
                                      onPressed: () {
                                        if (_login.text == "17630204" &&
                                            _pass.text == "LastHero35") {
                                          _login.text = "";
                                          _pass.text = "";
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  settings: const RouteSettings(
                                                      name: "/login"),
                                                  builder: (_) =>
                                                      const MyHomePage(
                                                          title: 0)));
                                        }
                                        if (_login.text == "IWant2Paint" &&
                                            _pass.text == "MyLove2U") {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const HubWorld(
                                                          where: 0)));
                                        }
                                      },
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(
                                            fontFamily: "Roboto",
                                            color: Colors.white,
                                            fontSize: 14),
                                      ))
                                ],
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    right: 25, bottom: 20, top: 10),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      Text("Lupa Password ?",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color.fromRGBO(
                                                  56, 194, 240, 1)))
                                    ]))
                          ]),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
