import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class ImageStorageController extends ChangeNotifier {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future storeImage(String uid, File image) async {
    final storageRef = _storage.ref();
    final profilePicRef = storageRef.child(uid);
    try {
      await profilePicRef.putFile(image);
      await profilePicRef.getDownloadURL().then((value) => print(value));
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }
}
