
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserModel with ChangeNotifier {

  final picker = ImagePicker();

  File _photo;

  File get photo => _photo;

  void setPhoto(File photo) {
    _photo = photo;
  }

}