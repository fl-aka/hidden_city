import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class DownloadFromFb {
  String? downloadUrl;

  Future<String> getData(String filename) async {
    try {
      await downloadUrlFunc(filename);
      return downloadUrl!;
    } catch (e) {
      debugPrint("Error : $e");
      return " ";
    }
  }

  Future<void> downloadUrlFunc(String filename) async {
    downloadUrl =
        await FirebaseStorage.instance.ref().child(filename).getDownloadURL();
    debugPrint(downloadUrl);
  }
}
