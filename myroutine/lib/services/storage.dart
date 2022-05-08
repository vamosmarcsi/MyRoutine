import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final storage = FirebaseStorage.instance;

  Future<void> uploadProfilePic(String fPath, String fName) async {
    File file = File(fPath);

    try {
      await storage.ref(fName).putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<String> downloadProfilePicURL(String imageName) async {
    String downloadURL = await storage.ref(imageName).getDownloadURL();
    return downloadURL;
  }
}
