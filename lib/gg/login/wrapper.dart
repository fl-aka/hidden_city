import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hidden_city/gg/hubworld/hubworld.dart';
import 'package:hidden_city/gg/login/login_page.dart';
import 'package:hidden_city/utils/widgets/floatingtext.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const FloatingText(
              tittle: 'Error, ',
              unevolved: 'Something Wrong!',
              evolved: 'Error!~',
              subText: 'Something Went Wrong',
            );
          }
          if (snapshot.hasData) {
            return const HubWorld();
          } else {
            return const LoginMain();
          }
        });
  }
}
