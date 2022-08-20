import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ta_uniska_bjm/gg/random/login.dart';
import 'package:ta_uniska_bjm/utils/testing/textani/receive.dart';

class Routes {
  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc: (context, param) {
      debugPrint("Router Not Found");
      return const RouterNotFound();
    });
    router.define('/',
        handler: Handler(handlerFunc: (context, param) => const LoginPage()));
    router.define('/home',
        handler: Handler(handlerFunc: (context, param) => const LoginPage()));
    router.define('/msg/:text',
        transitionType: TransitionType.materialFullScreenDialog,
        handler: Handler(handlerFunc: (_, param) {
      String? text = param["text"]?.first;
      debugPrint(text);

      CollectionReference flight = FirebaseFirestore.instance.collection('msg');

      return FutureBuilder<DocumentSnapshot>(
        future: flight.doc(text).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            return const Text("Something went wrong");
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return Receive(memo: data['text']);
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }));
  }
}

class RouterNotFound extends StatelessWidget {
  const RouterNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          "404",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
