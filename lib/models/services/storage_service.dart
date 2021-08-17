import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File imageFile) async {
    final url = await _storage.ref('images').putFile(imageFile).then((snapshot) =>
      snapshot.ref.getDownloadURL());
    return url;
  }
}