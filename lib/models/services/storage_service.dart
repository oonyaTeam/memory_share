import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String _imageFileName(File imageFile) => imageFile.path.split('/').last;

  Future<String> uploadImage(File imageFile) async {
    final String fileName = _imageFileName(imageFile);
    final url = await _storage
        .ref('images')
        .child(fileName)
        .putFile(imageFile)
        .then((snapshot) => snapshot.ref.getDownloadURL());
    return url;
  }
}
