import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

/// Cloud Storage周りの処理をまとめたService
class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // ex: './data/.../.../sample.jpeg' -> 'sample.jpeg'
  String _imageFileName(File imageFile) => imageFile.path.split('/').last;

  /// 画像をCloud Storageに保存して、保存先のURLを返している。
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
