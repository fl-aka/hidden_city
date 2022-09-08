import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hidden_city/gg/login/bigpedal.dart';
import 'package:hidden_city/gg/network_kominfo/widgetsutils/robot.dart';
import 'package:hidden_city/http/fb/google_sign_in.dart';
import 'package:hidden_city/main.dart';
import 'package:hidden_city/utils/widgets/floatingtext.dart';
import 'package:hidden_city/utils/widgets/glass.dart';
import 'package:flutter/services.dart';

class LoginMain extends StatefulWidget {
  const LoginMain({super.key});

  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain>
    with SingleTickerProviderStateMixin {
  late AnimationController _aniCon;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _password2 = TextEditingController();
  final FocusNode _focusU = FocusNode();
  final FocusNode _focusP = FocusNode();
  final FocusNode _focusP2 = FocusNode();
  bool _closing = false, _singUp = false, _verify = false;
  Color _textCol = Colors.black;
  Color _textCol2 = Colors.black;
  double _logoW = 0;

  @override
  void dispose() {
    _aniCon.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _aniCon =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _logoW = MediaQuery.of(context).size.width / 2.85;
    final double glassUi = MediaQuery.of(context).size.width * 0.877;
    var styleUp =
        TextStyle(color: _textCol2, fontFamily: 'Scramble', fontSize: 30);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox.expand(
              child: CustomPaint(painter: BgPainter(animation: _aniCon.view))),
          FloatingText(
            top: 15,
            left: MediaQuery.of(context).size.width - (_singUp ? 335 : 260),
            left2: MediaQuery.of(context).size.width - (_singUp ? 335 : 300),
            size: 35,
            subText: _singUp
                ? "Hope You'll Enjoy The Company"
                : 'I Hope You Find Your Way...',
            evolved: _singUp ? 'Hehehe~!' : 'Go Away~!',
            unevolved: _singUp ? 'Welcome Newcomer!' : 'Welcome Back!',
          ),
          SizedBox.expand(
            child: GestureDetector(
              onTap: () {
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

                _focusP.unfocus();
                _focusP2.unfocus();
                _focusU.unfocus();
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            child: _singUp
                ? GlassHour2(
                    glassUi: glassUi,
                    focusU: _focusU,
                    email: _email,
                    aniCon: _aniCon,
                    focusP: _focusP,
                    focusP2: _focusP2,
                    password: _password,
                    password2: _password2)
                : GlassHour1(
                    glassUi: glassUi,
                    focusU: _focusU,
                    email: _email,
                    aniCon: _aniCon,
                    focusP: _focusP,
                    password: _password),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height / 2 - glassUi / 1.428,
              left: MediaQuery.of(context).size.width / 2 - 150,
              child: SizedBox(
                width: 300,
                height: 140,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      top: 0,
                      left: 80,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: _logoW,
                        height: _logoW,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('assets/img/hiddencity.png')),
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.green, Colors.blue])),
                      ),
                    ),
                  ],
                ),
              )),
          Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onPanStart: (details) {
                  setState(() {
                    if (!_singUp) {
                      if (_email.text == '' || _password.text.length <= 8) {
                        _textCol = Colors.blue;
                        return;
                      }
                    } else {
                      if (_email.text == '' ||
                          _password.text.length < 8 ||
                          !_password.text.contains(RegExp(r'[0-9]')) ||
                          _password2.text == '') {
                        _textCol = Colors.blue;
                        return;
                      }
                    }
                    _textCol = Colors.red;
                  });
                },
                onPanEnd: (det) {
                  if (_singUp) {
                    if (_textCol == Colors.red) {
                      if (_password.text == _password2.text) {
                        signUp();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Password And Confirm Password Is not the same!")));
                      }
                    } else {
                      debugPrint(_textCol.toString());
                    }
                  } else {
                    if (_textCol == Colors.red) {
                      signIn();
                    }
                  }
                  setState(() {
                    _textCol = Colors.black;
                  });
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _singUp
                      ? Text(
                          'Register',
                          key: const ValueKey<int>(0),
                          style: TextStyle(
                              color: _textCol,
                              fontFamily: 'Scramble',
                              fontSize: 55),
                        )
                      : Text(
                          'Login',
                          key: const ValueKey<int>(1),
                          style: TextStyle(
                              color: _textCol,
                              fontFamily: 'Scramble',
                              fontSize: 55),
                        ),
                ),
              )),
          Positioned(
              bottom: 80,
              right: 20,
              child: GestureDetector(
                onPanStart: (details) {
                  setState(() {
                    _textCol2 = Colors.red;
                  });
                  if (_aniCon.value > 0 && !_closing) {
                    _aniCon.reverse(from: 1).then((value) {
                      _closing = false;
                    });
                    _closing = true;
                  }
                },
                onPanEnd: (det) {
                  setState(() {
                    _textCol2 = Colors.black;
                    _singUp = !_singUp;
                    _verify = false;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      'Sign ',
                      style: styleUp,
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) {
                        double x = _singUp ? -.5 : .5;
                        final tween = Tween<Offset>(
                                begin: Offset(0, x), end: const Offset(0, 0))
                            .animate(animation);
                        return SlideTransition(
                          position: tween,
                          child: child,
                        );
                      },
                      child: _singUp
                          ? Text(
                              'In',
                              key: const ValueKey<int>(0),
                              style: styleUp,
                            )
                          : Text(
                              'Up',
                              key: const ValueKey<int>(1),
                              style: styleUp,
                            ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Future signIn() async {
    loading(context);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.trim(), password: _password.text.trim());
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future signUp() async {
    loading(context);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text.trim(), password: _password.text.trim());
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

class GlassHour1 extends StatefulWidget {
  const GlassHour1({
    Key? key,
    required this.glassUi,
    required FocusNode focusU,
    required TextEditingController email,
    required AnimationController aniCon,
    required FocusNode focusP,
    required TextEditingController password,
  })  : _focusU = focusU,
        _email = email,
        _aniCon = aniCon,
        _focusP = focusP,
        _password = password,
        super(key: key);

  final double glassUi;
  final FocusNode _focusU;
  final TextEditingController _email;
  final AnimationController _aniCon;
  final FocusNode _focusP;
  final TextEditingController _password;

  @override
  State<GlassHour1> createState() => _GlassHour1State();
}

class _GlassHour1State extends State<GlassHour1> {
  String _hintMail = '', _hintPass = '';

  @override
  Widget build(BuildContext context) {
    return GlassHourUi(
        height: widget.glassUi,
        width: widget.glassUi,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  focusNode: widget._focusU,
                  controller: widget._email,
                  keyboardType: TextInputType.emailAddress,
                  onTap: () {
                    if (widget._aniCon.value == 0) {
                      widget._aniCon.forward(from: 0);
                    }
                    if (widget._email.text == '') {
                      _hintMail = "Type Your Email Please";
                    }
                  },
                  onChanged: (val) {
                    if (!widget._email.text.contains('@')) {
                      _hintMail = "There's no @, yet";
                    } else {
                      _hintMail = "";
                    }
                    setState(() {});
                  },
                  onEditingComplete: () {
                    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
                    widget._focusU.unfocus();
                  },
                  decoration:
                      InputDecoration(hintText: 'Email', helperText: _hintMail),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  focusNode: widget._focusP,
                  controller: widget._password,
                  onTap: () {
                    if (widget._aniCon.value == 0) {
                      widget._aniCon.forward(from: 0);
                    }
                    if (widget._password.text == '') {
                      _hintPass = "Type Your Password Please";
                    }
                  },
                  onChanged: (val) {
                    if (widget._password.text.length < 8) {
                      _hintPass = "Password Minimum length is 8";
                    } else if (!widget._password.text
                        .contains(RegExp(r'[0-9]'))) {
                      _hintPass = "Are you sure? Password need to have number";
                    } else {
                      _hintPass = "";
                    }
                    setState(() {});
                  },
                  onEditingComplete: () {
                    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
                    widget._focusP.unfocus();
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Password', helperText: _hintPass),
                ),
              ),
              Expanded(
                child: Center(
                    child: GestureDetector(
                  onTap: () {
                    debugPrint('ok');
                    GoogleSignInProvider().googleLogin();
                  },
                  child: Container(
                    height: widget.glassUi / 5,
                    width: widget.glassUi / 5,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, offset: Offset(2, 3))
                        ],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        image: const DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage('assets/img/google.png'))),
                  ),
                )),
              )
            ],
          ),
        ));
  }
}

class GlassHour2 extends StatelessWidget {
  const GlassHour2({
    Key? key,
    required this.glassUi,
    required FocusNode focusU,
    required TextEditingController email,
    required AnimationController aniCon,
    required FocusNode focusP,
    required FocusNode focusP2,
    required TextEditingController password,
    required TextEditingController password2,
  })  : _focusU = focusU,
        _email = email,
        _aniCon = aniCon,
        _focusP = focusP,
        _password = password,
        _focusP2 = focusP2,
        _password2 = password2,
        super(key: key);

  final double glassUi;
  final FocusNode _focusU;
  final TextEditingController _email;
  final AnimationController _aniCon;
  final FocusNode _focusP;
  final TextEditingController _password;
  final FocusNode _focusP2;
  final TextEditingController _password2;

  @override
  Widget build(BuildContext context) {
    return GlassHourUi(
        height: glassUi,
        width: glassUi,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  focusNode: _focusU,
                  controller: _email,
                  onTap: () {
                    if (_aniCon.value == 0) {
                      _aniCon.forward(from: 0);
                    }
                  },
                  onEditingComplete: () {
                    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
                    _focusU.unfocus();
                  },
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  focusNode: _focusP,
                  controller: _password,
                  onTap: () {
                    if (_aniCon.value == 0) {
                      _aniCon.forward(from: 0);
                    }
                  },
                  onEditingComplete: () {
                    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
                    _focusP.unfocus();
                  },
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'Password'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  focusNode: _focusP2,
                  controller: _password2,
                  onTap: () {
                    if (_aniCon.value == 0) {
                      _aniCon.forward(from: 0);
                    }
                  },
                  onEditingComplete: () {
                    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
                    _focusP2.unfocus();
                  },
                  obscureText: true,
                  decoration:
                      const InputDecoration(hintText: 'Confirm Password'),
                ),
              ),
            ],
          ),
        ));
  }
}
