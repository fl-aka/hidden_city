import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FireStoreDataBase {
  String? downloadURL;

  Future getData(String name) async {
    try {
      await downloadURLExample(name);
      return downloadURL;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  Future<void> downloadURLExample(String name) async {
    downloadURL =
        await FirebaseStorage.instance.ref().child(name).getDownloadURL();
    debugPrint(downloadURL.toString());
  }
}
