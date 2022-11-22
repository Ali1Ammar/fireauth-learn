import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  Future<String> uploadFile(String fileName, String path) async {
    final storageRef =
        FirebaseStorage.instance.ref("images").child("user").child("profile");
    // final dateTime = DateTime.now().millisecondsSinceEpoch;
    final ref = storageRef.child(fileName);
    await ref.putFile(File(path));
    return ref.getDownloadURL();
  }
}
